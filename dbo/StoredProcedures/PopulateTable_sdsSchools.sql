CREATE PROC [dbo].[PopulateTable_sdsSchools] AS
BEGIN
TRUNCATE TABLE [dbo].[sdsSchools];

INSERT INTO [dbo].[sdsSchools]

SELECT [SISID]
       ,[Name]
       ,[StateID]
       ,[SchoolNumber]
       ,[GradeLow]
       ,[GradeHigh]
       ,'Principal'+[PrincipalSISID] AS [PrincipalSISID]
       ,[PrincipalName]
       ,[PrincipalSecondaryEmail]
       ,[Address]
       ,[City]
       ,[State]
       ,'Australia' AS [Country]
       ,[Zip]
       ,[Phone]
       ,[Zone]
 --  INTO sdsSchools
   FROM (SELECT *,ROW_NUMBER() OVER(PARTITION BY [SISID] ORDER BY [SISID] ) AS RowNumber
           FROM sds.vw_Schools) A
  WHERE RowNumber = 1

 
 insert into [dbo].[sdsSchools]
  select '599' as [SISID]
       ,'FisherONE OE BRACKEN RIDGE' AS [Name]
       ,[StateID]
       ,'SONE' AS [SchoolNumber]
       ,'11' AS [GradeLow]
       ,'12' AS [GradeHigh]
       ,[PrincipalSISID]
       ,[PrincipalName]
       ,[PrincipalSecondaryEmail]
       ,[Address]
       ,[City]
       ,[State]
       ,[Country]
       ,[Zip]
       ,[Phone]
       ,[Zone] from [dbo].[sdsSchools] S where S.[SISID] = 502
	    AND NOT EXISTS (SELECT * FROM [dbo].[sdsSchools] S1
              WHERE s1.[SISID] = '599')

END
GO

