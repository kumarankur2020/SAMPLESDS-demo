CREATE TABLE [dbo].[sdsTerms] (
    [sourcedId]   NVARCHAR (4000) NULL,
    [title]       NVARCHAR (4000) NULL,
    [type]        NVARCHAR (4000) NULL,
    [schoolYear]  NVARCHAR (4000) NULL,
    [startDate]   VARCHAR (30)    NULL,
    [endDate]     VARCHAR (30)    NULL,
    [CurrentYear] INT             NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

