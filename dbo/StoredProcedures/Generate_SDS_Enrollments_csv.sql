CREATE PROC [dbo].[Generate_SDS_Enrollments_csv] AS
BEGIN

--SDS\enrollments.csv
--classSourcedId	userSourcedId	role

SELECT CONCAT('"', [Section SIS ID], '"') AS classSourcedId,
       CONCAT('"', [SIS ID], '"') AS userSourcedId,
       CONCAT('"', 'teacher', '"') AS role
FROM ( 
	SELECT [Section SIS ID], [SIS ID], Campus ,  row_number() over( order by [Section SIS ID] , [SIS ID], Campus) as Seq
	FROM sdsTeacherRoster 
) TR
INNER JOIN sdsOrgs ON TR.Campus = sdsOrgs.sourcedId
AND sdsOrgs.ExportType in ('SDS',
                         'B')
WHERE EXISTS
    (SELECT 1
     FROM sdsTeacher T
     WHERE T.[SIS ID] = TR.[SIS ID]
       AND T.Status <> 'Inactive')
UNION


SELECT CONCAT('"', [Section SIS ID], '"') AS classSourcedId,
       CONCAT('"', [SIS ID], '"') AS userSourcedId,
       CONCAT('"', 'student', '"') AS role
FROM 
(
	select EnrolmentId, [Section SIS ID], [SIS ID], Campus, EffectiveStartDate, row_number() over( order by EnrolmentId ,[Section SIS ID] ) as Seq
	from sdsStudentEnrollment 
) SE
INNER JOIN sdsOrgs ON SE.Campus = sdsOrgs.sourcedId
AND sdsOrgs.ExportType in ('SDS',
                         'B')
WHERE EXISTS
    (SELECT 1
     FROM sdsTeacher T
     INNER JOIN sdsTeacherRoster ON T.[SIS ID] = sdsTeacherRoster.[SIS ID]
     AND sdsTeacherRoster.[Section SIS ID] = SE.[Section SIS ID]
     AND T.Status <> 'Inactive')
ORDER BY 1,2
END

/*
--SDS\enrollments.csv
--classSourcedId	userSourcedId	role
select [Section SIS ID] as classSourcedId,[SIS ID] as userSourcedId,'teacher' as role from #TeacherRoster inner join #Orgs on #TeacherRoster.Campus = #Orgs.sourcedId AND #Orgs.ExportType in ('SDS','B') WHERE EXISTS (SELECT 1 FROM #Teacher T WHERE T.[SIS ID] = #TeacherRoster.[SIS ID] AND T.Status <> 'Inactive')
UNION 
select [Section SIS ID] as classSourcedId,[SIS ID] as userSourcedId,'student' as role from #StudentEnrollment inner join #Orgs on #StudentEnrollment.Campus = #Orgs.sourcedId AND #Orgs.ExportType in ('SDS','B') WHERE EXISTS (SELECT 1 FROM #Teacher T INNER JOIN #TeacherRoster ON T.[SIS ID] = #TeacherRoster.[SIS ID] AND #TeacherRoster.[Section SIS ID] = #StudentEnrollment.[Section SIS ID] AND T.Status <> 'Inactive')
*/
GO

