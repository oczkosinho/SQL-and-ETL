USE Spojler
GO

If (object_id('vETLDimOffers') is not null) Drop View vETLDimOffers;
go

create view tripsy
as
select
	t1.[H_ID] as [H_ID],
	count(*) as [Amount],
	sum(t2.Price) as [F_Price]
from Travel.dbo.Have as t1
join Travel.dbo.Facultative_Trips as t2 on t1.T_ID=t2.ID
group by H_ID
;


create view vETLDimOffers
as
Select 
	 ID_Arrival_Day = t2.ID_Date,
	 ID_Return_Day = t3.ID_Date,
	 Offer_Price = t1.Price,
	 Capacity = t1.Capacity,
	 Price_Trips = t6.F_Price,
	 Amount_Trips = t6.Amount, 
	 Work_Experience = t7.WorkForHotel, 
	 ID_Hotel = t8.ID_Hotel, 
	 ID_Airlines = t9.ID_Airline, 
 	 ID_Insurance = t10.ID_Insurance,
	 ID_Destination = t12.ID,
	 ID_Team = t11.ID,
	 case
		when t1.Price Between 0 and 2500 then 1
		when t1.Price Between 2501 and 5000 then 2
		when t1.Price Between 5001 and 7500 then 3
	    else 4
	 end as [ID_Junk]
FROM Travel.dbo.Offers as t1
join dbo."Date" as t2 on t1.Arrival_Day=t2."Date"
join dbo."Date" as t3 on t1.Return_Day=t3."Date"
join dbo.tripsy as t6 on t1.H_ID = t6.H_ID
join dbo.Teams as t7 on t1.H_ID = t7.ID_Team
join dbo.Hotels as t8 on t1.H_ID = t8.ID_Hotel
join dbo.Airlines as t9 on t1.A_ID = t9.ID_Airline
join dbo.Insurance as t10 on t1.I_ID = t10.ID_Insurance
join Travel.dbo.Hotels as t11 on t1.H_ID=t11.ID
join Travel.dbo.Destinations as t12 on t11.D_ID=t12.ID
go

merge into Offers as TT
	using vETLDimOffers as ST
		on TT.ID_Arrival_Day = ST.ID_Arrival_Day
		and TT.ID_Return_Day = ST.ID_Arrival_Day
		and TT.Offer_Price = ST.Offer_Price
		and TT.Capacity = ST.Capacity
		and TT.Price_Trips = ST.Price_Trips
		and TT.Amount_Trips = ST.Amount_Trips
		and TT.Work_Experience = ST.Work_Experience
		and TT.ID_Hotel = ST.ID_Hotel
		and TT.ID_Airlines = ST.ID_Airlines
		and TT.ID_Insurance = ST.ID_Insurance
		and TT.ID_Destination = ST.ID_Destination
		and TT.ID_Team = ST.ID_Team
	   	and TT.ID_Junk = ST.ID_Junk
			when not matched
				then
					INSERT
					VALUES (
							ST.ID_Arrival_Day,
							ST.ID_Arrival_Day,
							ST.Offer_Price,
							ST.Capacity,
							ST.Price_Trips,
							ST.Amount_Trips,
							ST.Work_Experience,
							ST.ID_Hotel,
							ST.ID_Airlines,
							ST.ID_Insurance,
							ST.ID_Destination,
							ST.ID_Team,
							ST.ID_Junk
						)
				when not matched by source
					then
						delete
				;


select * from Offers

