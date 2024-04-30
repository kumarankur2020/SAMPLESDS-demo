CREATE EXTERNAL TABLE [emin].[COAcYear] (
    [AcademicYearName] NVARCHAR (4000) NULL,
    [Campus] NVARCHAR (4000) NULL,
    [Course] NVARCHAR (4000) NULL,
    [StartDate] DATETIME2 (7) NULL,
    [EndDate] DATETIME2 (7) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [CalendarAcademicYearId] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/COAcYear.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

