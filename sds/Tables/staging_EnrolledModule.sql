CREATE TABLE [sds].[staging_EnrolledModule] (
    [EnrolmentId]    INT           NULL,
    [TimetableId]    INT           NULL,
    [Completed]      INT           NULL,
    [CompletionDate] DATETIME2 (7) NULL,
    [StartDate]      DATETIME2 (7) NULL,
    [EndDate]        DATETIME2 (7) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

