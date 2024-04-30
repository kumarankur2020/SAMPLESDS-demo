CREATE TABLE [dbo].[sdsGuardianRelationship] (
    [SIS ID]       VARCHAR (37)    NULL,
    [Email]        NVARCHAR (4000) NULL,
    [mobile]       NVARCHAR (4000) NULL,
    [First Name]   NVARCHAR (4000) NULL,
    [Last Name]    NVARCHAR (4000) NULL,
    [ParentSIS ID] VARCHAR (36)    NULL,
    [Role]         VARCHAR (8)     NOT NULL,
    [Campus]       NVARCHAR (4000) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

