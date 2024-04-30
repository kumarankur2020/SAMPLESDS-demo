CREATE TABLE [sds].[staging_Students] (
    [SIS ID]       NVARCHAR (4000) NULL,
    [Login]        NVARCHAR (4000) NULL,
    [First Name]   NVARCHAR (4000) NULL,
    [Last Name]    NVARCHAR (4000) NULL,
    [Middle Name]  NVARCHAR (1)    NULL,
    [AltStudentNo] NVARCHAR (4000) NULL,
    [StudentNo]    INT             NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([AltStudentNo]));
GO

