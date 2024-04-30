CREATE PROC [dbo].[Test_SDS_Orgs_csv] AS
BEGIN

--SDS\orgs.csv
--sourcedId	name	type	parentSourcedId
SELECT '"'+ sourcedId + '"' as sourcedId,name,type,parentSourcedId FROM sdsOrgs WHERE ExportType in ('SDS','B')
ORDER BY 1,2

END
GO

