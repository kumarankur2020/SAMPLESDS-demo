CREATE PROC [dbo].[Drop_staging_tables] AS
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sds].[staging_User]'))
DROP TABLE[sds].[staging_User]

end
GO

