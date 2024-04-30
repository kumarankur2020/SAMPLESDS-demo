CREATE TABLE [dbo].[sdsLeaders] (
    [sourcedId]  VARCHAR (37)    NULL,
    [First Name] NVARCHAR (4000) NULL,
    [Last Name]  NVARCHAR (4000) NULL,
    [Region]     NVARCHAR (4000) NULL,
    [Email]      NVARCHAR (4000) NULL,
    [role]       NVARCHAR (4000) NULL,
    [isPrimary]  INT             NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

