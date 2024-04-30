CREATE PROC [dbo].[PopulateTable_SDSTeacher] @Env [varchar](4) AS
BEGIN


DECLARE @CurrYr AS VARCHAR(4)
DECLARE @PrevYr AS VARCHAR(4)
DECLARE @StaffEmailDomain varchar(25)

SELECT @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'

SELECT @PrevYr = ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr'   

SELECT @StaffEmailDomain = ParameterValue from sds_sp_Parameters where commonParameter = 'StaffEmailDomain' and ParameterName = @Env

TRUNCATE TABLE [dbo].[sdsTeacher]

INSERT INTO [dbo].[sdsTeacher]

--Teacher
SELECT 'Teacher'+cast([SIS ID] AS varchar) AS [SIS ID]
      ,[School SIS ID]
      ,[Username]
	  ,[First Name]
	  ,[Last Name]
	  ,[Middle Name]
      ,[Teacher Number]
	  ,[Status]
	  ,isPrimary

  --INTO #Teacher
  FROM (SELECT   [SIS ID]
		        ,[School SIS ID]
		        ,Username
                ,p.PrefName as [First Name]
                ,p.FamName as [Last Name]
				,coalesce(left(p.SecName,1),'') as [Middle Name]
		        ,[Teacher Number]
				,CASE Nactive WHEN 1 THEN 'Inactive' ELSE 'Active' END AS [Status]
				,CASE [School SIS ID] WHEN DefaultCampus THEN CASE Nactive WHEN 1 THEN 0 ELSE 1 END ELSE 0 END as isPrimary
		        ,ROW_NUMBER() OVER(PARTITION BY [SIS ID] ORDER BY [SIS ID],Nactive) AS RowNumber 
		   FROM (SELECT u.StaffEntityID AS [SIS ID]
			           ,(t.Campus) AS [School SIS ID]
			           ,SUBSTRING(u.EmailAddress, 10, 20) + @StaffEmailDomain AS Username
			           ,u.StaffID as [Teacher Number]
			           ,u.Nactive
					   ,u.DefaultCampus
			       FROM emin.TimetableSession ts   INNER JOIN sds.staging_TimetableSessionStaff tss ON tss.TimetableSessionID = ts.TimetableSessionID
					                               INNER JOIN sds.staging_TimetableVersion tv ON ts.TimetableVersionID = tv.TimetableVersionID
						                           INNER JOIN sds.staging_Timetable t ON tv.TimetableID = t.TimetableID		
					                               INNER JOIN sds.staging_User u ON tss.StaffEntityID = u.StaffEntityID and u.ExternalID is not null
			                                       INNER JOIN sds.staging_COAcYear c ON t.calendaracademicyearid = c.calendaracademicyearid AND (c.academicyearname = @CurrYr)
			                                       LEFT JOIN sds.staging_TimetableModule tm on t.timetableid = tm.timetableid
				                                   LEFT JOIN emin.ModuleLearningArea mla on tm.module = mla.modulecode
                  UNION
			     SELECT u.StaffEntityID1 AS [SIS ID]
				       ,(t.Campus) AS [School SIS ID]
				       ,SUBSTRING(u.EmailAddress, 10, 20) + @StaffEmailDomain AS Username
				       ,u.StaffID as [Teacher Number]
				       ,u.Nactive
					   ,u.DefaultCampus
			       FROM sds.staging_TimetableSession ts INNER JOIN sds.staging_TimetableSessionStaff tss ON tss.TimetableSessionID = ts.TimetableSessionID
						                                INNER JOIN sds.staging_TimetableVersion tv ON ts.TimetableVersionID = tv.TimetableVersionID AND 
												                                            tv.effectivestartdate < dateadd(ww,2,getdate()) AND 
																							dateadd(mm,3,CASE WHEN tv.effectiveenddate > convert(datetime,'31-dec-'+@CurrYr) THEN tv.effectiveenddate 
																													ELSE convert(datetime,'31-dec-'+@CurrYr) END) > getdate()
							                       INNER JOIN sds.staging_Timetable t ON tv.TimetableID = t.TimetableID		
						                           INNER JOIN (SELECT U1.StaffEntityID AS StaffEntityID1, U2.StaffEntityID AS StaffEntityID2, 0 AS Nactive, U1.EmailAddress, U1.StaffID, u1.DefaultCampus
                                                                 FROM sds.staging_User U1, eminExt.Impersonation I, emin.[User] U2
                                                                WHERE U1.EmailAddress = 'CATHOLIC\'+I.EmailAddress
									                              AND I.teamsite = 1
                                                                  AND 'CATHOLIC\'+left(I.ImpersonatedEmailAddress, CHARINDEX('@',I.ImpersonatedEmailAddress)-1) = U2.EmailAddress
																  and u2.ExternalID is not null
                                                                  AND U1.StaffEntityID is NOT NULL) u ON tss.StaffEntityID = u.StaffEntityID2
				                                   INNER JOIN sds.staging_COAcYear c ON t.calendaracademicyearid = c.calendaracademicyearid AND (c.academicyearname = @CurrYr OR c.academicyearname = @PrevYr)
				                                   LEFT JOIN sds.staging_TimetableModule tm ON t.timetableid = tm.timetableid
					                               LEFT JOIN emin.ModuleLearningArea mla ON tm.module = mla.modulecode
	     ) SISDATA left join emin.nhPerson p on p.EntityID = SISDATA.[SIS ID] where [SIS ID] <> '1232937' 
    ) ENDDATA

--ORDER BY 2,1
end
GO

