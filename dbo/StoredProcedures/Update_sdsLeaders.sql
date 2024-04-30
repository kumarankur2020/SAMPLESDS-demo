CREATE PROC [dbo].[Update_sdsLeaders] AS
BEGIN

SET NOCOUNT ON

INSERT INTO [dbo].[sdsLeaders]


SELECT 'Teacher'+CAST(StaffEntityID AS VARCHAR)
	,p.PrefName
	,p.FamName
	,CASE WHEN [DefaultCampus] IS NULL THEN '999' WHEN DefaultCampus = '' THEN '999' WHEN DefaultCampus = '001' THEN '999' ELSE DefaultCampus END
        ,SUBSTRING(EmailAddress, 10, 20) + '@bne.catholic.edu.au'
	,CASE WHEN CASE WHEN [DefaultCampus] IS NULL THEN '999' WHEN DefaultCampus = '' THEN '999' WHEN DefaultCampus = '001' THEN '999' ELSE DefaultCampus END = '999' THEN 'staff' ELSE 'faculty' END as [Role]
	,CASE Nactive WHEN 1 THEN 0 ELSE 1 END AS isPrimary
FROM emin.[User] u inner join emin.nhPerson p on u.StaffEntityID = p.EntityID
where nactive = 0
and StaffEntityID is not null and StaffEntityID <> ''
and StaffID is not null and StaffID <> ''
and  not exists (select 1 from dbo.sdsTeacher t where 'Teacher'+CAST(u.StaffEntityID AS VARCHAR) = t.[SIS ID])

end
GO

