CREATE PROC [dbo].[PopulateTable_sdsStudentEnrollment] AS
BEGIN
 
DECLARE @CurrYr AS VARCHAR(4)
DECLARE @PrevYr AS VARCHAR(4)
DECLARE @YearStart DATETIME2

select @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
select @PrevYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr'

SELECT @YearStart = min(P.startDate)
FROM emin.AcPeriod P inner join
     sds.staging_COAcYear C ON P.CalendarAcademicYearId = c.CalendarAcademicYearId
where AcademicYearName = @CurrYr  and PeriodType = 'Term'

TRUNCATE TABLE [dbo].sdsStudentEnrollment

INSERT INTO [dbo].sdsStudentEnrollment

--StudentEnrollment.csv
SELECT EnrolmentID
      ,CASE WHEN Q.Year11_TimetableID is not null then Year11_TimetableID else [Section SIS ID] end as [Section SIS ID]
      ,'Student'+cast([SIS ID] AS varchar) AS [SIS ID]--, SISDATA.EffectiveStartDate, SISDATA.EffectiveEndDate, SISDATA.CompletionDate, SISDATA.EndDate, SISDATA.EnrolStatus
	  ,Campus
	  ,COALESCE(Q.EffectiveStartDate,SISDATA.EffectiveStartDate) AS EffectiveStartDate
--INTO sdsStudentEnrollment
FROM (
select e.EnrolmentId, tt.TimetableID AS [Section SIS ID],RIGHT(s.AltStudentNo, LEN(s.AltStudentNo) - 1) AS [SIS ID], min(tv.EffectiveStartDate) AS EffectiveStartDate, max(tv.effectiveenddate) AS EffectiveEndDate, e.EnrolStatus, e.EndDate, null as Completed, null as CompletionDate, e.Campus
	from sds.staging_Students s
				            inner join sds.staging_Enrolment e on s.StudentNo = e.Student
					        inner join sds.staging_Timetable tt on e.TimetableID = tt.TimetableID
						    inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID
						    inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
						    inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
						    inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null and u.Nactive = 0
						    inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid
							                            and c.academicyearname = @CurrYr
where tt.TimetableType <> 'module'
	and s.[Login] is not null
group by e.EnrolmentId, tt.TimetableID,s.AltStudentNo, e.EnrolStatus, e.EndDate, e.Campus
union
select e.EnrolmentId, tt.TimetableID AS [Section SIS ID],RIGHT(s.AltStudentNo, LEN(s.AltStudentNo) - 1) AS [SIS ID], min(tv.EffectiveStartDate), max(tv.effectiveenddate), e.EnrolStatus, e.EndDate, em.Completed, em.CompletionDate, e.Campus
	from sds.staging_Students s
				            inner join sds.staging_Enrolment e on s.StudentNo = e.Student
					        inner join sds.staging_EnrolledModule em on e.EnrolmentID = em.EnrolmentID
						    inner join sds.staging_Timetable tt on em.TimetableID = tt.TimetableID
							inner join sds.staging_TimetableVersion tv on tt.TimetableID = tv.TimetableID 
							inner join sds.staging_TimetableSession ts on tv.TimetableVersionID = ts.TimetableVersionID
							inner join sds.staging_TimetableSessionStaff tss on ts.TimetableSessionID = tss.TimeTableSessionID
							inner join sds.staging_User u on tss.staffentityid = u.staffentityid and u.ExternalID is not null and u.Nactive = 0
							inner join sds.staging_COAcYear c on tt.calendaracademicyearid = c.calendaracademicyearid
								                        and c.academicyearname = @CurrYr			
where tt.TimetableType = 'module'
  and s.[Login] is not null
  --and (em.CompletionDate is null or dateadd(dd,28,em.CompletionDate) > case when e.EndDate < tv.EffectiveEndDate then tv.EffectiveEndDate else e.EndDate end )
group by e.EnrolmentId, tt.TimetableID,s.AltStudentNo, e.EnrolStatus, e.EndDate, em.Completed, em.CompletionDate, e.Campus
) SISDATA LEFT JOIN dbo.QCE_Map Q ON Q.Year12_TimetableID = SISDATA.[Section SIS ID]
WHERE (SISDATA.EnrolStatus IN ('ACTIVE','STARTED') or
       (SISDATA.EnrolStatus = 'ACCEPTED' and SISDATA.EffectiveStartDate > dateadd(dd,-30,getdate())) or  
       (SISDATA.EnrolStatus = 'FINISHED' and dateadd(dd,28,SISDATA.EndDate) > getdate()))
and (COALESCE(Q.EffectiveStartDate,SISDATA.EffectiveStartDate) < @YearStart or
     (SISDATA.EffectiveStartDate >= @YearStart and dateadd(dd,-14,SISDATA.EffectiveStartDate) < getdate()))
and (SISDATA.CompletionDate is null or SISDATA.CompletionDate > GETDATE() or
     dateadd(dd,28,SISDATA.CompletionDate) > case when SISDATA.EndDate > SISDATA.EffectiveEndDate then SISDATA.EffectiveEndDate else SISDATA.EndDate end )
and  SISDATA.EffectiveStartDate <> SISDATA.EffectiveEndDate
--order by 1,2


END
GO

