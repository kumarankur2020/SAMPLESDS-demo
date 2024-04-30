CREATE TABLE [dbo].[sdsStudentEnrollment] (
    [EnrolmentID]        INT             NULL,
    [Section SIS ID]     INT             NULL,
    [SIS ID]             VARCHAR (37)    NULL,
    [Campus]             NVARCHAR (4000) NULL,
    [EffectiveStartDate] DATETIME        NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

