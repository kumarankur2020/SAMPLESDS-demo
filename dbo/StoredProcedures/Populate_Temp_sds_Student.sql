CREATE PROC [dbo].[Populate_Temp_sds_Student] AS
BEGIN

DECLARE @CurrYr AS VARCHAR(4)
DECLARE @PrevYr AS VARCHAR(4)

SELECT @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'

SELECT @PrevYr = ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr'   

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temp_Staging_Students]'))
DROP TABLE[dbo].[temp_Staging_Students]

select distinct
	 s.[SIS ID]		
	,e.Campus --as [School SIS ID]
	,s.[Login] --+ @StudentEmailDomain as [Username]
	,s.[First Name]
	,s.[Last Name]
	,s.[Middle Name]
	,s.AltStudentNo --as [Student Number]
	,e.Course as [Grade]
	,e.EnrolStatus --as [Status]
	,e.StartDate as EnrolStart
	,e.EndDate as EnrolEnd
	,'1' AS [Order]
	,e.FTE
into dbo.temp_Staging_Students
from 
	sds.staging_Students s
        inner join sds.staging_Enrolment e on s.StudentNo = e.Student and e.EnrolStatus IN ('ACTIVE','ACCEPTED','STARTED','FINISHED')
        inner join sds.staging_Timetable tt on e.TimetableID = tt.TimetableID
		inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID
		inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
		inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
		inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null
		inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid and c.academicyearname = @CurrYr	
								
where (e.EnrolStatus IN ('ACTIVE','STARTED','FINISHED') or
	    (e.EnrolStatus = 'ACCEPTED' and tv.EffectiveStartDate > dateadd(dd,-30,getdate())))
	/*Class Code*/
    and tt.TimetableType <> 'module'
	and s.[Login] is not null
union
select distinct		
	 s.[SIS ID]		
	,e.Campus --as [School SIS ID]
	,s.[Login] --+ @StudentEmailDomain  as [UserName]		
	,s.[First Name]
	,s.[Last Name]
	,s.[Middle Name]
	,s.AltStudentNo --as [Student Number]
	,e.Course as [Grade]
	,e.EnrolStatus --as [Status]
	,e.StartDate as EnrolStart
	,e.EndDate as EnrolEnd
	,'1'
	,e.FTE
from 
	sds.staging_Students s
		
        inner join sds.staging_Enrolment e on s.StudentNo = e.Student and e.EnrolStatus IN ('ACTIVE','ACCEPTED','STARTED','FINISHED')
        inner join sds.staging_EnrolledModule em on e.EnrolmentID = em.EnrolmentID
		inner join sds.staging_Timetable tt on em.TimetableID = tt.TimetableID
		inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID
		inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
		inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
		inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null
		inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid and c.academicyearname = @CurrYr	
										
							
where
	tt.TimetableType = 'module'
    and (em.CompletionDate is null or dateadd(dd,28,em.CompletionDate) > em.EndDate )
	and s.[Login] is not null
	and (e.EnrolStatus IN ('ACTIVE','STARTED','FINISHED') or
	    (e.EnrolStatus = 'ACCEPTED' and tv.EffectiveStartDate > dateadd(dd,-30,getdate())))

UNION
select distinct
	 s.[SIS ID]		
	,e.Campus --as [School SIS ID]
	,s.[Login] --+ @StudentEmailDomain as [Username]
	,s.[First Name]
	,s.[Last Name]
	,s.[Middle Name]
	,s.AltStudentNo --as [Student Number]
	,e.Course as [Grade]
	,e.EnrolStatus --as [Status]
	,e.StartDate as EnrolStart
	,e.EndDate as EnrolEnd
	,'2'
	,e.FTE
from 
	sds.staging_students s
        inner join sds.staging_Enrolment e on s.StudentNo = e.Student and e.EnrolStatus IN ('FINISHED','CLOSED') AND (Year(e.EndDate) = @PrevYr)
        inner join sds.staging_Timetable tt on e.TimetableID = tt.TimetableID
		inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID
		inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
		inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
		inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null
		inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid and c.academicyearname = @PrevYr
								
where 
	e.EnrolStatus IN ('FINISHED','CLOSED')
	/*Class Code*/
	and tt.TimetableType <> 'module'
	and s.[Login] is not null
union
select distinct		
	s.[SIS ID]		
	,e.Campus --as [School SIS ID]
	,s.[Login] --+ @StudentEmailDomain  as [UserName]		
	,s.[First Name]
	,s.[Last Name]
	,s.[Middle Name]
	,s.AltStudentNo --as [Student Number]
	,e.Course as [Grade]
	,e.EnrolStatus --as [Status]
	,e.StartDate as EnrolStart
	,e.EndDate as EnrolEnd
	,'2'
	,e.FTE
from 
	sds.staging_Students s

        inner join sds.staging_Enrolment e on s.StudentNo = e.Student and e.EnrolStatus IN ('FINISHED','CLOSED') AND (Year(e.EndDate) = @PrevYr)
        inner join sds.staging_EnrolledModule em on e.EnrolmentID = em.EnrolmentID
		inner join sds.staging_Timetable tt on em.TimetableID = tt.TimetableID
		inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID
		inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
		inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
		inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null
		inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid and c.academicyearname = @PrevYr	
										
							
where
	tt.TimetableType = 'module'
	and em.Completed <> 1 
	and s.[Login] is not null

end
GO

