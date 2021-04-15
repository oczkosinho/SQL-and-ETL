USE Spojler
GO

alter table Hotels
	add ChangeStartDate DateTime Null,
		ChangeEndDate DateTime Null
	;
go

If (object_id('dbo.HotelsTemp') is not null) DROP TABLE dbo.HotelsTemp;
CREATE TABLE dbo.HotelsTemp(hotelID varchar(12), hotelName varchar(60), 
								destinationID varchar(12), Star_rating int, hotel_address varchar(70), date_start date, date_end date);
go

BULK INSERT dbo.HotelsTemp
    FROM 'C:\Users\waocz\OneDrive\Pulpit\Studia\Semestr 4\DW\etl\Hotels.csv'
    WITH
    (
    FIRSTROW = 2,
	DATAFILETYPE = 'char',
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

	drop table Hotels

If (object_id('vETLDimHotels') is not null) Drop View vETLDimHotels;
go

create view vETLDimHotels
as
select
	[hotelID] as [HID],
	[hotelName] as [Hotel_Name],
	[Star_rating] as [Star_Rating],
	[date_start] as [Sign_Date],
	[date_end] as [End_Date]
from dbo.HotelsTemp
go

merge into Hotels as TT
	using vETLDimHotels as ST
		ON TT."Name" = ST.Hotel_Name
			when not matched
				then
					insert
					values (
					ST.Hotel_Name,
					ST.Star_Rating,
					0,
					ST.Sign_Date,
					ST.End_Date,
					GetDate(),
					Null
					)
			When matched
				and (ST.HID <> TT.ID_Hotel
				or ST.Hotel_Name <> TT."Name"
				or ST.Star_Rating <> TT.Star_Rating
				or ST.Sign_Date <> TT.Date_signing_contract
				or ST.End_Date <> Date_ending_contract)
			then 
				UPDATE
				SET TT.Is_Star_Change = 1,
				TT.ChangeEndDate = GetDate()
			WHEN Not Matched By Source
			Then
				UPDATE
				SET TT.Is_Star_Change = 1,
				TT.ChangeEndDate = GetDate()
			;

alter table Hotels
	add  F_Price int
	;
go

