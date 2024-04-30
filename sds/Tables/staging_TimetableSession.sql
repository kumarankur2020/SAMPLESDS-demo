CREATE TABLE [sds].[staging_TimetableSession] (
    [TimetableSessionId] INT NULL,
    [TimetableVersionID] INT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TimetableSessionId]));
GO

