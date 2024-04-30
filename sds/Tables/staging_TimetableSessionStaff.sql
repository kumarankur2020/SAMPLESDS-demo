CREATE TABLE [sds].[staging_TimetableSessionStaff] (
    [TimetableSessionStaffid] INT NULL,
    [staffEntityID]           INT NULL,
    [TimetablesessionID]      INT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TimetableSessionStaffid]));
GO

