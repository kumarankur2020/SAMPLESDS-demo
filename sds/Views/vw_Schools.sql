CREATE VIEW [sds].[vw_Schools]
AS SELECT SP.SISID, SP.Name, SP.StateID, SP.SchoolNumber, SP.GradeLow, SP.GradeHigh, SP.PrincipalSISID, SP.PrincipalName, SP.PrincipalSecondaryEmail
	  , A.Street1 AS Address, UPPER(A.Suburb) AS City, A.State, A.Postcode AS Zip, A.Country AS Country, CM.ContactValue AS Phone, SP.Zone, ST.Name AS SchoolType
  FROM [eminExt].[SchoolPrincipals] SP
  LEFT OUTER JOIN [emin].[CampusEntity] CE	 ON SP.SISID = CE.CampusCode
  LEFT OUTER JOIN [emin].[nhEntityAddress] EA ON CE.CampusCode = EA.EntityID AND EA.AddressType = 'Business'
  LEFT OUTER JOIN [emin].[nhAddress] A        ON EA.AddressID = A.AddressID
  LEFT OUTER JOIN [emin].[nhContactMethod] CM ON CE.EntityID = CM.EntityID AND CM.ContactMethodType = 'CM005'
  LEFT OUTER JOIN [emin].[Campus] C           ON SP.SISID = C.Code
  LEFT OUTER JOIN [emin].[SysTable] ST        ON C.Type = ST.Code;
GO

