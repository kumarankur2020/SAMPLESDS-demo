CREATE EXTERNAL TABLE [emin].[SysTable] (
    [SysType] NVARCHAR (4000) NULL,
    [Code] NVARCHAR (4000) NULL,
    [Description] NVARCHAR (4000) NULL,
    [Name] NVARCHAR (4000) NULL,
    [SysCode] INT NULL,
    [Numeric1] INT NULL,
    [Numeric2] INT NULL,
    [bool1] INT NULL,
    [bool2] INT NULL,
    [Nactive] INT NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [Decimal1] NUMERIC (18, 7) NULL,
    [Decimal2] NUMERIC (18, 7) NULL,
    [Bool3] INT NULL,
    [Date1] DATETIME2 (7) NULL,
    [Alpha1] NVARCHAR (4000) NULL,
    [Alpha2] NVARCHAR (4000) NULL,
    [Alpha3] NVARCHAR (4000) NULL,
    [Alpha5] NVARCHAR (4000) NULL,
    [Time1] DATETIME2 (7) NULL,
    [Time2] DATETIME2 (7) NULL,
    [Date2] DATETIME2 (7) NULL,
    [Alpha4] NVARCHAR (4000) NULL,
    [Campus] NVARCHAR (4000) NULL,
    [Seq] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/SysTable.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

