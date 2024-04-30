CREATE PROC [dbo].[Generate_SDS_Users_csv] AS
BEGIN

--SDS\users.csv
--sourcedId	username	givenName	familyName	password	activeDirectoryMatchId	email	phone	sms
SELECT distinct 
		   CONCAT('"', [SIS ID], '"') AS sourcedId
		 , CONCAT('"', username, '"') AS username
		 , CONCAT('"', [First Name], '"') AS givenName
		 , CONCAT('"', [Last Name], '"') AS familyName
		 , CONCAT('"', NULL, '"') AS password
		 , CONCAT('"', username, '"') AS activeDirectoryMatchId
		 , CONCAT('"', username, '"') AS email
		 , CONCAT('"', NULL, '"') AS phone
		 , CONCAT('"', NULL, '"') AS sms
FROM sdsTeacher inner join sdsOrgs on sdsTeacher.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType in ('SDS','B') WHERE Status <> 'Inactive'
UNION
SELECT distinct 
		   CONCAT('"', [SIS ID], '"') AS sourcedId
		 , CONCAT('"', username, '"') AS username
		 , CONCAT('"', [First Name], '"') AS givenName
		 , CONCAT('"', [Last Name], '"') AS familyName
		 , CONCAT('"', NULL, '"') AS password
		 , CONCAT('"', username, '"') AS activeDirectoryMatchId
		 , CONCAT('"', username, '"') AS email
		 , CONCAT('"', NULL, '"') AS phone
		 , CONCAT('"', NULL, '"') AS sms

FROM sdsStudent inner join sdsOrgs on sdsStudent.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType in ('SDS','B')
UNION
SELECT DISTINCT 
		   CONCAT('"', sdsLeaders.[sourcedId], '"') AS sourcedId
		 , CONCAT('"', [Email], '"') AS username
		 , CONCAT('"', [First Name], '"') AS givenName
		 , CONCAT('"', [Last Name], '"') AS familyName
		 , CONCAT('"', '', '"') AS [password]
		 , CONCAT('"', [Email], '"') AS activeDirectoryMatchId
		 , CONCAT('"', [Email], '"') AS email
		 , CONCAT('"', '', '"') AS phone
		 , CONCAT('"', '', '"') AS sms
FROM sdsLeaders inner join sdsOrgs on sdsLeaders.Region = sdsOrgs.sourcedId AND sdsOrgs.ExportType in ('SDS','B') WHERE [Role] IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sdsTeacher WHERE [SIS ID] = sdsLeaders.[sourcedId])
UNION
--select distinct [ParentSIS ID] as sourcedId,Email as username, [First Name] as givenName, [Last Name] as familyName, '' as password, '' as activeDirectoryMatchId, Email as email, null as phone, null as sms from #GuardianRelationship inner join #Orgs on #GuardianRelationship.Campus = #Orgs.sourcedId AND #Orgs.ExportType in ('SDS','B')
--select distinct [ParentSIS ID] as sourcedId,Email as username, [First Name] as givenName, [Last Name] as familyName, '' as password, '' as activeDirectoryMatchId, Email as email, null as phone, null as sms from #GuardianRelationship where @ParentConnectionParents like '%,'+Email+',%' --order by [ParentSIS ID]
select distinct 
		   CONCAT('"', [ParentSIS ID], '"') AS sourcedId
		 , CONCAT('"', Email, '"') AS username
		 , CONCAT('"', [First Name], '"') AS givenName
		 , CONCAT('"', [Last Name], '"') AS familyName
		 , CONCAT('"', '', '"') AS password
		 , CONCAT('"', '', '"') AS activeDirectoryMatchId
		 , CONCAT('"', Email, '"') AS email
		 , CONCAT('"', NULL, '"') AS phone
		 , CONCAT('"', NULL, '"') AS sms
from sdsGuardianRelationship where  (select ParameterValue from sds_sp_parameters where ParameterName = 'ParentConnectionSchools')  like '%,'+Campus+',%'  and email not like '%bne.catholic.edu.au' --order by [ParentSIS ID]
--union
--select distinct [ParentSIS ID] as sourcedId,Email as username, [First Name] as givenName, [Last Name] as familyName, '' as password, '' as activeDirectoryMatchId, Email as email, null as phone, null as sms from #GuardianRelationship inner join #StudentEnrollment on #StudentEnrollment.[SIS ID] = #GuardianRelationship.[SIS ID] where @ParentConnectionClasses like '%,'+cast(#StudentEnrollment.[Section SIS ID] as varchar)+',%' --order by [ParentSIS ID]
order by 1
END
GO

