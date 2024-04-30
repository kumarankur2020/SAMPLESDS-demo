CREATE EXTERNAL TABLE [emin].[TimetableSession] (
    [DayOfCycle] NVARCHAR (4000) NULL,
    [StartTime] DATETIME2 (7) NULL,
    [EndTime] DATETIME2 (7) NULL,
    [StudyPeriod] NVARCHAR (4000) NULL,
    [CampusSession] NVARCHAR (4000) NULL,
    [Room] NVARCHAR (4000) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [TimetableSessionID] INT NULL,
    [TimetableVersionID] INT NULL,
    [SessionPeriodID] INT NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/TimetableSession.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

