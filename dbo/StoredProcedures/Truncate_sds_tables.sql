CREATE PROC [dbo].[Truncate_sds_tables] AS
BEGIN
 TRUNCATE TABLE dbo.QCE_Map 
 TRUNCATE TABLE sdsAppleusers
 TRUNCATE TABLE sdsGuardianRelationship
 TRUNCATE TABLE sdsLeaders
 TRUNCATE TABLE sdsOrgs
 TRUNCATE TABLE sdsQCE_Map
 TRUNCATE TABLE sdsSchools
 TRUNCATE TABLE sdsSections
 TRUNCATE TABLE sdsStudent
 TRUNCATE TABLE sdsStudentEnrollment
 TRUNCATE TABLE sdsTeacher
 TRUNCATE TABLE sdsTeacherRoster
 TRUNCATE TABLE sdsTerms
 TRUNCATE TABLE sdsYear11Continuing


END
GO

