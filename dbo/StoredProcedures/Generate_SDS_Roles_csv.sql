CREATE PROC [dbo].[Generate_SDS_Roles_csv] AS
BEGIN

DECLARE @YearStart DATETIME2
DECLARE @YearEnd DATETIME2
DECLARE @CurrYr AS VARCHAR(4)

SELECT @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'


SELECT @YearStart = min(P.startDate),@YearEnd = max(P.endDate)
FROM emin.AcPeriod P inner join
     emin.COAcYear C ON P.CalendarAcademicYearId = c.CalendarAcademicYearId
where AcademicYearName = @CurrYr  and PeriodType = 'Term'


--SDS\roles.csv
--userSourcedId	orgSourcedId	role	sessionSourcedId	grade	isPrimary	roleStartDate	roleEndDate
select DISTINCT   '"' + [SIS ID] + '"' AS userSourcedId 
				, '"' + [School SIS ID] + '"' AS orgSourcedId
				,'"' + 'student'  + '"' AS ROLE
				, '"' + sessionSourcedId + '"'  AS sessionSourcedId 
				,CONCAT('"', Grade, '"') AS grade,
				CASE [Status] WHEN 'ACTIVE' THEN CONCAT('"', 1, '"') WHEN 'ACCEPTED' THEN CONCAT('"', 1, '"') WHEN 'STARTED' THEN CONCAT('"', 1, '"') ELSE  CONCAT('"', 0, '"') END as isPrimary
				, CONCAT('"', EnrolStart, '"') AS roleStartDate				
				, CONCAT('"', EnrolEnd, '"') AS roleEndDate
from sdsStudent inner join sdsOrgs on sdsStudent.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType in ('SDS','B') INNER JOIN sdsTerms ON sdsTerms.sourcedId = sdsStudent.sessionSourcedId

UNION

select	 '"' + userSourcedId + '"' AS userSourcedId
		, '"' + orgSourcedId + '"' AS orgSourcedId 
		, '"' + ROLE  + '"' AS ROLE
		, '"' + sessionSourcedId + '"'  AS sessionSourcedId
		,CONCAT('"', Grade, '"') AS grade
		,CASE WHEN ROW_NUMBER() OVER(PARTITION BY userSourcedId,orgSourcedId ORDER BY userSourcedId,[Order]) > 1 THEN CONCAT('"', 0, '"') ELSE  CONCAT('"',isPrimary, '"') end AS isPrimary
        ,CONCAT('"',roleStartDate, '"') AS roleStartDate
        ,CONCAT('"',roleEndDate, '"') AS roleEndDate
from 
	(
	select DISTINCT 1 as [Order], [SIS ID] as userSourcedId,[School SIS ID] as orgSourcedId,'teacher' as role,@CurrYr+ 'SY' as sessionSourcedId,NULL as grade,isPrimary,convert(varchar,@YearStart,23) as roleStartDate,convert(varchar,@YearEnd,23) as roleEndDate from sdsTeacher inner join sdsOrgs on sdsTeacher.[School SIS ID] = sdsOrgs.sourcedId AND sdsOrgs.ExportType in ('SDS','B') INNER JOIN sdsTerms ON sdsTerms.sourcedId = @CurrYr+ 'SY' WHERE Status <> 'Inactive' 
	UNION 
	select DISTINCT 0 as [Order], sdsLeaders.[sourcedId] as [userSourcedId],[Region] as [orgSourcedId], [role], @CurrYr+ 'SY' as sessionSourcedId,NULL as grade,isPrimary,convert(varchar,@YearStart,23) as roleStartDate,convert(varchar,@YearEnd,23) as roleEndDate FROM sdsLeaders inner join sdsOrgs on sdsLeaders.Region = sdsOrgs.sourcedId AND sdsOrgs.ExportType in ('SDS','B') INNER JOIN sdsTerms ON sdsTerms.sourcedId = @CurrYr+ 'SY' WHERE [Role] IS NOT NULL
	) A
ORDER BY 1,2
END
GO

