CREATE PROC [dbo].[Generate_SDS_Courses_csv] AS
BEGIN

--SDS\courses.csv
--sourcedId	orgSourcedId	title	code	schoolYearSourcedId	subject	grade

SELECT DISTINCT CASE [Course SIS ID]
                    WHEN '100000' THEN CONCAT('"', CAST(CAST([Course SIS ID] AS INT) + CAST([School SIS ID] AS INT) AS VARCHAR), '"')
                    ELSE CONCAT('"', [Course SIS ID], '"')
                END AS sourcedId,
                CONCAT('"', [School SIS ID], '"') AS orgSourcedId,
                CONCAT('"', [Course Name], '"') AS title,
                CASE [Course SIS ID]
                    WHEN '100000' THEN CONCAT('"', 'HGR', '"')
                    ELSE CONCAT('"', [Course Number], '"')
                END AS code,
                CONCAT('"', trim(TermId), '"') AS schoolYearSourcedId,
                CONCAT('"', [subject], '"') AS [subject],
                CONCAT('"', null, '"') AS [grade] 

FROM sdsSections S
INNER JOIN sdsOrgs ON S.[School SIS ID] = sdsOrgs.sourcedId
AND sdsOrgs.ExportType in ('SDS', 'B')
                         
WHERE EXISTS
    (SELECT 1
     FROM sdsTeacherRoster TR
     WHERE S.[SIS ID] = TR.[Section SIS ID])
ORDER by 1
END
GO

