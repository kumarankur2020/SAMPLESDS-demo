CREATE PROC [dbo].[Create_Staging_all_Timetable_data] AS
BEGIN


CREATE TABLE [sds].[staging_Timetable]  WITH (DISTRIBUTION =  HASH([TimetableID])   )			    AS SELECT TimetableType, TimetableName, Campus, Course, TimetableID, CalendarAcademicYearId, StaffEntityID FROM emin.Timetable where CalendarAcademicYearId in (SELECT CalendarAcademicYearId from sds.staging_COAcYear)
OPTION (LABEL = 'CTAS : Load TT');
ALTER INDEX ALL ON [sds].[staging_Timetable]       REBUILD;

CREATE TABLE [sds].[staging_TimetableModule]  WITH (DISTRIBUTION = HASH ( [TimetableModuleID] ) )   AS SELECT * FROM emin.TimetableModule  where TimetableID in (SELECT TimetableID from sds.staging_Timetable) 
OPTION (LABEL = 'CTAS : Load TT_Module');
ALTER INDEX ALL ON [sds].[staging_TimetableModule]        REBUILD;

CREATE TABLE [sds].[staging_TimetableVersion]  WITH (DISTRIBUTION = HASH([TimetableVersionID])  )   AS SELECT VersionNumber, EffectiveStartDate, EffectiveEndDate, TimetableVersionId, TimetableID FROM emin.TimetableVersion  where TimetableID in (SELECT TimetableID from sds.staging_Timetable) 
OPTION (LABEL = 'CTAS : Load TT_Version');
ALTER INDEX ALL ON [sds].[staging_TimetableVersion]       REBUILD;

CREATE TABLE [sds].[staging_TimetableSession]  WITH (DISTRIBUTION = HASH([TimetableSessionID])  )   AS SELECT TimetableSessionId, TimetableVersionID FROM emin.TimetableSession  where TimetableVersionID in (SELECT TimetableVersionID from sds.staging_TimetableVersion) 
OPTION (LABEL = 'CTAS : Load TT_Session');
ALTER INDEX ALL ON [sds].[staging_TimetableSession]        REBUILD;

CREATE TABLE [sds].[staging_TimetableSessionStaff]  WITH (DISTRIBUTION = HASH([TimetableSessionStaffID])  )  AS SELECT TimetableSessionStaffid, staffEntityID, TimetablesessionID FROM emin.TimetableSessionStaff  where TimetableSessionID in (SELECT TimetableSessionID from sds.staging_TimetableSession) 
OPTION (LABEL = 'CTAS : Load TT_SessionStaff');
ALTER INDEX ALL ON [sds].[staging_TimetableSessionStaff]         REBUILD;

CREATE TABLE [sds].[staging_User]  WITH (DISTRIBUTION = ROUND_ROBIN  )  AS SELECT EmailAddress,  StaffEntityID, ExternalId, AdUsername,StaffID, Firstname, Surname, DefaultCampus, Nactive  from emin.[user]
OPTION (LABEL = 'CTAS : Load stg User');
ALTER INDEX ALL ON [sds].[staging_User]         REBUILD;


END
GO

