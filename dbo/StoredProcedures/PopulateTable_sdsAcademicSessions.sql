CREATE PROC [dbo].[PopulateTable_sdsAcademicSessions] AS
BEGIN
 
DECLARE @CurrYr AS VARCHAR(4)
DECLARE @PrevYr AS VARCHAR(4)


select @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
select @PrevYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr'


TRUNCATE TABLE [dbo].sdsTerms

INSERT INTO [dbo].sdsTerms

--academicSessions.csv
SELECT C.AcademicYearName + P.Term as sourcedId
      ,P.Name as title
	  ,periodtype as type
	  ,C.AcademicYearName as schoolYear
	  ,convert(varchar,min(P.startDate),23) as startDate
	  ,convert(varchar,max(P.endDate),23) as endDate
	  ,1 AS CurrentYear
--INTO sdsTerms
  FROM emin.AcPeriod P inner join
       sds.staging_COAcYear C ON P.CalendarAcademicYearId = c.CalendarAcademicYearId
  where AcademicYearName = @CurrYr
    and PeriodType = 'Term'
group by C.AcademicYearName,P.Term,P.Name,periodtype
UNION 
SELECT C.AcademicYearName + 'SY' as sourcedId
      ,C.AcademicYearName + ' School Year' as title
	  ,'schoolYear' as type
	  ,C.AcademicYearName as schoolYear
	  ,convert(varchar,min(P.startDate),23) as startDate
	  ,convert(varchar,max(P.endDate),23) as endDate
	  ,1 AS CurrentYear
  FROM emin.AcPeriod P inner join
       sds.staging_COAcYear C ON P.CalendarAcademicYearId = c.CalendarAcademicYearId
  where AcademicYearName = @CurrYr
    and PeriodType = 'Term'
group by C.AcademicYearName,periodtype
UNION 
SELECT C.AcademicYearName + 'SY' as sourcedId
      ,C.AcademicYearName + ' School Year' as title
	  ,'schoolYear' as type
	  ,C.AcademicYearName as schoolYear
	  ,convert(varchar,min(P.startDate),23) as startDate
	  ,convert(varchar,max(P.endDate),23) as endDate
	  ,0 AS CurrentYear
  FROM emin.AcPeriod P inner join
       sds.staging_COAcYear C ON P.CalendarAcademicYearId = c.CalendarAcademicYearId
  where AcademicYearName = @PrevYr
    and PeriodType = 'Term'
group by C.AcademicYearName,periodtype
UNION 
SELECT C1.AcademicYearName + '_' + C2.AcademicYearName + 'SY' as sourcedId
      ,C1.AcademicYearName + '_' + C2.AcademicYearName + ' School Year' as title
	  ,'schoolYear' as type
	  ,C2.AcademicYearName as schoolYear
	  ,convert(varchar,min(P1.startDate),23) as startDate
	  ,convert(varchar,max(P2.endDate),23) as endDate
	  ,1 AS CurrentYear
  FROM emin.AcPeriod P1 inner join
       sds.staging_COAcYear C1 ON P1.CalendarAcademicYearId = C1.CalendarAcademicYearId,
	   emin.AcPeriod P2 inner join
       sds.staging_COAcYear C2 ON P2.CalendarAcademicYearId = C2.CalendarAcademicYearId
  where C1.AcademicYearName = @PrevYr
    and P1.PeriodType = 'Term'
    and C2.AcademicYearName = @CurrYr
    and P2.PeriodType = 'Term'
group by C1.AcademicYearName,C2.AcademicYearName

--cleanse
delete from sdsTerms
where CurrentYear = 0
and GETDATE() > DATEADD(wk,4,@CurrYr)


END
GO

