CREATE TABLE [dbo].[sdsStudent] (
    [SIS ID]           VARCHAR (37)    NULL,
    [School SIS ID]    NVARCHAR (4000) NULL,
    [Username]         NVARCHAR (4000) NULL,
    [First Name]       NVARCHAR (4000) NULL,
    [Last Name]        NVARCHAR (4000) NULL,
    [Middle Name]      NVARCHAR (1)    NULL,
    [Student Number]   NVARCHAR (4000) NULL,
    [Grade]            NVARCHAR (4000) NULL,
    [Status]           NVARCHAR (4000) NULL,
    [EnrolStart]       VARCHAR (30)    NULL,
    [EnrolEnd]         VARCHAR (30)    NULL,
    [FTE]              NUMERIC (18, 7) NULL,
    [sessionSourcedId] VARCHAR (6)     NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

CREATE STATISTICS [Student_Student_Number]
    ON [dbo].[sdsStudent]([Student Number]);
GO

CREATE NONCLUSTERED INDEX [sdsStudent_index]
    ON [dbo].[sdsStudent]([Student Number] ASC);
GO

