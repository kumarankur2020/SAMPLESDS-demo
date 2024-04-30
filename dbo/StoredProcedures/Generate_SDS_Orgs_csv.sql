CREATE PROC [dbo].[Generate_SDS_Orgs_csv] AS
BEGIN

--SDS\orgs.csv
--sourcedId	name	type	parentSourcedId
/*
SELECT sourcedId,name,type,parentSourcedId FROM sdsOrgs WHERE ExportType in ('SDS','B')
ORDER BY 1,2
*/

SELECT	 '"' + sourcedId + '"' as SourcedId
		, '"' + [name] + '"' as Name
		, '"' + [type] + '"' as Type
		,'"' + parentSourcedId  + '"' as ParentSourcedId
FROM sdsOrgs 
WHERE ExportType in ('SDS','B')

order by 1,2
END
GO

