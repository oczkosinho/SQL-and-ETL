USE Spojler
GO

If (object_id('dbo.TeamsTemp') is not null) DROP TABLE dbo.TeamsTemp;
CREATE TABLE dbo.TeamsTemp(PIN varchar(12), empName varchar(60), 
								empSurname varchar(60), birthDate varchar(20), email varchar(70), telephone varchar(40),
								education varchar(20), languages int, salary int, position varchar(20), date_start date, date_end date);
go

BULK INSERT dbo.TeamsTemp
    FROM 'C:\Users\waocz\OneDrive\Pulpit\Studia\Semestr 4\DW\etl\Workery.csv'
    WITH
    (
    FIRSTROW = 2,
	DATAFILETYPE = 'char',
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

If (object_id('vETLTeams') is not null) Drop View vETLDimTeams;
go


create view vETLDimTeams
as
select
	distinct t1.H_ID as [T_ID],
	CASE
		When count(t1.ID) between 1 and 3 then '1-3'
		When count(t1.ID) between 4 and 6 then '4-6'
		When count(t1.ID) between 7 and 9 then '7-9'
		When count(t1.ID) between 10 and 50 then '10+'
	end as [number],
	CASE
		When AVG(t2.languages) between 1 and 2 then '1-2'
		When AVG(t2.languages) between 3 and 4 then '3-4'
		When AVG(t2.languages) between 5 and 7 then '5-7'
		When AVG(t2.languages) between 8 and 40 then '8+'
	end as [languages]
from Travel.dbo.Personnel as t1
	join dbo.TeamsTemp as t2 on t1.ID = t2.PIN
group by t1.H_ID
;
go


merge into Teams as TT
	using vETLDimTeams as ST
		ON TT.ID_Team = ST.T_ID
			when not matched
				then
					insert values (
					ST.number,
					ST.languages
					)
			WHEN Not Matched By Source
							Then
								DELETE
						;
alter table TeamsTemp
	add Work_Exp int
	;
go

If (object_id('expwork') is not null) Drop View expwork;
go


create view expwork
as
select
 IDE = PIN,
 work_e = DATEDIFF(year, date_start, date_end)
from TeamsTemp
go

merge into TeamsTemp as TT
	using expwork as ST
		ON TT.PIN = ST.IDE
			when matched
				then
					update 
					set TT.Work_Exp = ST.work_e
						;

If (object_id('polska') is not null) Drop View polska;
go


create view polska
as
select SUM(Work_Exp) as Work,H_ID
from TeamsTemp as t1 join Travel.dbo.Personnel as t2 on t1.PIN=t2.ID
join Travel.dbo.Hotels as t3 on t2.H_ID = t3.ID
group by H_ID
go


alter table Teams
	add WorkForHotel int
	;
go

merge into Teams as TT
	using polska as ST
		ON TT.ID_Team = ST.H_ID
			when matched
				then
					update
					set TT.WorkForHotel = ST.Work
						;
go




























