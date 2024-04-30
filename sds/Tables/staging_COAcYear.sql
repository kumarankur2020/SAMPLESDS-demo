CREATE TABLE [sds].[staging_COAcYear] (
    [AcademicYearName]       NVARCHAR (4000) NULL,
    [Campus]                 NVARCHAR (4000) NULL,
    [Course]                 NVARCHAR (4000) NULL,
    [StartDate]              DATETIME2 (7)   NULL,
    [EndDate]                DATETIME2 (7)   NULL,
    [fwCreatedBy]            NVARCHAR (4000) NULL,
    [fwCreated]              DATETIME2 (7)   NULL,
    [fwUpdatedBy]            NVARCHAR (4000) NULL,
    [fwUpdated]              DATETIME2 (7)   NULL,
    [CalendarAcademicYearId] INT             NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([CalendarAcademicYearId]));
GO

