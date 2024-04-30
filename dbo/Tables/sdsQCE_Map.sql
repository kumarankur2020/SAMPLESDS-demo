CREATE TABLE [dbo].[sdsQCE_Map] (
    [Year11_TimetableID] INT             NULL,
    [Year12_TimetableID] INT             NULL,
    [TimetableName]      NVARCHAR (4000) NULL,
    [EffectiveStartDate] DATETIME2 (7)   NULL,
    [EffectiveEndDate]   DATETIME2 (7)   NULL,
    [academicyearname]   NVARCHAR (4000) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

