CREATE EXTERNAL TABLE [emin].[nhEntityAddress] (
    [AddressType] NVARCHAR (4000) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [MailTitle] NVARCHAR (4000) NULL,
    [EntityAddressID] INT NULL,
    [AddressID] INT NULL,
    [EntityID] INT NULL,
    [MailSalutation] NVARCHAR (4000) NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/nhEntityAddress.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

