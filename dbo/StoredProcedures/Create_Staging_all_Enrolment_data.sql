CREATE PROC [dbo].[Create_Staging_all_Enrolment_data] AS
BEGIN

CREATE TABLE [sds].[staging_Enrolment]  WITH (DISTRIBUTION = HASH([EnrolmentID])  )	AS 
SELECT
EnrolmentID, Student, Course, Campus, StartDate, EndDate, EnrolStatus, EnrolCategory, CalendarAcademicYearId, FTE, TimetableID
FROM emin.Enrolment  where CalendarAcademicYearId in (SELECT CalendarAcademicYearId from sds.staging_COAcYear) 
OPTION (LABEL = 'CTAS : Load stg_enrolment');
ALTER INDEX ALL ON [sds].[staging_Enrolment]       REBUILD;

CREATE TABLE [sds].[staging_EnrolledModule]  WITH (DISTRIBUTION = ROUND_ROBIN )	AS	
--SELECT * FROM emin.EnrolledModule  where EnrolmentID in (SELECT EnrolmentID from sds.staging_Enrolment) 
select 
EnrolmentId,TimetableId,Completed, CompletionDate,StartDate,EndDate
from emin.EnrolledModule
where EnrolmentID in (SELECT EnrolmentID from sds.staging_Enrolment) 
OPTION (LABEL = 'CTAS : Load stg_EnrolledModule');
ALTER INDEX ALL ON [sds].[staging_EnrolledModule]      REBUILD;

END
--select * from [sds].[staging_Enrolment]
GO

