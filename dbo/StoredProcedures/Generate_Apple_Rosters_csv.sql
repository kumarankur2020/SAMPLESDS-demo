CREATE PROC [dbo].[Generate_Apple_Rosters_csv] AS
BEGIN

DECLARE @Today int = year(getdate())
--rosters.csv
SELECT DISTINCT CAST(EnrolmentID AS vARCHAR)+'_'+CAST([Section SIS ID] AS VARCHAR) AS roster_id,
                [Section SIS ID] AS class_id,
                [SIS ID] AS student_id
FROM sdsStudentEnrollment SE
WHERE EXISTS
    (SELECT 1
     FROM sdsStudent ST
     INNER JOIN sdsOrgs ON ST.[School SIS ID] = sdsOrgs.sourcedId
     AND sdsOrgs.ExportType = 'apple'
     WHERE ST.[SIS ID] = SE.[SIS ID]
       AND (ST.Status in ('Active','Started') OR (ST.Status = 'Accepted' AND SE.EffectiveStartDate <= @Today)) )
  AND EXISTS
    (SELECT 1
     FROM sdsSections S
     INNER JOIN sdsOrgs ON S.[School SIS ID] = sdsOrgs.sourcedId
     AND sdsOrgs.ExportType = 'apple'
     WHERE S.[SIS ID] = SE.[Section SIS ID])
  AND EXISTS
    (SELECT 1
     FROM sdsTeacher T
     INNER JOIN sdsTeacherRoster ON T.[SIS ID] = sdsTeacherRoster.[SIS ID]
     AND sdsTeacherRoster.[Section SIS ID] = SE.[Section SIS ID]
     AND T.Status <> 'Inactive')

END
GO

