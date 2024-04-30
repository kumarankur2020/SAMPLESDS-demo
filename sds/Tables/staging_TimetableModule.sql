CREATE TABLE [sds].[staging_TimetableModule] (
    [Module]            NVARCHAR (4000) NULL,
    [fwCreatedBy]       NVARCHAR (4000) NULL,
    [fwCreated]         DATETIME2 (7)   NULL,
    [fwUpdatedBy]       NVARCHAR (4000) NULL,
    [fwUpdated]         DATETIME2 (7)   NULL,
    [TimetableModuleID] INT             NULL,
    [TimetableID]       INT             NULL,
    [ChangeStart]       DATETIME2 (7)   NULL,
    [ChangeEnd]         DATETIME2 (7)   NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([TimetableModuleID]));
GO

