CREATE PROC [dbo].[PopulateTable_sdsStudent] @Env [varchar](4) AS
BEGIN

DECLARE @YearStart DATETIME2
DECLARE @YearEnd DATETIME2
DECLARE @StudentEmailDomain varchar(25) 
DECLARE @CurrYr AS VARCHAR(4)
DECLARE @PrevYr AS VARCHAR(4)

SELECT @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
SELECT @PrevYr = ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr' 


SELECT @YearStart = min(P.startDate),@YearEnd = max(P.endDate)
FROM emin.AcPeriod P inner join
     sds.staging_COAcYear C ON P.CalendarAcademicYearId = c.CalendarAcademicYearId
where AcademicYearName = @CurrYr  and PeriodType = 'Term'

select @StudentEmailDomain = ParameterValue from sds_sp_Parameters where commonParameter = 'StudentEmailDomain' and ParameterName = @Env

TRUNCATE TABLE [dbo].[sdsStudent]


INSERT INTO [dbo].[sdsStudent]
--Student.csv
select 'Student'+cast([SIS ID] AS varchar) AS [SIS ID]
	  ,[School SIS ID]
      ,[Username]
	  ,[First Name]
	  ,[Last Name]
	  ,[Middle Name]
	  ,[Student Number]
	  ,CASE [Grade] WHEN '00' THEN 'PR' WHEN '0' THEN 'PR' ELSE [Grade] END AS [Grade]
	  ,[Status]
	  ,convert(varchar,EnrolStart,23) AS EnrolStart
	  ,convert(varchar,EnrolEnd,23) AS EnrolEnd
	  ,FTE
	  ,case /*when [Grade] = 12 and EnrolStart between @YearStart and @YearEnd THEN @PreviousYear + '_' + @CurrentYear */
	        when EnrolStart between @YearStart and @YearEnd THEN @CurrYr
			ELSE @PrevYr 
       END + 'SY' as sessionSourcedId
--	into #Student
	from 
	(
		select   [SIS ID]
			,Campus as [School SIS ID]
			,[Login] + @StudentEmailDomain as [Username]
			,[First Name]
			,[Last Name]
			,[Middle Name]
			,AltStudentNo as [Student Number]
			,[Grade]
			,[EnrolStatus] as Status
			,EnrolStart
			,EnrolEnd
			,FTE
			,ROW_NUMBER() OVER(PARTITION BY [SIS ID] ORDER BY [SIS ID],[Order]) AS RowNumber 
		FROM [dbo].[temp_Staging_Students]
	) Stud
end
GO

