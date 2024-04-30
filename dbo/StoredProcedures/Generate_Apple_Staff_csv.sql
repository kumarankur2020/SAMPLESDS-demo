CREATE PROC [dbo].[Generate_Apple_Staff_csv] AS
BEGIN

--staff.csv
SELECT person_id,
       person_number,
       first_name,
       middle_name,
       last_name,
       email_address,
       sis_username,
       location_id
FROM
  (SELECT ROW_NUMBER() OVER(PARTITION BY person_id ORDER BY person_id, [order] ASC) AS RN,
          person_id,
          person_number,
          first_name,
          middle_name,
          last_name,
          email_address,
          sis_username,
          location_id,
          [order]
   FROM
	 (SELECT [SIS ID] AS person_id,
			[Teacher Number] AS person_number,
			[First Name] AS first_name,
			[Middle Name] AS middle_name,
			[Last Name] AS last_name,
			[Username] AS email_address,
			'CATHOLIC\'+left([Username], 
			CHARINDEX('@',[Username])-1) as sis_username, 
			[School SIS ID] as location_id, 
			1 as [order] 
		FROM sdsTeacher inner join sdsOrgs on sdsTeacher.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType = 'apple'  WHERE Status <> 'Inactive'
		UNION 
		SELECT person_id,
			   person_number,
			   first_name,
			   middle_name,
			   last_name,
			   email_address,
			   sis_username,
			   location_id,
			   2 AS [order]
		FROM sdsappleusers
		INNER JOIN sdsOrgs ON sdsappleusers.location_id = sdsOrgs.sourcedId
		AND sdsOrgs.ExportType = 'apple' ) AllStaff
	) Staff
WHERE RN =1
ORDER BY first_name, person_id

END
GO

