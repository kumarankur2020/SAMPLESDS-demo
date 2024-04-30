CREATE EXTERNAL TABLE [emin].[ModuleLearningArea] (
    [ModuleLearningAreaID] INT NULL,
    [ModuleCode] NVARCHAR (4000) NULL,
    [LearningAreaCode] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/ModuleLearningArea.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

