CREATE PROC [dbo].[Generate_SDS_Relationships_csv] AS
BEGIN

--SDS\relationships.csv
--userSourcedId	relationshipUserSourcedId	relationshipRole
--select distinct [SIS ID] as userSourcedId, [ParentSIS ID] as relationshipUserSourcedId, Role as relationshipRole from #GuardianRelationship inner join #Orgs on #GuardianRelationship.Campus = #Orgs.sourcedId AND #Orgs.ExportType in ('SDS','B')
--select distinct [SIS ID] as userSourcedId, [ParentSIS ID] as relationshipUserSourcedId, Role as relationshipRole from #GuardianRelationship where @ParentConnectionParents like '%,'+Email+',%'
select distinct '"' + [SIS ID] + '"' as userSourcedId, 
				'"' + [ParentSIS ID] + '"' as relationshipUserSourcedId, 
				'"' + Role + '"' as relationshipRole 
from sdsGuardianRelationship 
--where @ParentConnectionSchools like '%,'+Campus+',%'
where (select ParameterValue from sds_sp_parameters where ParameterName = 'ParentConnectionSchools') like '%,'+Campus+',%'  and email not like '%bne.catholic.edu.au'
--union
--select distinct #GuardianRelationship.[SIS ID] as userSourcedId, [ParentSIS ID] as relationshipUserSourcedId, Role as relationshipRole from #GuardianRelationship inner join #StudentEnrollment on #StudentEnrollment.[SIS ID] = #GuardianRelationship.[SIS ID] where @ParentConnectionClasses like '%,'+cast(#StudentEnrollment.[Section SIS ID] as varchar)+',%' --order by [ParentSIS ID]
ORDER BY 1,2

END
GO

