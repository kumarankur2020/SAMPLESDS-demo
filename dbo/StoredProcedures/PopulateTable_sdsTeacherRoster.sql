CREATE PROC [dbo].[PopulateTable_sdsTeacherRoster] AS
BEGIN

DECLARE @CurrYr AS VARCHAR(4), @PrevYr AS VARCHAR(4)

select @CurrYr= ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'CurrYr'
select @PrevYr = ParameterValue FROM [dbo].[sds_sp_Parameters] where parametername = 'PrevYr'   


TRUNCATE TABLE [dbo].[sdsTeacherRoster]

INSERT INTO [dbo].[sdsTeacherRoster]
--TeacherRoster.csv
SELECT CASE WHEN Q.Year11_TimetableID is not null then Year11_TimetableID else [Section SIS ID] end as [Section SIS ID]
      ,'Teacher'+cast([SIS ID] AS varchar) AS [SIS ID]
	  ,Campus
--INTO sdsTeacherRoster
FROM (
SELECT DISTINCT [Section SIS ID],[SIS ID],Campus FROM (
	SELECT DISTINCT [Section SIS ID],[SIS ID] ,ROW_NUMBER() OVER(PARTITION BY [Section SIS ID] ORDER BY [SIS ID] DESC) AS RowNumber ,Campus --TEST kumar kumar
	FROM (
		select distinct t.TimetableID AS [Section SIS ID]
				,t.StaffEntityID AS [SIS ID]
				,t.Campus--,tv.VersionNumber,t.StaffEntityID
		from sds.staging_TimetableSession ts inner join sds.staging_TimetableSessionStaff tss on tss.TimetableSessionID = ts.TimetableSessionID
										inner join sds.staging_TimetableVersion tv on ts.TimetableVersionID = tv.TimetableVersionID AND tv.EffectiveEndDate <> tv.EffectiveStartDate
										inner join sds.staging_Timetable t on tv.TimetableID = t.TimetableID		
										inner join sds.staging_User u on t.StaffEntityID = u.StaffEntityID and u.ExternalID is not null
										inner join sds.staging_COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid
																	and (c.academicyearname = @CurrYr) 
											left join sds.staging_TimetableModule tm on t.timetableid = tm.timetableid
											left join emin.ModuleLearningArea mla on tm.module = mla.modulecode 
		where tv.VersionNumber =  (select max(VersionNumber) from sds.staging_TimetableSession ts1 
											inner join sds.staging_TimetableSessionStaff tss1 on tss1.TimetableSessionID = ts1.TimetableSessionID 
											inner join sds.staging_TimetableVersion tv1 on ts1.TimetableVersionID = tv1.TimetableVersionID 
									where t.TimetableID = tv1.TimetableID AND (tv1.EffectiveStartDate <= GetDATE() or (tv1.EffectiveStartDate > GetDATE() and VersionNumber = 1))) 
		AND t.TimetableType <> 'ACTIVITY'
UNION
       select distinct t.TimetableID AS [Section SIS ID]
				,u.StaffEntityID AS [SIS ID]
				,t.Campus
		from sds.staging_TimetableSession ts inner join sds.staging_TimetableSessionStaff tss on tss.TimetableSessionID = ts.TimetableSessionID
										inner join sds.staging_TimetableVersion tv on ts.TimetableVersionID = tv.TimetableVersionID AND tv.EffectiveEndDate <> tv.EffectiveStartDate
										inner join sds.staging_Timetable t on tv.TimetableID = t.TimetableID		
										inner join sds.staging_User u on tss.StaffEntityID = u.StaffEntityID and u.ExternalID is not null
										inner join sds.staging_COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid
																	and (c.academicyearname = @CurrYr) 
											left join sds.staging_TimetableModule tm on t.timetableid = tm.timetableid
											left join emin.ModuleLearningArea mla on tm.module = mla.modulecode 
		where tv.VersionNumber =  (select max(VersionNumber) from sds.staging_TimetableSession ts1 
											inner join sds.staging_TimetableSessionStaff tss1 on tss1.TimetableSessionID = ts1.TimetableSessionID 
											inner join sds.staging_TimetableVersion tv1 on ts1.TimetableVersionID = tv1.TimetableVersionID 
									where t.TimetableID = tv1.TimetableID AND (tv1.EffectiveStartDate <= GetDATE() or (tv1.EffectiveStartDate > GetDATE() and VersionNumber = 1))) 
		AND t.TimetableType <> 'ACTIVITY'
UNION
		select distinct t.TimetableID AS [Section SIS ID]
				,u.StaffEntityID1 AS [SIS ID]
				,t.Campus
		from sds.staging_TimetableSession ts inner join sds.staging_TimetableSessionStaff tss on tss.TimetableSessionID = ts.TimetableSessionID
										inner join sds.staging_TimetableVersion tv on ts.TimetableVersionID = tv.TimetableVersionID AND tv.EffectiveEndDate <> tv.EffectiveStartDate
										inner join sds.staging_Timetable t on tv.TimetableID = t.TimetableID		
										inner join (select U1.StaffEntityID AS StaffEntityID1, U2.StaffEntityID AS StaffEntityID2, 0 AS Nactive
														  from sds.staging_User U1, eminext.Impersonation I, sds.staging_User U2
														 where U1.EmailAddress = 'CATHOLIC\'+I.EmailAddress
														   and I.teamsite = 1
														   and 'CATHOLIC\'+left(I.ImpersonatedEmailAddress, CHARINDEX('@',I.ImpersonatedEmailAddress)-1) = U2.EmailAddress
														   and u2.ExternalID is not null
														   and U1.StaffEntityID is not null) u on tss.StaffEntityID = u.StaffEntityID2
										inner join sds.staging_COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid
																	and (c.academicyearname = @CurrYr) 
											left join sds.staging_TimetableModule tm on t.timetableid = tm.timetableid
											left join emin.ModuleLearningArea mla on tm.module = mla.modulecode 
		where tv.VersionNumber =  (select max(VersionNumber) from sds.staging_TimetableSession ts1 
											inner join sds.staging_TimetableSessionStaff tss1 on tss1.TimetableSessionID = ts1.TimetableSessionID 
											inner join sds.staging_TimetableVersion tv1 on ts1.TimetableVersionID = tv1.TimetableVersionID 
									where t.TimetableID = tv1.TimetableID  AND (tv1.EffectiveStartDate <= GetDATE() or (tv1.EffectiveStartDate > GetDATE() and VersionNumber = 1))) 
		AND t.TimetableType <> 'ACTIVITY'
	) TR
) TeacherRoster WHERE Rownumber <= 10
) SISDATA LEFT JOIN dbo.QCE_Map Q ON Q.Year12_TimetableID = SISDATA.[Section SIS ID]
--order by 1,2
End
GO

