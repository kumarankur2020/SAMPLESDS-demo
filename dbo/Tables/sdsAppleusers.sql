CREATE TABLE [dbo].[sdsAppleusers] (
    [person_id]     VARCHAR (37)    NULL,
    [person_number] NVARCHAR (4000) NULL,
    [first_name]    NVARCHAR (4000) NULL,
    [middle_name]   NVARCHAR (1)    NULL,
    [last_name]     NVARCHAR (4000) NULL,
    [email_address] NVARCHAR (40)   NULL,
    [sis_username]  NVARCHAR (4000) NULL,
    [location_id]   NVARCHAR (4000) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

