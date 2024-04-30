CREATE EXTERNAL TABLE [emin].[nhAddress] (
    [DPID] INT NULL,
    [StreetNumber] NVARCHAR (4000) NULL,
    [Street1] NVARCHAR (4000) NULL,
    [Street2] NVARCHAR (4000) NULL,
    [Suburb] NVARCHAR (4000) NULL,
    [City] NVARCHAR (4000) NULL,
    [State] NVARCHAR (4000) NULL,
    [Postcode] NVARCHAR (4000) NULL,
    [Country] NVARCHAR (4000) NULL,
    [GeocodeLongitude] INT NULL,
    [GeocodeLatitude] INT NULL,
    [Barcode] NVARCHAR (4000) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [DateVerified] DATETIME2 (7) NULL,
    [AddressID] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/nhAddress.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

