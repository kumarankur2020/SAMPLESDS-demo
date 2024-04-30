CREATE TABLE [dbo].[sdsTeacher] (
    [SIS ID]         VARCHAR (37)    NULL,
    [School SIS ID]  NVARCHAR (4000) NULL,
    [Username]       NVARCHAR (45)   NULL,
    [First Name]     NVARCHAR (4000) NULL,
    [Last Name]      NVARCHAR (4000) NULL,
    [Middle Name]    NVARCHAR (1)    NULL,
    [Teacher Number] NVARCHAR (4000) NULL,
    [Status]         VARCHAR (8)     NOT NULL,
    [isPrimary]      INT             NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

