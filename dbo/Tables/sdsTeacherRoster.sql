CREATE TABLE [dbo].[sdsTeacherRoster] (
    [Section SIS ID] INT             NULL,
    [SIS ID]         VARCHAR (37)    NULL,
    [Campus]         NVARCHAR (4000) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

