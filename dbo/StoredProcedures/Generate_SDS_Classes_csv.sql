CREATE PROC [dbo].[Generate_SDS_Classes_csv] AS
BEGIN

--SDS\classes.csv
--sourcedId	orgSourcedId	title	sessionSourcedIds	courseSourcedId

SELECT CONCAT('"', [SIS ID], '"') AS sourcedId,
       CONCAT('"', [School SIS ID], '"') AS orgSourcedId,
       CONCAT('"', [Section Name], '"') AS title,
       CONCAT('"', trim(TermId), '"') AS sessionSourcedIds,
       CASE [Course SIS ID]
           WHEN '100000' THEN CONCAT('"', CAST(CAST([Course SIS ID] AS INT) + CAST([School SIS ID] AS INT) AS VARCHAR), '"') 
           ELSE CONCAT('"', [Course SIS ID], '"')
       END AS courseSourcedId
FROM sdsSections S
INNER JOIN sdsOrgs ON S.[School SIS ID] = sdsOrgs.sourcedId
AND sdsOrgs.ExportType in ('SDS', 'B')                         
INNER JOIN sdsTerms ON sdsTerms.sourcedId = S.TermId
WHERE EXISTS
    (SELECT 1
     FROM sdsTeacherRoster TR
     WHERE S.[SIS ID] = TR.[Section SIS ID])
ORDER by 1,5
END
GO

