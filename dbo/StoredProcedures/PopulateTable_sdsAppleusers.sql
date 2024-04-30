CREATE PROC [dbo].[PopulateTable_sdsAppleusers] AS
BEGIN

TRUNCATE TABLE [dbo].[sdsAppleusers]

INSERT INTO [dbo].[sdsAppleusers]

--Manually add all users for apple and SDS exports
SELECT 
	'Teacher'+cast(StaffEntityID as varchar) as person_id
	,[StaffID] AS person_number
   ,p.PrefName as first_name
	,coalesce(left(p.SecName,1),'') as middle_name
   ,p.FamName as last_name
   ,SUBSTRING(EmailAddress, 10, 20) + '@bne.catholic.edu.au' AS email_address
	,[EmailAddress] as sis_username
	,case when [DefaultCampus] is null then '999' when DefaultCampus = '' then '999' when DefaultCampus = '001' then '999' else DefaultCampus end as location_id
--into sdsAppleusers
FROM emin.[User] u inner join emin.nhPerson p on u.StaffEntityID = p.EntityID
where nactive = 0
and StaffEntityID is not null and StaffEntityID <> ''
and StaffID is not null and StaffID <> ''

END
GO

