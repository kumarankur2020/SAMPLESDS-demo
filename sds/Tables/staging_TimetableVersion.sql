CREATE TABLE [sds].[staging_TimetableVersion] (
    [VersionNumber]      INT           NULL,
    [EffectiveStartDate] DATETIME2 (7) NULL,
    [EffectiveEndDate]   DATETIME2 (7) NULL,
    [TimetableVersionId] INT           NULL,
    [TimetableID]        INT           NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TimetableVersionId]));
GO

