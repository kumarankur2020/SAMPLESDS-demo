CREATE PROC [dbo].[PopulateTable_sdsSections] AS
BEGIN

DECLARE @CurrYr AS VARCHAR(4), @PrevYr AS VARCHAR(4)
DECLARE @Today int = year(getdate())

select @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
select @PrevYr = ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr'   


TRUNCATE TABLE [dbo].[sdsSections]

INSERT INTO [dbo].[sdsSections]

--Section.csv
SELECT CASE WHEN Q.Year11_TimetableID is not null then Year11_TimetableID else [SIS ID] end as [SIS ID]
      ,[School SIS ID]
	  ,REPLACE(case when Q.TimetableName is not null then TimetableName else [Section Name] end,'?','') AS [Section Name]
	  ,REPLACE(case when Q.TimetableName is not null then TimetableName else [Section Name] end,'?','') AS [Section Number]
	  ,[Course SIS ID]
	  ,[Course Name]
	  ,[Course Number]
	  ,CASE WHEN Q.EffectiveStartDate is not null then convert(varchar,EffectiveStartDate,106) else [Term StartDate] end as [Term StartDate]
	  ,CASE WHEN Q.EffectiveEndDate is not null then convert(varchar,EffectiveEndDate,106) else [Term EndDate] end as [Term EndDate]
	  ,/*case WHEN Q.EffectiveStartDate < @YearStart then @PreviousYear + '_' else '' end + */ @CurrYr+ 'SY' AS TermId
	  ,CASE LearningAreaCode
	        WHEN 'LA001' THEN 23
			WHEN 'LA002' THEN 5
			WHEN 'LA003' THEN 2
			WHEN 'LA004' THEN 8
			WHEN 'LA005' THEN 1
			WHEN 'LA006' THEN 24
			WHEN 'LA007' THEN 7
			WHEN 'LA009' THEN 3
			WHEN 'LA013' THEN 22
			WHEN 'LA014' THEN 4
			WHEN 'LA015' THEN 22
			WHEN 'LA010' THEN CASE WHEN [Course Name] like '%Digital%' THEN 10
								   WHEN [Course Name] like '%Information%' THEN 10
								   WHEN [Course Name] like '%Food%' THEN 18
								   WHEN [Course Name] like '%Hospitality%' THEN 16
								   ELSE 21
			                  END
			ELSE 22
	  END as [Subject]
FROM (
SELECT SECTIONS.[SIS ID]
      ,SECTIONS.[School SIS ID]
      ,CASE WHEN SECTIONS.[Year] = 'Previous' THEN @CurrYr+ '_' + t.timetablename ELSE t.timetablename END as [Section Name]
	  ,CASE WHEN TimetableType = 'homegroup' THEN '100000' ELSE tm.TimetableModuleID END AS [Course SIS ID]
	  ,CASE WHEN TimetableType = 'homegroup' THEN 'Home Group' ELSE m.[Name] END AS [Course Name]
	  ,CASE WHEN TimetableType = 'homegroup' THEN 'HGR_' + t.timetablename ELSE tm.Module END AS [Course Number]
	  ,[Term StartDate]
	  ,[Term EndDate]
	  ,mla.LearningAreaCode
	  ,ROW_NUMBER() OVER(PARTITION BY [SIS ID] ORDER BY [SIS ID],CASE WHEN TimetableType = 'homegroup' THEN '100000' ELSE tm.TimetableModuleID END) AS RowNumber 
FROM (
select t.TimetableID AS [SIS ID]
      ,t.Campus AS [School SIS ID]
	  ,'Current' AS [Year]
	  ,convert(varchar,min(tv.EffectiveStartDate),106) as [Term StartDate]
	  ,convert(varchar,max(tv.EffectiveEndDate),106) as [Term EndDate] 
	  ,convert(datetime,'31-dec-'+@CurrYr) AS EndDate
from sds.staging_TimetableSession ts --inner join emin.TimetableSessionStaff tss on tss.TimetableSessionID = ts.TimetableSessionID 
                                inner join sds.staging_TimetableVersion tv on ts.TimetableVersionID = tv.TimetableVersionID 
                                inner join sds.staging_Timetable t on tv.TimetableID = t.TimetableID             
                                --inner join emin.User u on tss.StaffEntityID = u.StaffEntityID and u.ExternalID is not null
                                inner join sds.staging_COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid
                                                            and c.academicyearname = @CurrYr
WHERE t.TimetableType <> 'ACTIVITY'
  AND @CurrYr>= @Today
  AND tv.EffectiveEndDate <> tv.EffectiveStartDate
  AND t.TimetableID not in (921887,921888)
GROUP BY t.TimetableID ,t.Campus, t.StaffEntityID 
) SECTIONS inner join sds.staging_Timetable t on SECTIONS.[SIS ID] = t.TimetableID              
                                 left join sds.staging_TimetableModule tm on t.timetableid = tm.timetableid
                                 left join emin.ModuleLearningArea mla on tm.module = mla.modulecode
					             left JOIN emin.Module m on m.code = mla.ModuleCode 
								 
WHERE CASE WHEN EndDate < convert(datetime,'1-jan-'+@CurrYr) THEN convert(datetime,'31-dec-'+@PrevYr) ELSE dateadd(mm,3,EndDate) END > getdate()
) SISDATA LEFT JOIN dbo.QCE_Map Q ON Q.Year12_TimetableID = SISDATA.[SIS ID]
WHERE RowNumber = 1
--order by 2,1,3



--Cleanse
UPDATE sdsSections
SET [Section Name] = LEFT([Section Name],LEN([Section Name])-1)
WHERE RIGHT([Section Name],1)='.'


END
GO

