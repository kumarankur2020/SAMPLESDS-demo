CREATE TABLE [sds].[staging_Enrolment] (
    [EnrolmentID]            INT             NULL,
    [Student]                INT             NULL,
    [Course]                 NVARCHAR (4000) NULL,
    [Campus]                 NVARCHAR (4000) NULL,
    [StartDate]              DATETIME2 (7)   NULL,
    [EndDate]                DATETIME2 (7)   NULL,
    [EnrolStatus]            NVARCHAR (4000) NULL,
    [EnrolCategory]          NVARCHAR (4000) NULL,
    [CalendarAcademicYearId] INT             NULL,
    [FTE]                    NUMERIC (18, 7) NULL,
    [TimetableID]            INT             NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([EnrolmentID]));
GO

