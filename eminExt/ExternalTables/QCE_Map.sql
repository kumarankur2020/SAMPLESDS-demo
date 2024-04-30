CREATE EXTERNAL TABLE [eminExt].[QCE_Map] (
    [Year11_TimetableID] INT NULL,
    [Year12_TimetableID] INT NULL,
    [TimetableName] NVARCHAR (4000) NULL,
    [EffectiveStartDate] DATETIME2 (7) NULL,
    [EffectiveEndDate] DATETIME2 (7) NULL,
    [academicyearname] NVARCHAR (4000) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinervaExt/QCE_Map.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

