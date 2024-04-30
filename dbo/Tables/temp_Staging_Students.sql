CREATE TABLE [dbo].[temp_Staging_Students] (
    [SIS ID]       NVARCHAR (4000) NULL,
    [Campus]       NVARCHAR (4000) NULL,
    [Login]        NVARCHAR (4000) NULL,
    [First Name]   NVARCHAR (4000) NULL,
    [Last Name]    NVARCHAR (4000) NULL,
    [Middle Name]  NVARCHAR (1)    NULL,
    [AltStudentNo] NVARCHAR (4000) NULL,
    [Grade]        NVARCHAR (4000) NULL,
    [EnrolStatus]  NVARCHAR (4000) NULL,
    [EnrolStart]   DATETIME2 (7)   NULL,
    [EnrolEnd]     DATETIME2 (7)   NULL,
    [Order]        VARCHAR (1)     NOT NULL,
    [FTE]          NUMERIC (18, 7) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

