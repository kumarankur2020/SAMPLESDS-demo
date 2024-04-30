CREATE EXTERNAL TABLE [eminExt].[SeniorLeaders] (
    [Email] NVARCHAR (4000) NULL,
    [Region] NVARCHAR (4000) NULL,
    [Role] NVARCHAR (4000) NULL,
    [isPrimary] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinervaExt/SeniorLeaders.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

