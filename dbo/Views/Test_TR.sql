CREATE VIEW [Test_TR]
AS select   t.TimetableID --AS [Section SIS ID]
				,t.StaffEntityID --AS [SIS ID]
				,t.Campus--,tv.VersionNumber,t.StaffEntityID
		from emin.TimetableSession ts inner join emin.TimetableSessionStaff tss on tss.TimetableSessionID = ts.TimetableSessionID
										inner join emin.TimetableVersion tv on ts.TimetableVersionID = tv.TimetableVersionID AND tv.EffectiveEndDate <> tv.EffectiveStartDate
										inner join emin.Timetable t on tv.TimetableID = t.TimetableID		
										inner join emin.[User] u on t.StaffEntityID = u.StaffEntityID and u.ExternalID is not null
										inner join emin.COAcYear c on t.calendaracademicyearid = c.calendaracademicyearid
																	and (c.academicyearname = 		(Select parametervalue from sds_sp_parameters where parametername = 'CurrYr')) 
											left join emin.TimetableModule tm on t.timetableid = tm.timetableid
											left join emin.ModuleLearningArea mla on tm.module = mla.modulecode 
		where tv.VersionNumber =  (select max(VersionNumber) from emin.TimetableSession ts1 
											inner join emin.TimetableSessionStaff tss1 on tss1.TimetableSessionID = ts1.TimetableSessionID 
											inner join emin.TimetableVersion tv1 on ts1.TimetableVersionID = tv1.TimetableVersionID 
									where t.TimetableID = tv1.TimetableID AND (tv1.EffectiveStartDate <= GetDATE() or (tv1.EffectiveStartDate > GetDATE() and VersionNumber = 1))) 

		AND t.TimetableType <> 'ACTIVITY';
GO

