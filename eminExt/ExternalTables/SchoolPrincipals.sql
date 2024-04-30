CREATE EXTERNAL TABLE [eminExt].[SchoolPrincipals] (
    [SISID] NVARCHAR (4000) NULL,
    [Name] NVARCHAR (4000) NULL,
    [StateID] NVARCHAR (4000) NULL,
    [SchoolNumber] NVARCHAR (4000) NULL,
    [GradeLow] INT NULL,
    [GradeHigh] INT NULL,
    [PrincipalSISID] NVARCHAR (4000) NULL,
    [PrincipalName] NVARCHAR (4000) NULL,
    [PrincipalSecondaryEmail] NVARCHAR (4000) NULL,
    [Zone] NVARCHAR (4000) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinervaExt/SchoolPrincipals.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

