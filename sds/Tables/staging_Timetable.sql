CREATE TABLE [sds].[staging_Timetable] (
    [TimetableType]          NVARCHAR (4000) NULL,
    [TimetableName]          NVARCHAR (4000) NULL,
    [Campus]                 NVARCHAR (4000) NULL,
    [Course]                 NVARCHAR (4000) NULL,
    [TimetableID]            INT             NULL,
    [CalendarAcademicYearId] INT             NULL,
    [StaffEntityID]          INT             NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TimetableID]));
GO

