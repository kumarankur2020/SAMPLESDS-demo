CREATE PROC [Create_Staging_tbl_CoachYr] AS
BEGIN

CREATE TABLE [sds].[staging_COAcYear]  WITH (DISTRIBUTION = HASH([CalendarAcademicYearId]) ) AS SELECT * FROM emin.COAcYear where AcademicYearName in (SELECT ParameterValue from sds_sp_Parameters where commonparameter = 'YearRange') 
OPTION (LABEL = 'CTAS : Load COAcYear');

ALTER INDEX ALL ON [sds].[staging_COAcYear]        REBUILD;

END
GO

