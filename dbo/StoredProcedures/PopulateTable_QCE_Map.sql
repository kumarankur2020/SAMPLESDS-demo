CREATE PROC [dbo].[PopulateTable_QCE_Map] AS
BEGIN
INSERT INTO dbo.QCE_Map
SELECT * FROM eminExt.QCE_Map

END
GO

