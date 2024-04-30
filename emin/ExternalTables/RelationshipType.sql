CREATE EXTERNAL TABLE [emin].[RelationshipType] (
    [Campus] NVARCHAR (4000) NULL,
    [Code] NVARCHAR (4000) NULL,
    [Name] NVARCHAR (4000) NULL,
    [IsFamilyUnitLink] INT NULL,
    [IsSibling] INT NULL,
    [Notes] NVARCHAR (4000) NULL,
    [Inactive] INT NULL,
    [Gender] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [Systype] NVARCHAR (4000) NULL,
    [Seq] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/RelationshipType.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

