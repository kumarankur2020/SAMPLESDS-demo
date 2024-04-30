CREATE PROC [dbo].[Create_Staging_Students] AS

BEGIN

CREATE TABLE [sds].[staging_Students]  WITH (DISTRIBUTION = HASH ( [AltStudentNo] ) )   AS 
Select 
	RIGHT(s.AltStudentNo, LEN(s.AltStudentNo) - 1) as [SIS ID]		
	,s.[Login] 
	,p.PrefName as [First Name]
	,p.FamName as [Last Name]
	,coalesce(left(p.SecName,1),'') as [Middle Name]
	,s.AltStudentNo 
	,s.StudentNo

from 
	eMin.nhPerson p
		inner join eMin.nhStudent s on p.EntityID = s.EntityID and p.isStudent = 1
OPTION (LABEL = 'CTAS : Load stg_students');

ALTER INDEX ALL ON [sds].[staging_Students]       REBUILD;

END
GO

