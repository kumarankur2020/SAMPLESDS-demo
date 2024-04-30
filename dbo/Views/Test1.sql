CREATE VIEW [Test1]
AS select distinct		
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
	--,'2'
	,e.FTE
	,c.academicyearname
	,tt.TimetableType
	,em.Completed
	,em.CompletionDate
	 ,tv.EffectiveStartDate
from 
	sds.staging_Students s

        inner join sds.staging_Enrolment e on s.StudentNo = e.Student --and e.EnrolStatus IN ('FINISHED','CLOSED') AND (Year(e.EndDate) = @PrevYr)
        inner join sds.staging_EnrolledModule em on e.EnrolmentID = em.EnrolmentID
		inner join sds.staging_Timetable tt on em.TimetableID = tt.TimetableID
		inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID
		inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
		inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
		inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null
		inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid --and c.academicyearname = @PrevYr	
										
							
where
	 s.[Login] is not null;
GO

