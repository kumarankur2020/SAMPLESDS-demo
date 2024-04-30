CREATE EXTERNAL TABLE [emin].[Relationship] (
    [RelationshipId] INT NULL,
    [EntityId1] INT NULL,
    [EntityId2] INT NULL,
    [RelationshipType1To2] NVARCHAR (4000) NULL,
    [RelationshipType2To1] NVARCHAR (4000) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/Relationship.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

