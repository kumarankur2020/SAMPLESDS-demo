CREATE EXTERNAL TABLE [emin].[AcPeriod] (
    [Campus] NVARCHAR (4000) NULL,
    [Course] NVARCHAR (4000) NULL,
    [Name] NVARCHAR (4000) NULL,
    [PeriodType] NVARCHAR (4000) NULL,
    [Term] NVARCHAR (4000) NULL,
    [StartDate] DATETIME2 (7) NULL,
    [EndDate] DATETIME2 (7) NULL,
    [NoWeeks] INT NULL,
    [NoDays] INT NULL,
    [fwLockUser] NVARCHAR (4000) NULL,
    [fwLockTime] DATETIME2 (7) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [Standard] INT NULL,
    [EventID] INT NULL,
    [EventType] NVARCHAR (4000) NULL,
    [EventCategory] NVARCHAR (4000) NULL,
    [StartTime] DATETIME2 (7) NULL,
    [EndTime] DATETIME2 (7) NULL,
    [Confirmed] INT NULL,
    [Frequency] NVARCHAR (4000) NULL,
    [Description] NVARCHAR (4000) NULL,
    [CalendarAcademicYearId] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/AcPeriod.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

