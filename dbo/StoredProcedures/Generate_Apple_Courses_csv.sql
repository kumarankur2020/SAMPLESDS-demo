CREATE PROC [dbo].[Generate_Apple_Courses_csv] AS
BEGIN

--courses.csv
SELECT DISTINCT CASE [Course SIS ID] WHEN '100000' THEN CAST(CAST([Course SIS ID] AS INT)+CAST([School SIS ID] AS INT) AS VARCHAR) ELSE [Course SIS ID] END as course_id, 
                CASE [Course SIS ID] WHEN '100000' THEN 'HGR' ELSE [Course Number] END as course_number, 
                --[Course Name] as course_name, 
                CASE WHEN CHARINDEX (',',[Course Name]) >0 then '"' + [Course Name] + '"' else [Course Name] end AS course_name,
                [School SIS ID] as location_id 
FROM sdsSections S inner join sdsOrgs 
on S.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType = 'apple' WHERE EXISTS (SELECT 1 FROM sdsTeacherRoster TR 
WHERE S.[SIS ID] = TR.[Section SIS ID])
order by 1

END
GO

