CREATE TABLE [dbo].[sdsSchools] (
    [SISID]                   NVARCHAR (4000) NULL,
    [Name]                    NVARCHAR (4000) NULL,
    [StateID]                 NVARCHAR (4000) NULL,
    [SchoolNumber]            NVARCHAR (4000) NULL,
    [GradeLow]                INT             NULL,
    [GradeHigh]               INT             NULL,
    [PrincipalSISID]          NVARCHAR (4000) NULL,
    [PrincipalName]           NVARCHAR (4000) NULL,
    [PrincipalSecondaryEmail] NVARCHAR (4000) NULL,
    [Address]                 NVARCHAR (4000) NULL,
    [City]                    NVARCHAR (4000) NULL,
    [State]                   NVARCHAR (4000) NULL,
    [Country]                 VARCHAR (9)     NOT NULL,
    [Zip]                     NVARCHAR (4000) NULL,
    [Phone]                   NVARCHAR (4000) NULL,
    [Zone]                    NVARCHAR (4000) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

