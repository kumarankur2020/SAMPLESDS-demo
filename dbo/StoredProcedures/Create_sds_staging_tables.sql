CREATE PROC [dbo].[Create_sds_staging_tables] AS
BEGIN


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_COAcYear]'))
DROP TABLE[sds].[staging_COAcYear]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_Enrolment]'))
DROP TABLE[sds].[staging_Enrolment]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_Students]'))
DROP TABLE[sds].[staging_Students]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_EnrolledModule]'))
DROP TABLE[sds].[staging_EnrolledModule]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_Timetable]'))
DROP TABLE [sds].[staging_Timetable]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_TimetableSession]'))
DROP TABLE[sds].[staging_TimetableVersion]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_TimetableSession]'))
DROP TABLE[sds].[staging_TimetableSession]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_TimetableSessionStaff]'))
DROP TABLE[sds].[staging_TimetableSessionStaff]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_TimetableModule]'))
DROP TABLE[sds].[staging_TimetableModule]



CREATE TABLE [sds].[staging_COAcYear]  WITH (DISTRIBUTION = HASH([CalendarAcademicYearId]) )		AS SELECT * FROM emin.COAcYear where AcademicYearName in (SELECT ParameterValue from sds_sp_Parameters where commonparameter = 'YearRange') ;

CREATE TABLE [sds].[staging_Timetable]  WITH (DISTRIBUTION =  HASH([TimetableID])   )			    AS SELECT * FROM emin.Timetable where CalendarAcademicYearId in (SELECT CalendarAcademicYearId from sds.staging_COAcYear) ;

CREATE TABLE [sds].[staging_TimetableVersion]  WITH (DISTRIBUTION = HASH([TimetableVersionID])  )   AS SELECT * FROM emin.TimetableVersion  where TimetableID in (SELECT TimetableID from sds.staging_Timetable) 

CREATE TABLE [sds].[staging_TimetableSession]  WITH (DISTRIBUTION = HASH([TimetableSessionID])  )   AS SELECT * FROM emin.TimetableSession  where TimetableVersionID in (SELECT TimetableVersionID from sds.staging_TimetableVersion) 

CREATE TABLE [sds].[staging_Enrolment]  WITH (DISTRIBUTION = HASH([EnrolmentID])  )					AS SELECT * FROM emin.Enrolment  where CalendarAcademicYearId in (SELECT CalendarAcademicYearId from sds.staging_COAcYear) 

CREATE TABLE [sds].[staging_TimetableSessionStaff]  WITH (DISTRIBUTION = HASH([TimetableSessionStaffID])  )  AS SELECT * FROM emin.TimetableSessionStaff  where TimetableSessionID in (SELECT TimetableSessionID from sds.staging_TimetableSession) 

CREATE TABLE [sds].[staging_EnrolledModule]  WITH (DISTRIBUTION = ROUND_ROBIN )						AS	SELECT * FROM emin.EnrolledModule  where EnrolmentID in (SELECT EnrolmentID from sds.staging_Enrolment) 

CREATE TABLE [sds].[staging_TimetableModule]  WITH (DISTRIBUTION = HASH ( [TimetableModuleID] ) )   AS SELECT * FROM emin.TimetableModule  where TimetableID in (SELECT TimetableID from sds.staging_Timetable) 

CREATE TABLE [sds].[staging_Students]  WITH (DISTRIBUTION = HASH ( [AltStudentNo] ) )   AS 
Select 
	RIGHT(s.AltStudentNo, LEN(s.AltStudentNo) - 1) as [SIS ID]		
	,s.[Login] 
	,p.PrefName as [First Name]
	,p.FamName as [Last Name]
	,coalesce(left(p.SecName,1),'') as [Middle Name]
	,s.AltStudentNo 
	,s.StudentNo

from 
	eMin.nhPerson p
		inner join eMin.nhStudent s on p.EntityID = s.EntityID and p.isStudent = 1

END
GO

