CREATE PROC [dbo].[Generate_SDS_AcademicSessions_csv] AS
BEGIN

--SDS\academicSessions.csv
/*
SELECT  sourcedId,
		title,
		[type], 
		schoolYear, 
		startDate, 
		endDate 
FROM sdsTerms
ORDER by 3,5,6
*/

SELECT  '"' + sourcedId + '"' as SourcedId
		,'"' + title + '"' as Title
		,'"' + [type] + '"' as Type
		,'"' + schoolYear + '"' as SchoolYear
		,'"' +startDate + '"' as StartDate
		,'"' + endDate + '"' as EndDate
FROM sdsTerms
ORDER by 3,5,6

END
GO

