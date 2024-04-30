CREATE EXTERNAL TABLE [eminExt].[SchoolDataExportManager] (
    [ExportType] NVARCHAR (4000) NULL,
    [Campus] NVARCHAR (4000) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinervaExt/SchoolDataExportManager.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

