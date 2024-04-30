CREATE EXTERNAL TABLE [emin].[TimetableModule] (
    [Module] NVARCHAR (4000) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [TimetableModuleID] INT NULL,
    [TimetableID] INT NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/TimetableModule.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

