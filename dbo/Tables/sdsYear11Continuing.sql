CREATE TABLE [dbo].[sdsYear11Continuing] (
    [Year11_TimetableID] INT             NULL,
    [Campus]             NVARCHAR (4000) NULL,
    [TimetableName]      NVARCHAR (4000) NULL,
    [Course]             NVARCHAR (4000) NULL,
    [SubjectIdentifier]  NVARCHAR (4000) NULL,
    [EffectiveStartDate] DATETIME2 (7)   NULL,
    [EffectiveEndDate]   DATETIME2 (7)   NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

