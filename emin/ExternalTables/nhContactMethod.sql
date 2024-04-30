CREATE EXTERNAL TABLE [emin].[nhContactMethod] (
    [ContactMethodType] NVARCHAR (4000) NULL,
    [ContactValue] NVARCHAR (4000) NULL,
    [Priority] INT NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [AddressType] NVARCHAR (4000) NULL,
    [Unpublished] BIT NULL,
    [ContactMethodID] INT NULL,
    [EntityID] INT NULL,
    [Notes] NVARCHAR (4000) NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/nhContactMethod.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

