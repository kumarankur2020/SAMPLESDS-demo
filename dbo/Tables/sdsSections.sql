CREATE TABLE [dbo].[sdsSections] (
    [SIS ID]         INT             NULL,
    [School SIS ID]  NVARCHAR (4000) NULL,
    [Section Name]   NVARCHAR (4000) NULL,
    [Section Number] NVARCHAR (4000) NULL,
    [Course SIS ID]  INT             NULL,
    [Course Name]    NVARCHAR (4000) NULL,
    [Course Number]  NVARCHAR (4000) NULL,
    [Term StartDate] VARCHAR (30)    NULL,
    [Term EndDate]   VARCHAR (30)    NULL,
    [TermId]         VARCHAR (6)     NULL,
    [Subject]        INT             NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

