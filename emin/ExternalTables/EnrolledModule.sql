CREATE EXTERNAL TABLE [emin].[EnrolledModule] (
    [Module] NVARCHAR (4000) NULL,
    [EnrolmentID] INT NULL,
    [Core] INT NULL,
    [AttemptNo] INT NULL,
    [fwLockUser] NVARCHAR (4000) NULL,
    [fwLockTime] DATETIME2 (7) NULL,
    [fwCreatedBy] NVARCHAR (4000) NULL,
    [fwCreated] DATETIME2 (7) NULL,
    [fwUpdatedBy] NVARCHAR (4000) NULL,
    [fwUpdated] DATETIME2 (7) NULL,
    [Result] NVARCHAR (4000) NULL,
    [Mark] NUMERIC (18, 2) NULL,
    [ResultDate] DATETIME2 (7) NULL,
    [Completed] INT NULL,
    [CompletionDate] DATETIME2 (7) NULL,
    [Creditpoints] INT NULL,
    [SubModuleStatus] NVARCHAR (4000) NULL,
    [ResultNotes] NVARCHAR (4000) NULL,
    [AVET_StartDate] DATETIME2 (7) NULL,
    [AVET_EndDate] DATETIME2 (7) NULL,
    [AVET_SchedHours] INT NULL,
    [AVET_HoursAttended] INT NULL,
    [AVET_OutcomeTOrg] NVARCHAR (4000) NULL,
    [AVET_FundSourceState] NVARCHAR (4000) NULL,
    [AVET_FundSourceNAT] NVARCHAR (4000) NULL,
    [AVET_DeliveryType] NVARCHAR (4000) NULL,
    [AVET_CommCourseEnrolmentID] NVARCHAR (4000) NULL,
    [AVET_TuitionFee] NUMERIC (18, 2) NULL,
    [AVET_OutcomeNAT] NVARCHAR (4000) NULL,
    [ModAttend] NVARCHAR (4000) NULL,
    [StudentStatusMod] NVARCHAR (4000) NULL,
    [WorkExp] NVARCHAR (4000) NULL,
    [AssistanceType] NVARCHAR (4000) NULL,
    [Hours] INT NULL,
    [LearnZone] NVARCHAR (4000) NULL,
    [InstructionMode] NVARCHAR (4000) NULL,
    [StudentLoad] NUMERIC (18, 9) NULL,
    [DESTSubmissionCode] NVARCHAR (4000) NULL,
    [HEPSumSchool] INT NULL,
    [StartDate] DATETIME2 (7) NULL,
    [EndDate] DATETIME2 (7) NULL,
    [EMModeStudy] NVARCHAR (4000) NULL,
    [EMModeCat] NVARCHAR (4000) NULL,
    [CopyPreviousModule] INT NULL,
    [IsEminervaManaged] BIT NULL,
    [TimetableID] INT NULL
)
    WITH (
    DATA_SOURCE = [sds-raw-data_bceaaesdslake2_dfs_core_windows_net],
    LOCATION = N'eMinerva/EnrolledModule.parquet',
    FILE_FORMAT = [SynapseParquetFormat],
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
    );
GO

