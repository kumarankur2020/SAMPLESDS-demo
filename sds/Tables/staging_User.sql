CREATE TABLE [sds].[staging_User] (
    [EmailAddress]  NVARCHAR (4000) NULL,
    [StaffEntityID] INT             NULL,
    [ExternalId]    NVARCHAR (4000) NULL,
    [AdUsername]    NVARCHAR (4000) NULL,
    [StaffID]       NVARCHAR (4000) NULL,
    [Firstname]     NVARCHAR (4000) NULL,
    [Surname]       NVARCHAR (4000) NULL,
    [DefaultCampus] NVARCHAR (4000) NULL,
    [Nactive]       INT             NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

