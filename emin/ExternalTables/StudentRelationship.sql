CREATE EXTERNAL TABLE [emin].[StudentRelationship] (
    [RelationshipId] INT NULL,
    [Priority] INT NULL,
    [Pickup] INT NULL,
    [ParentGuardian] INT NULL,
    [MainContact] INT NULL,
    [Communication] INT NULL,
    [Resident] INT NULL,
    [EmergencySeq] INT NULL,
    [Active] INT NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [PayFeePercentage] NUMERIC (8, 7) NULL,
    [ReceiveReports] BIT NULL,
    [ReceiveNewsletters] BIT NULL,
    [ReceiveInvitations] BIT NULL,
    [Comments] NVARCHAR (4000) NULL,
    [PortalAccess] BIT NULL,
    [Caregiver] BIT NULL,
    [ReceiveSMS] BIT NULL,
    [PermissionForms] BIT NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/StudentRelationship.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

