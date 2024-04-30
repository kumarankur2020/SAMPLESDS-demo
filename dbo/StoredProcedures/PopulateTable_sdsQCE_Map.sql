CREATE PROC [dbo].[PopulateTable_sdsQCE_Map] AS
BEGIN
 

DECLARE @CurrYr AS VARCHAR(4)
DECLARE @PrevYr AS VARCHAR(4)

select @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
select @PrevYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr'



--QCE_Map.csv
;WITH Year11 (Year11_TimetableID, Campus, TimetableName, Course, SubjectIdentifier, EffectiveStartDate, EffectiveEndDate) AS 
(
	select t.TimetableID, t.Campus, t.TimetableName, t.Course, m.SubjectIdentifier, min(tv.EffectiveStartDate), max(tv.EffectiveEndDate)
	from sds.staging_Timetable t inner join 
		 sds.staging_COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid and c.academicyearname = @PrevYr left join 
		 sds.staging_TimetableModule tm on t.timetableid = tm.timetableid left join 
		 emin.ModuleLearningArea mla on tm.module = mla.modulecode left join 
		 emin.Module m on m.code = mla.ModuleCode inner join 
		 sds.staging_TimetableVersion tv on tv.TimetableID = t.TimetableID inner join 
		 sds.staging_TimetableSession ts on ts.TimetableVersionID = tv.TimetableVersionID inner join 
		 sds.staging_TimetableSessionStaff tss on tss.TimetableSessionID = ts.TimetableSessionID 
	where (t.Course = 11 or left(t.timetablename,2)='11')
	and timetabletype <> 'homegroup'
	and m.Active = 1
	and m.SubjectIdentifier <> ''
	GROUP BY t.TimetableID ,t.Campus, t.TimetableName, t.Course, m.SubjectIdentifier
),
Year12 (Year12_TimetableID, Campus, TimetableName, Course, SubjectIdentifier, EffectiveStartDate, EffectiveEndDate) AS (
	select t.TimetableID, t.Campus, t.TimetableName, t.Course, m.SubjectIdentifier, min(tv.EffectiveStartDate), max(tv.EffectiveEndDate)
	from sds.staging_Timetable t inner join 
		 sds.staging_COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid and c.academicyearname = @CurrYr left join 
		 sds.staging_TimetableModule tm on t.timetableid = tm.timetableid left join 
		 emin.ModuleLearningArea mla on tm.module = mla.modulecode left join 
		 emin.Module m on m.code = mla.ModuleCode inner join 
		 sds.staging_TimetableVersion tv on tv.TimetableID = t.TimetableID inner join 
		 sds.staging_TimetableSession ts on ts.TimetableVersionID = tv.TimetableVersionID inner join 
		 sds.staging_TimetableSessionStaff tss on tss.TimetableSessionID = ts.TimetableSessionID 
	where (t.Course = 12 or left(t.timetablename,2)='12')
	and timetabletype <> 'homegroup'
	and m.Active = 1
	and m.SubjectIdentifier <> ''
	GROUP BY t.TimetableID ,t.Campus, t.TimetableName, t.Course, m.SubjectIdentifier
)
insert into dbo.QCE_Map
select distinct Year11_TimetableID, Year12_TimetableID, Year12.TimetableName, Year11.EffectiveStartDate, Year12.EffectiveEndDate, @CurrYr
from Year11 full outer join Year12 on Year11.Campus = Year12.Campus and 
                                Year11.TimetableName = '11'+RIGHT(Year12.TimetableName,LEN(Year12.TimetableName)-2)
WHERE Year12.TimetableName is not null and Year11.TimetableName is not null
and not exists (select 1 from QCE_Map where QCE_Map.Year12_TimetableID = Year12.Year12_TimetableID)
--order by Year11.Campus,Year11.TimetableName,Year12.TimetableName

TRUNCATE TABLE sdsQCE_Map

INSERT into sdsQCE_Map

SELECT * 
--INTO sdsQCE_Map
FROM dbo.QCE_Map WHERE academicyearname = @CurrYr

END
GO

