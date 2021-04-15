use Spojler 
go

If (object_id('vETLDimAirlines') is not null) Drop View vETLDimAirlines;
go

create view vETLDimAirlines
as 
select distinct
	[ID] as [ID_Airline],
	[Name] as [Airline_Name]
from Travel.dbo.Airlines
go

merge into Airlines as TT
	using vETLDimAirlines as ST
		ON TT."Name" = ST.Airline_Name
			When Not Matched
				then
					insert 
					values (
					ST.Airline_Name
					)
			When Not Matched By Source
				Then
					Delete
			;
	