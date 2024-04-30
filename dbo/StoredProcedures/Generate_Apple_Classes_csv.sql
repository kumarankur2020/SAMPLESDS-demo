CREATE PROC [dbo].[Generate_Apple_Classes_csv] AS
BEGIN

--classes
SELECT  DISTINCT S.[SIS ID] as class_id, 
		[Section Number] as class_number, 
		CASE [Course SIS ID] WHEN '100000' THEN CAST(CAST([Course SIS ID] AS INT)+CAST([School SIS ID] AS INT) AS VARCHAR) ELSE [Course SIS ID] END as course_id, 
		instructor_id, 
		instructor_id_2, 
		instructor_id_3, 
		[School SIS ID] as location_id 
FROM sdsSections S LEFT JOIN (
SELECT TR1.[Section SIS ID], instructor_id, COALESCE(instructor_id_2,'') as instructor_id_2, COALESCE(instructor_id_3,'') AS instructor_id_3 FROM (
	SELECT [Section SIS ID], [SIS ID] AS instructor_id, ROW_NUMBER() OVER(PARTITION BY [Section SIS ID] ORDER BY [Section SIS ID], [SIS ID] DESC) AS RN1
	  FROM sdsTeacherRoster WHERE EXISTS (SELECT 1 FROM sdsTeacher T WHERE T.[SIS ID] = sdsTeacherRoster.[SIS ID] AND T.Status <> 'Inactive')
) TR1 LEFT JOIN (
	SELECT [Section SIS ID], [SIS ID] AS instructor_id_2, ROW_NUMBER() OVER(PARTITION BY [Section SIS ID] ORDER BY [Section SIS ID], [SIS ID] DESC) AS RN2
	  FROM sdsTeacherRoster WHERE EXISTS (SELECT 1 FROM sdsTeacher T WHERE T.[SIS ID] = sdsTeacherRoster.[SIS ID] AND T.Status <> 'Inactive')
) TR2 ON TR1.[Section SIS ID] = TR2.[Section SIS ID] AND RN2 = 2
LEFT JOIN (
	SELECT [Section SIS ID], [SIS ID] AS instructor_id_3, ROW_NUMBER() OVER(PARTITION BY [Section SIS ID] ORDER BY [Section SIS ID], [SIS ID] DESC) AS RN3
	  FROM sdsTeacherRoster WHERE EXISTS (SELECT 1 FROM sdsTeacher T WHERE T.[SIS ID] = sdsTeacherRoster.[SIS ID] AND T.Status <> 'Inactive')
) TR3 ON TR1.[Section SIS ID] = TR2.[Section SIS ID] AND TR2.[Section SIS ID] = TR3.[Section SIS ID] AND TR1.[Section SIS ID] = TR3.[Section SIS ID] AND RN3 = 3
WHERE RN1=1 and (rn2 is null or RN2=2) and (rn3 is null or RN3=3)
) TR ON TR.[Section SIS ID] = S.[SIS ID] inner join sdsOrgs on S.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType = 'apple' WHERE instructor_id IS NOT NULL
--SELECT DISTINCT [SIS ID] as class_id, [Section Number] as class_number, CASE [Course SIS ID] WHEN '100000' THEN CAST(CAST([Course SIS ID] AS INT)+CAST([School SIS ID] AS INT) AS VARCHAR) ELSE [Course SIS ID] END as course_id, MainTeacher as instructor_id, '' as instructor_id_2, '' as instructor_id_3, [School SIS ID] as location_id FROM #Section S WHERE EXISTS (SELECT 1 FROM #TeacherRoster TR WHERE S.[SIS ID] = TR.[Section SIS ID])
ORDER BY [SIS ID] 


END
GO

