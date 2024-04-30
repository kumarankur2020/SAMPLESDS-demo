CREATE PROC [dbo].[PopulateTable_sdsLeaders] @Env [varchar](4) AS
BEGIN

SET NOCOUNT ON

DECLARE @StaffEmailDomain varchar(25)  

SELECT @StaffEmailDomain = ParameterValue FROM sds_sp_Parameters where CommonParameter = 'StaffEmailDomain' and ParameterName = @Env

TRUNCATE TABLE [dbo].[sdsLeaders]

INSERT INTO [dbo].[sdsLeaders]

--Leaders
SELECT 'Teacher'+cast(u.StaffEntityID as varchar) as [sourcedId], 
        u.FirstName as [First Name],
        u.Surname as [Last Name],
        [Region],
        [Email]+@StaffEmailDomain AS Email ,
        [role], 
        isPrimary
--INTO sdsLeaders
FROM eminExt.SeniorLeaders SL inner join  emin.[User] u on SUBSTRING(u.EmailAddress, 10, 20) = [Email] and u.ExternalID is not null
UNION
SELECT 'Teacher'+cast(u.StaffEntityID as varchar) as [sourcedId], 
        u.FirstName as [First Name],
        u.Surname as [Last Name],
        [Region], 
        SUBSTRING(u.EmailAddress, 10, 20)+ @StaffEmailDomain as [Email] ,
	  CASE WHEN [Region] = '999' THEN 'OfficeStaff'
           WHEN [JobTitle] like 'Cluster %' THEN 'OfficeStaff'
           WHEN [JobTitle] like 'Prin %' THEN 'Principal'
           WHEN [JobTitle] like 'Dep%' THEN 'Principal'
           WHEN [JobTitle] like 'Head%' THEN 'Principal'
           WHEN [JobTitle] like 'AP %' THEN 'Administrator'
           WHEN [JobTitle] like 'Assistant Principal %' THEN 'Administrator'
           WHEN [JobTitle] like 'APRE %' THEN 'Administrator'
           WHEN [JobTitle] like 'Assistant Principal Religious Education %' THEN 'Administrator'
		   WHEN [JobTitle] like 'Pri Lrng Leader%' THEN 'Paraprofessional'
		   WHEN [JobTitle] like 'Primary Learning Leader%' THEN 'Paraprofessional'
		   ELSE NULL
	  END as [Role],
      1 as isPrimary
  FROM eminext.Leaders L inner join emin.[User] u on SUBSTRING(u.EmailAddress, 10, 20)+'@bne.catholic.edu.au' = L.EmailAddress and u.ExternalID is not null


END
GO

