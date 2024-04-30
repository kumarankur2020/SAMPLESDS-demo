CREATE EXTERNAL TABLE [emin].[nhStudent] (
    [StudentNo] INT NULL,
    [AltStudentNo] NVARCHAR (4000) NULL,
    [PotentialStudentNo] NVARCHAR (4000) NULL,
    [NSN] NVARCHAR (4000) NULL,
    [StudStatus] NVARCHAR (4000) NULL,
    [School] NVARCHAR (4000) NULL,
    [FamilyRep] INT NULL,
    [MarketingSource] NVARCHAR (4000) NULL,
    [International] INT NULL,
    [HCNo] NVARCHAR (4000) NULL,
    [HCExDate] DATETIME2 (7) NULL,
    [IndigStatusId] NVARCHAR (4000) NULL,
    [PacificLLI] NVARCHAR (4000) NULL,
    [MaoriLLI] NVARCHAR (4000) NULL,
    [StartSchoolDate] DATETIME2 (7) NULL,
    [Alumni] INT NULL,
    [HomeRoom] NVARCHAR (4000) NULL,
    [House] NVARCHAR (4000) NULL,
    [YearLevel] NVARCHAR (4000) NULL,
    [FundType] NVARCHAR (4000) NULL,
    [ZoneStatus] NVARCHAR (4000) NULL,
    [ORRS] NVARCHAR (4000) NULL,
    [LeavingDate] DATETIME2 (7) NULL,
    [LeavingReason] NVARCHAR (4000) NULL,
    [ScholasticYear] NVARCHAR (4000) NULL,
    [Year12] NVARCHAR (4000) NULL,
    [Year12StudentNo] NVARCHAR (4000) NULL,
    [Year12Year] INT NULL,
    [Year12School] NVARCHAR (4000) NULL,
    [Year12State] NVARCHAR (4000) NULL,
    [TEScore] INT NULL,
    [ECE] NVARCHAR (4000) NULL,
    [SecQual] NVARCHAR (4000) NULL,
    [NonNQFQual] NVARCHAR (4000) NULL,
    [UE] INT NULL,
    [NewSchoolNum] NVARCHAR (4000) NULL,
    [StudentSpare1] NVARCHAR (4000) NULL,
    [StudentSpare2] NVARCHAR (4000) NULL,
    [StudentSpare3] NVARCHAR (4000) NULL,
    [StudentSpare4] NVARCHAR (4000) NULL,
    [StudentSpare5] NVARCHAR (4000) NULL,
    [GCCStatus] NVARCHAR (4000) NULL,
    [GCCExpiryDate] DATETIME2 (7) NULL,
    [IsIndependent] BIT NULL,
    [IndependentStatusDate] DATETIME2 (7) NULL,
    [IndependentStatus] NVARCHAR (4000) NULL,
    [SightingEvidenceDate] DATETIME2 (7) NULL,
    [PreviousSchool] NVARCHAR (4000) NULL,
    [RegionalStudentNumber] NVARCHAR (4000) NULL,
    [MainSchool] NVARCHAR (4000) NULL,
    [FeeAssisted] BIT NULL,
    [InternationalStudentType] NVARCHAR (4000) NULL,
    [FinancialAssistance] BIT NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [EntityID] INT NULL,
    [LibraryCardNo] NVARCHAR (4000) NULL,
    [LocalResident] BIT NULL,
    [ApplicantClassification] NVARCHAR (4000) NULL,
    [ESLSupport] BIT NULL,
    [Login] NVARCHAR (4000) NULL,
    [StudentIdentifier1] NVARCHAR (4000) NULL,
    [UniqueStudentIdentifier] NVARCHAR (4000) NULL,
    [LastVerified] DATETIME2 (7) NULL,
    [USIType] NVARCHAR (4000) NULL,
    [USIStatus] NVARCHAR (4000) NULL,
    [ChangeStart] DATETIME2 (7) NULL,
    [ChangeEnd] DATETIME2 (7) NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/nhStudent.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

