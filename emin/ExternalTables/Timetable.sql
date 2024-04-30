CREATE EXTERNAL TABLE [emin].[Timetable] (
    [TimetableType] NVARCHAR (4000) NULL,
    [TimetableName] NVARCHAR (4000) NULL,
    [Campus] NVARCHAR (4000) NULL,
    [AcademicPeriod] NVARCHAR (4000) NULL,
    [Course] NVARCHAR (4000) NULL,
    [MaximumPlaces] INT NULL,
    [MinimumPlaces] INT NULL,
    [TimetableCycle] NVARCHAR (4000) NULL,
    [IsEminervaManaged] BIT NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [TimetableID] INT NULL,
    [CalendarAcademicYearId] INT NULL,
    [StaffEntityID] INT NULL,
    [RoomCode] NVARCHAR (4000) NULL,
    [RoomCampus] NVARCHAR (4000) NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/Timetable.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

