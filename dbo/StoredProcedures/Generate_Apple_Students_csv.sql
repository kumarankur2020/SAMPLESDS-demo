CREATE PROC [dbo].[Generate_Apple_Students_csv] AS
BEGIN

--students.csv
SELECT person_id,
       person_number,
       first_name,
       middle_name,
       last_name,
       grade_level,
       email_address,
       sis_username,
       password_policy,
       location_id
FROM
  (SELECT ROW_NUMBER() OVER(PARTITION BY [SIS ID] ORDER BY [FTE] DESC) AS RowNumber,
          [SIS ID] AS person_id,
          [Student Number] AS person_number,
          [First Name] AS first_name,
          [Middle Name] AS middle_name,
          [Last Name] AS last_name,
          [Grade] AS grade_level,
          [Username] AS email_address,
          'CATHOLIC\'+left([Username], 
		  CHARINDEX('@',[Username])-1) as sis_username, 
		  '4' AS password_policy, 
		  [School SIS ID] as location_id 
		  FROM sdsStudent inner join sdsOrgs on sdsStudent.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType = 'apple' 
		  WHERE [Status] IN ('Accepted','Active','Started')--EnrolStart = @YearStart
  ) Students
WHERE RowNumber = 1
order by 1
END
GO

