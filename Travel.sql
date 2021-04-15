
USE Travel;
CREATE TABLE Airlines (
 ID int identity(1,1) PRIMARY KEY,
 "Name" varchar(60),
);

CREATE TABLE Insurance (
 Company_Name varchar(60),
 Insurance_Nr int identity(1,1) PRIMARY KEY,
);

CREATE TABLE Destinations (
 ID int identity(1,1) PRIMARY KEY,
 Country varchar(60),
 City varchar(60),
 Capacity int,
);

CREATE TABLE Hotels (
 ID int identity(1,1) PRIMARY KEY,
 "Name" varchar(60),
 D_ID int REFERENCES Destinations,
);

CREATE TABLE Personnel (
 ID int identity(1,1) PRIMARY KEY,
 "Role" varchar(30),
 "Name" varchar(60),
 Surname varchar(60),
 H_ID int REFERENCES Hotels,
);

CREATE TABLE Offers (
 ID int identity(1,1) PRIMARY KEY,
 Arrival_Day date,
 Return_Day date,
 Price int,
 Capacity int,
 H_ID int REFERENCES Hotels,
 A_ID int REFERENCES Airlines,
 I_ID int REFERENCES Insurance,
);

CREATE TABLE Facultative_Trips (
 ID int identity(1,1) PRIMARY KEY,
 "Name" varchar(60),
 Capacity int,
 Price int,
);

CREATE TABLE Have (
 H_ID int REFERENCES Hotels,
 T_ID int REFERENCES Facultative_Trips,
);
select * from have
order by H_ID
