USE Spojler
GO

If (object_id('vETLDimDestinations') is not null) Drop View vETLDimDestinations;
go

create view vETLDimDestinations
as
Select distinct
	[ID] as [Destination_ID],
	[Country] as [Country],
	[City] as [City]
from Travel.dbo.Destinations;
go

merge into Destinations as TT
	using vETLDimDestinations as ST
		ON TT.ID_Destination = ST.Destination_ID
			when not matched
				then
					insert
					values (
					ST.Country,
					ST.City
					)
			WHEN Not Matched By Source
							Then
								DELETE
						;

