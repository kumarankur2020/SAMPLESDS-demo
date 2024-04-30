CREATE TABLE [dbo].[sdsOrgs] (
    [sourcedId]       CHAR (3)        NULL,
    [name]            NVARCHAR (4000) NULL,
    [type]            VARCHAR (8)     NOT NULL,
    [parentSourcedId] CHAR (3)        NULL,
    [ExportType]      NVARCHAR (4000) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

