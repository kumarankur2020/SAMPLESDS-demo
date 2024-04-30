CREATE PROC [dbo].[PopulateTable_sdsGuardianRelationship] AS
BEGIN


DECLARE @CurrYr AS VARCHAR(4)

select @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
 
TRUNCATE TABLE [dbo].[sdsGuardianRelationship]

INSERT INTO [dbo].[sdsGuardianRelationship]

--GuardianRelationship.csv
SELECT DISTINCT 'Student'+cast([SIS ID] AS varchar) AS [SIS ID], [Email], mobile, [First Name], [Last Name], [ParentSIS ID], [Role],Campus
--INTO sdsGuardianRelationship
FROM (
	SELECT RIGHT(s.AltStudentNo, LEN(s.AltStudentNo) - 1) as [SIS ID],
		ltrim(rtrim(em.ContactValue))  as Email,
		ltrim(rtrim(ph.ContactValue))  as mobile,
        p2.PrefName      as [First Name],
		p2.FamName       as [Last Name],
		'Parent'+convert(varchar,r.EntityId2) as [ParentSIS ID],
		CASE WHEN rt2to1.Name in ('Mother','Father','Step Mother', 'Step Father') and sr.ParentGuardian = 1 THEN 'Parent'
		     WHEN rt2to1.Name in ('Mother','Father','Step Mother', 'Step Father', 'Aunt', 'Uncle', 'Grandmother', 'Grandfather', 
			                      'Sister', 'Brother', 'Step Sister', 'Step Brother', 'Cousin', 'Granddaughter', 'Grandson', 'Niece', 'Nephew',
								  'Sister in Law', 'Brother in Law', 'Half Sister', 'Half Brother') THEN 'Relative'
             WHEN rt2to1.Name in ('Daughter', 'Son', 'Step Daughter', 'Step Son') THEN 'Child'
		     WHEN sr.ParentGuardian = 1 THEN 'Guardian'
			 WHEN rt2to1.Name in ('Care Provider') THEN 'Aide'
			 WHEN rt2to1.Name in ('Homestay Parent', 'Homestay Brother', 'Homestay Ward', 'Foster Mother', 'Foster Father', 'Friend') THEN 'Other'
			 ELSE 'Other'
	    END as Role,rt2to1.Name,
		ROW_NUMBER() OVER(PARTITION BY s.AltStudentNo,em.ContactValue ORDER BY r.EntityId2,em.ContactValue,sr.MainContact desc) AS RowNumber ,
		e.Campus
	FROM emin.Relationship r
		JOIN emin.RelationshipType rt2to1 ON
			r.RelationshipType2To1 = rt2to1.Code
		JOIN emin.StudentRelationship sr ON
			r.RelationshipId = sr.RelationshipId
			AND sr.Active = 1
			AND sr.Communication = 1
		JOIN emin.nhPerson p1 ON
			r.EntityId1 = p1.EntityId
			AND p1.IsStudent = 1
		JOIN emin.nhPerson p2 ON
			r.EntityId2 = p2.EntityId
		JOIN emin.nhContactMethod em ON
		    em.EntityID = p2.EntityID AND
			em.ContactMethodType='CM003'
		JOIN emin.nhContactMethod ph ON
		    ph.EntityID = p2.EntityID AND
			ph.ContactMethodType='CM002'
	INNER JOIN emin.nhStudent s 
		ON s.EntityID = r.EntityId1
	INNER JOIN sds.staging_Enrolment e
		ON s.StudentNo = e.Student
		and e.EnrolStatus in ('ACTIVE','ACCEPTED','STARTED')
					        inner join sds.staging_Timetable tt on e.TimetableID = tt.TimetableID
						    inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID
						    inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
						    inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
						    inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null --and u.Nactive = 0
						    inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid
							                            and c.academicyearname = @CurrYr
) A WHERE A.RowNumber = 1
END
GO

