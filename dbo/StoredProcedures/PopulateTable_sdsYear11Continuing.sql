CREATE PROC [dbo].[PopulateTable_sdsYear11Continuing] AS
BEGIN


DECLARE @CurrYr AS VARCHAR(4)

select @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
 
TRUNCATE TABLE [dbo].[sdsYear11Continuing]

--Year11Continuing.csv
;WITH Year11 (Year11_TimetableID, Campus, TimetableName, Course, SubjectIdentifier, EffectiveStartDate, EffectiveEndDate) AS 
(
	select t.TimetableID, t.Campus, t.TimetableName, t.Course, m.SubjectIdentifier, min(tv.EffectiveStartDate), max(tv.EffectiveEndDate)
	from sds.staging_Timetable t inner join 
		 sds.staging_COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid and c.academicyearname = @CurrYr left join 
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
)
INSERT INTO sdsYear11Continuing
SELECT *  
FROM Year11

End
GO

