USE Spojler
GO

If (object_id('vETLDimInsurance') is not null) Drop View vETLDimInsurance;
go

create view vETLDimInsurance
as
Select distinct
	[Company_Name] as [Name_Company],
	[Insurance_Nr] as [Insurance_ID]
from Travel.dbo.Insurance;
go

merge into Insurance as TT
	using vETLDimInsurance as ST
		ON TT.ID_Insurance = ST.Insurance_ID
			when not matched
				then
					insert
					values (
					ST.Name_Company,
					ST.Insurance_ID
					)
			WHEN Not Matched By Source
							Then
								DELETE
						;

