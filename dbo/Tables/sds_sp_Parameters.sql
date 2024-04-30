CREATE TABLE [dbo].[sds_sp_Parameters] (
    [ParameterID]     INT            NOT NULL,
    [CommonParameter] CHAR (50)      NOT NULL,
    [ParameterName]   CHAR (50)      NOT NULL,
    [ParameterValue]  VARCHAR (4000) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);
GO

