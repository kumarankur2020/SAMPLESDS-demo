CREATE PROC [dbo].[PopulateTable_sdsOrgs] AS
BEGIN

TRUNCATE TABLE [dbo].[sdsOrgs]

INSERT INTO [dbo].[sdsOrgs]

SELECT sourcedId,name,type,parentSourcedId,ExportType 

FROM (
	SELECT ExportType, convert(char(3),[SISID]) as sourcedId, name, 'school' AS type, convert(char(3),replace(Zone,'Cluster ','0')) AS parentSourcedId, ROW_NUMBER() OVER(PARTITION BY [SISID],
    ExportType ORDER BY [SISID] ) AS RowNumber FROM sdsSchools inner join eMinExt.SchoolDataExportManager sdem on sdsSchools.[SISID] = sdem.Campus
	UNION SELECT DISTINCT ExportType, convert(char(3),replace(Zone,'Cluster ','0')) as sourcedId,Zone AS Name, 'region' AS Type, convert(char(3),999) AS parentSourcedId,
    ROW_NUMBER() OVER(PARTITION BY [SISID] ORDER BY [SISID] ) AS RowNumber FROM sdsSchools inner join eMinExt.SchoolDataExportManager sdem on sdsSchools.[SISID] = sdem.Campus AND sdem.ExportType = 'SDS'
	--UNION SELECT convert(char(3),990) AS sourcedId, 'Brisbane Catholic Education Office' AS name, 'region' as Type, convert(char(3),999) as parentSourcedId, 1 AS RowNumber
	UNION SELECT 'SDS', convert(char(3),999) AS sourcedId, 'Brisbane Catholic Education' AS name, 'district' as Type, NULL as parentSourcedId, 1 AS RowNumber
	UNION SELECT 'apple', convert(char(3),999) AS sourcedId, 'Brisbane Catholic Education Office' AS name, 'district' as Type, NULL as parentSourcedId, 1 AS RowNumber
) Schools WHERE RowNumber = 1 

END
GO

