CREATE EXTERNAL DATA SOURCE [eMinSDSDataFiles]
    WITH (
    LOCATION = N'$(DATA_LAKE_STORAGE_ACCOUNT_SDS_RAW_DATA)'
    );
GO

