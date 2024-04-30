CREATE EXTERNAL TABLE [emin].[Ext] (
    [EmailAddress] NVARCHAR (4000) NULL,
    [ImpersonatedEmailAddress] NVARCHAR (4000) NULL,
    [ID] INT NULL,
    [ImpersonatedID] INT NULL,
    [teamsite] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinervaExt/mySite_Impersonation.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

