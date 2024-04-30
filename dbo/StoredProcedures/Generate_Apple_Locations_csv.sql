CREATE PROC [dbo].[Generate_Apple_Locations_csv] AS
BEGIN
--locations.csv
--SELECT [SIS ID] as location_id, #School.[Name] as location_name from #School inner join #Orgs on #School.[SIS ID] = #Orgs.sourcedId AND #Orgs.ExportType = 'apple'
SELECT sourcedId AS location_id,
       name AS location_name

FROM sdsOrgs
WHERE ExportType = 'apple'
--ORDER BY 1,2

END
GO

