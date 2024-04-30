CREATE EXTERNAL TABLE [eminExt].[Leaders] (
    [Region] NVARCHAR (4000) NULL,
    [JobTitle] NVARCHAR (4000) NULL,
    [EmailAddress] NVARCHAR (4000) NULL,
    [FirstName] NVARCHAR (4000) NULL,
    [LastName] NVARCHAR (4000) NULL,
    [eMinervaStaffEntityID] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinervaExt/Leaders.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

