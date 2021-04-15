CREATE TABLE Users (
 ID int identity(1,1) PRIMARY KEY ON DELETE SET NULL ON UPDATE CASCADE,
 Username character varying(30) ON DELETE SET NULL ON UPDATE CASCADE,
 Surname character varying(30) ON DELETE SET NULL ON UPDATE CASCADE,
 "Password" character varying(12) ON DELETE SET DEFAULT ON UPDATE CASCADE,
 PESEL char(11) NULL,
 Email text ON DELETE SET NULL ON UPDATE CASCADE,
 Money_Bal float ON DELETE SET NULL ON UPDATE CASCADE,
);
CREATE TABLE Bets (
 ID int identity(1,1) PRIMARY KEY,
 Money_In float,
 Money_Out float,
 U_ID int REFERENCES Users(ID),
);
CREATE TABLE Football_Match (
 Start_Time datetime,
 Stadium_Played char,
 Home_Team char,
 Away_Team char,
 Result char,
 PRIMARY KEY (Start_Time, Stadium_Played)
);
CREATE TABLE Stadiums (
 City text,
 "Name" text,
 Country text,
 Capacity int,
 PRIMARY KEY (City, "Name"),
);
CREATE TABLE Leagues (
 Country char ON DELETE SET NULL ON UPDATE CASCADE,
 ID int identity(1,1) PRIMARY KEY ON DELETE SET NULL ON UPDATE CASCADE,
 Nr_Of_Clubs int ON DELETE SET NULL ON UPDATE CASCADE,
);

CREATE TABLE Teams (
 ID int identity(1,1) PRIMARY KEY ON DELETE SET NULL ON UPDATE CASCADE,
 "Name" char ON DELETE SET NULL ON UPDATE CASCADE,
 Nr_Of_Players int ON DELETE SET NULL ON UPDATE CASCADE,
 Budget int ON DELETE SET NULL ON UPDATE CASCADE,
 L_ID int REFERENCES Leagues(ID),
 S_City text ON DELETE SET NULL ON UPDATE CASCADE,
 S_Name text ON DELETE SET NULL ON UPDATE CASCADE,
 FOREIGN KEY (S_CITY, S_NAME) REFERENCES Stadiums (City, "Name"),
 );

CREATE TABLE Players (
 ID int Identity(1,1) PRIMARY KEY ON DELETE SET NULL ON UPDATE CASCADE,
 "Name" text ON DELETE SET NULL ON UPDATE CASCADE,
 Surname char ON DELETE SET NULL ON UPDATE CASCADE,
 Jersey_Nr int ON DELETE SET NULL ON UPDATE CASCADE,
 Position text ON DELETE SET NULL ON UPDATE CASCADE,
 Goals_Stat int ON DELETE SET NULL ON UPDATE CASCADE,
 Time_Played int ON DELETE SET NULL ON UPDATE CASCADE,
 Nationality char ON DELETE SET NULL ON UPDATE CASCADE,
 T_ID int REFERENCES Teams(ID) ON DELETE SET NULL ON UPDATE CASCADE,
);
CREATE TABLE "Events" (
 "Name" text PRIMARY KEY,
 "Description" text,
 S_Time datetime,
 S_Played char,
 FOREIGN KEY (S_Time, S_Played) REFERENCES Football_Match (Start_Time, Stadium_Played),
);
CREATE TABLE Odds (
 ID int identity(1,1) PRIMARY KEY,
 Odds float,
 Multiplier float,
 O_Name text REFERENCES "Events"("Name"),
);
CREATE TABLE Referees (
 "Name" char ON DELETE SET NULL ON UPDATE CASCADE,
 Surname char ON DELETE SET NULL ON UPDATE CASCADE,
 Licence_Nr int PRIMARY KEY ON DELETE SET NULL ON UPDATE CASCADE,
 Nationality char ON DELETE SET NULL ON UPDATE CASCADE,
 "Role" text ON DELETE SET NULL ON UPDATE CASCADE,
);
CREATE TABLE Referee(
 R_Lic int REFERENCES Referees,
 S_Time datetime,
 S_Played char,
 FOREIGN KEY (S_Time, S_Played) REFERENCES Football_Match (Start_Time, Stadium_Played),
);
CREATE TABLE Have(
 B_ID int REFERENCES Bets,
 E_Name text REFERENCES "Events",
);

*****************************************************************


INSERT INTO Users VALUES (1,'oczkosinho','Oczkos','haslo123','99031106353','witor@gmail.com',1000.23);
INSERT INTO Users VALUES (2,'janko','Tilock','haslo1234','99090214321','janek@gmail.com',10.14);
INSERT INTO Users VALUES (3,'majster','Kowalski','haslo12345','99113011937','kowal@gmail.com',34.91);
INSERT INTO Users VALUES (4,'bartolo','Nadgorski','haslo54321','99061053679','bartek@gmail.com',0.00);
INSERT INTO Users VALUES (5,'wariatka','Serek','haslo4321','99032472346','natka@gmail.com',99.11);
INSERT INTO Users VALUES (6,'mati777','Rzak','haslo321','991005023645','mati@gmail.com',536.74);
INSERT INTO Users VALUES (7,'bozenka99','Psoty','pass123','99091063546','bozenka@gmail.com',223.35);
INSERT INTO Users VALUES (8,'karol123','Lepkowski','pass1234','99061698143','karol@gmail.com',2.98);
INSERT INTO Users VALUES (9,'krisgoc','Goczyla','pass321','61022812959','kris@gmail.com',2452.10);
INSERT INTO Users VALUES (10,'wrobelek','Wróbel','pass4321','82082683549','wrobel@gmail.com',0.05);
INSERT INTO Bets VALUES (333,100.00,0,10);
INSERT INTO Bets VALUES (332,150.00,2134.11,9);
INSERT INTO Bets VALUES (337,50.00,0,8);
INSERT INTO Bets VALUES (331,3.00,432.77,7);
INSERT INTO Bets VALUES (374,10.00,510.43,6);
INSERT INTO Bets VALUES (353,6.00,50.18,5);
INSERT INTO Bets VALUES (399,7.00,0,4);
INSERT INTO Bets VALUES (367,4.00,25.66,3);
INSERT INTO Bets VALUES (311,5.00,10.01,2);
INSERT INTO Bets VALUES (336,100.00,912.12,1);
INSERT INTO Football_Match VALUES ('2019-12-18T21:00:00','Camp Nou','Fc Barcelona','Real Madrid','4:0');
INSERT INTO Football_Match VALUES ('2019-11-25T22:00:00','Emirates','Arsenal','AC Milan','1:1');
INSERT INTO Football_Match VALUES ('2019-06-28T17:45:00','Old Trafford','Manchester United','Lechia Gdansk','3:1');
INSERT INTO Football_Match VALUES ('2019-12-01T19:45:00','Santiago Bernabeu','Real Madrid','Sevilla','0:1');
INSERT INTO Football_Match VALUES ('2019-12-06T20:45:00','Parc des Princes','PSG','AS Monaco','5:2');
INSERT INTO Football_Match VALUES ('2019-08-16T21:00:00','Estadio Mestalla','Valencia','RB Leipzig','3:3');
INSERT INTO Football_Match VALUES ('2019-10-21T18:15:00','Camp Nou','FC Barcelona','Inter','2:1');
INSERT INTO Football_Match VALUES ('2019-12-10T16:30:00','King Power Stadium','Leicester City','Legia Warszawa','3:0');
INSERT INTO Football_Match VALUES ('2019-11-18T20:30:00','Stamford Bridge','Chelsea','PSV Eindhoven','1:1');
INSERT INTO Football_Match VALUES ('2019-09-30T16:45:00','Allianz Arena','FC Bayern','Ajax Amsterdam','1:2');
INSERT INTO Stadiums VALUES ('Barcelona','Camp Nou','Spain',90324);
INSERT INTO Stadiums VALUES ('Madrid','Santiago Bernabeu','Spain',81863);
INSERT INTO Stadiums VALUES ('London','Stamford Bridge','England',50125);
INSERT INTO Stadiums VALUES ('London','Emirates Stadium','England',65917);
INSERT INTO Stadiums VALUES ('Paris','Parc des Princes','France',77238);
INSERT INTO Stadiums VALUES ('Valencia','Estadio Mestalla','Spain',38883);
INSERT INTO Stadiums VALUES ('Munich','Allianz Arena','Germany',72625);
INSERT INTO Stadiums VALUES ('Manchester','Old Trafford','England',68287);
INSERT INTO Stadiums VALUES ('Leicester','King Power Stadium','England',33729);
INSERT INTO Stadiums VALUES ('Sevilla','Ramon Sanchez Pizjuan','Spain',42743);
INSERT INTO Stadiums VALUES ('Milano','San Siro','Italy',87302);
INSERT INTO Stadiums VALUES ('Gdansk','Energa Stadium','Poland',43615);
INSERT INTO Stadiums VALUES ('Warszawa','Legia City Stadium','Poland',28493);
INSERT INTO Stadiums VALUES ('Amsterdam','Amsterdam ArenA','Netherland',62245);
INSERT INTO Stadiums VALUES ('Eindhoven','Philips Stadion','Netherland',37291);
INSERT INTO Stadiums VALUES ('Leipzig',' Red Bull Arena Lipsk','Germany',52723);
INSERT INTO Stadiums VALUES ('Monaco','Louis II Stadium','Monaco',62724);
INSERT INTO Leagues VALUES ('Spain',1,20);
INSERT INTO Leagues VALUES ('England',2,20);
INSERT INTO Leagues VALUES ('Germany',3,18);
INSERT INTO Leagues VALUES ('France',4,20);
INSERT INTO Leagues VALUES ('Italy',5,20);
INSERT INTO Leagues VALUES ('Poland',6,16);
INSERT INTO Leagues VALUES ('Netherland',7,18);
INSERT INTO Teams VALUES (1,'Fc Bracelona',26,50000000,1,'Barcelona','Camp Nou');
INSERT INTO Teams VALUES (2,'Real Madrid',26,45000000,1,'Madrid','Santiago Bernabeu');
INSERT INTO Teams VALUES (3,'Manchester United',31,30000000,2,'Manchester','Old Trafford');
INSERT INTO Teams VALUES (4,'Leicester City',27,15000000,2,'Leicester','King Power Stadium');
INSERT INTO Teams VALUES (5,'Arsenal',32,18000000,2,'London','Emirates Stadium');
INSERT INTO Teams VALUES (6,'Chelsea',40,17500000,2,'London','Stamford Bridge');
INSERT INTO Teams VALUES (7,'PSG',28,60000000,4,'Paris','Parc des Princes');
INSERT INTO Teams VALUES (8,'Valencia CF',27,23000000,1,'Valencia','Estadio Mestalla');
INSERT INTO Teams VALUES (9,'FC Bayern',26,21000000,3,'Munich','Allianz Arena');
INSERT INTO Teams VALUES (10,'Sevilla CF',30,19000000,1,'Sevilla','Ramon Sanchez Pizjuan');
INSERT INTO Teams VALUES (11,'AC Milan',,25000000,5,'Milano','San Siro');
INSERT INTO Teams VALUES (12,'Inter',,32000000,5,'Milano','San Siro');
INSERT INTO Teams VALUES (13,'Lechia Gdansk',,2000000,6,'Gdansk','Energa Stadium');
INSERT INTO Teams VALUES (14,'Legia Warszawa',,5000000,6,'Warszawa','Legia City Stadium');
INSERT INTO Teams VALUES (15,'Ajax Amsterdam',,13000000,7,'Amsterdam','Amsterdam ArenA');
INSERT INTO Teams VALUES (16,'PSV Eindhoven',,8000000,7,'Eindhoven','Philips Stadion');
INSERT INTO Teams VALUES (17,'RB Leipzig',,24000000,3,'Leipzig',' Red Bull Arena Lipsk');
INSERT INTO Teams VALUES (18,'AS Monaco',,29000000,4,'Monaco','Louis II Stadium');
INSERT INTO Players VALUES (1,'Lionel','Messi',10,'Attacker',504,1253,'Argentina',1);
INSERT INTO Players VALUES (2,'Sergio','Ramos',4,'Defender',81,1026,'Spain',2);
INSERT INTO Players VALUES (3,'Marcus','Rashford',10,'Attacker',47,1382,'England',3);
INSERT INTO Players VALUES (4,'Neymar','Santos',10,'Attacker',209,1253,'Brasil',7);
INSERT INTO Players VALUES (5,'Jasper','Cillessen',13,'Goalkeeper',0,1509,'Dutch',8);
INSERT INTO Players VALUES (6,'Jamie','Vardy',10,'Attacker',172,1345,'England',4);
INSERT INTO Players VALUES (7,'Christian','Pulisic',10,'Attacker',37,945,'USA',6);
INSERT INTO Players VALUES (8,'David','Luiz',23,'Defender',25,1312,'Brasil',5);
INSERT INTO Players VALUES (9,'Ever','Banega',10,'Midfielder',33,873,'Argentina',10);
INSERT INTO Players VALUES (10,'Krzysztof','Piatek',9,'Attacker',77,812,'Poland',11);
INSERT INTO Players VALUES (11,'Robert','Lewandowski',9,'Attacker',344,1552,'Poland',9);
INSERT INTO Players VALUES (12,'Romelu','Lukaku',9,'Attacker',217,1073,'Belgium',12);
INSERT INTO Players VALUES (13,'Flavio','Paixao',28,'Attacker',103,1162,'Portugal',13);
INSERT INTO Players VALUES (14,'David','Neres',7,'Attacker',48,1371,'Brasil',15);
INSERT INTO Players VALUES (15,'Pawel','Wszolek',22,'Midfielder',24,723,'Poland',14);
INSERT INTO Players VALUES (16,'Ibrahim','Afellay',17,'Midfielder',51,1095,'Dutch',16);
INSERT INTO Players VALUES (17,'Timo','Werner',11,'Attacker',66,1227,'Germany',17);
INSERT INTO Players VALUES (18,'Kamil','Glik',25,'Defender',29,937,'Poland',18);
INSERT INTO Players VALUES (19,'Frankie','de Jong',21,'Midfielder',23,1391,'Dutch',1);
INSERT INTO Players VALUES (20,'Karim','Benzema',9,'Attacker',364,1329,'France',2);
INSERT INTO Players VALUES (21,'Kylian','Mbappe',7,'Attacker',163,1412,'France',7);
INSERT INTO Players VALUES (22,'David','De Gea',1,'Goalkeeper',0,1553,'Spain',3);
INSERT INTO Players VALUES (23,'James','Maddison',10,'Midfielder',34,1019,'England',4);
INSERT INTO Players VALUES (24,'Bernd','Leno',1,'Goalkeeper',0,1491,'Germany',5);
INSERT INTO "Events" VALUES ('BARCA vs Real Madrid','Barcelona to win vs Real Madrid','2019-12-18T21:00:00','Camp Nou');
INSERT INTO "Events" VALUES ('Legia vs Leicester - draw','Legia Warszawa to draw vs Leicester City','2019-12-10T16:30:00','King Power Stadium');
INSERT INTO "Events" VALUES ('MAN UTD vs Lechia Gdansk','Manchester United to win vs Lechia Gdansk','2019-06-28T17:45:00','Old Trafford');
INSERT INTO "Events" VALUES ('Ajax vs FC BAYERN','Ajax Amsterdam to lose vs FC Bayern','2019-09-30T16:45:00','Allianz Arena');
INSERT INTO "Events" VALUES ('Chelsea vs PSV EINDHOVEN','PSV Eindhoven to win vs Chelsea','2019-11-18T20:30:00','Stamford Bridge');
INSERT INTO "Events" VALUES ('Barca vs Inter - draw','FC Barcelona to draw vs Inter','2019-10-21T18:15:00','Camp Nou');
INSERT INTO "Events" VALUES ('LEIPZIG vs Valencia','RB Leipzig to win vs Valencia','2019-08-16T21:00:00','Estadio Mestalla');
INSERT INTO "Events" VALUES ('PSG vs Monaco','PSG to win vs Monaco','2019-12-06T20:45:00','Parc des Princes');
INSERT INTO "Events" VALUES ('SEVILLA vs Real Madrid','Sevilla to win vs Real Madrid','2019-12-01T19:45:00','Santiago Bernabeu');
INSERT INTO "Events" VALUES ('AC MILAN vs Arsenal','AC Milan to win vs Arsenal','2019-11-25T22:00:00','Emirates');
INSERT INTO Odds VALUES (1,1.5,1.22,'BARCA vs Real Madrid');
INSERT INTO Odds VALUES (2,2,1.38,'Legia vs Leicester - draw');
INSERT INTO Odds VALUES (3,3.2,1.4,'AC MILAN vs Arsenal');
INSERT INTO Odds VALUES (4,1.24,1.12,'PSG vs Monaco');
INSERT INTO Odds VALUES (5,7.9,1.67,'SEVILLA vs Real Madrid');
INSERT INTO Odds VALUES (6,2.44,1.21,'Barca vs Inter - draw');
INSERT INTO Odds VALUES (7,3.62,1.32,'LEIPZIG vs Valencia');
INSERT INTO Odds VALUES (8,10.4,1.83,'Chelsea vs PSV EINDHOVEN');
INSERT INTO Odds VALUES (9,100,2,'Ajax vs FC BAYERN');
INSERT INTO Odds VALUES (10,14.3,1.94,'MAN UTD vs Lechia Gdansk');
INSERT INTO Referees VALUES ('Viktor','Piputkin',111222333,'Russia','Main');
INSERT INTO Referees VALUES ('Mateu','Lahoz',123123123,'Spain','Main');
INSERT INTO Referees VALUES ('Szymon','Marciniak',123456789,'Poland','Linesman');
INSERT INTO Referees VALUES ('Hernandez','Hernandez',987654321,'Spain','Linesman');
INSERT INTO Referees VALUES ('Michael','Webber',123987456,'England','Linesman');
INSERT INTO Referees VALUES ('Michal','Wrobel',987123456,'Poland','Technical');
INSERT INTO Referees VALUES ('Krzysztof','Goczyla',456987123,'Poland','Technical');
INSERT INTO Referees VALUES ('Pablo','Escobar',654321987,'Colombia','Linesman');
INSERT INTO Referees VALUES ('Carl','Johnson',876432159,'USA','Main');
INSERT INTO Referees VALUES ('George','Pluton',951874326,'France','Main');
INSERT INTO Referee VALUES (111222333,'2019-12-18T21:00:00','Camp Nou');
INSERT INTO Referee VALUES (951874326,'2019-12-10T16:30:00','King Power Stadium');
INSERT INTO Referee VALUES (123123123,'2019-06-28T17:45:00','Old Trafford');
INSERT INTO Referee VALUES (876432159,'2019-09-30T16:45:00','Allianz Arena');
INSERT INTO Referee VALUES (123456789,'2019-11-18T20:30:00','Stamford Bridge');
INSERT INTO Referee VALUES (654321987,'2019-10-21T18:15:00','Camp Nou');
INSERT INTO Referee VALUES (987654321,'2019-08-16T21:00:00','Estadio Mestalla');
INSERT INTO Referee VALUES (456987123,'2019-12-06T20:45:00','Parc des Princes');
INSERT INTO Referee VALUES (987123456,'2019-12-01T19:45:00','Santiago Bernabeu');
INSERT INTO Referee VALUES (111222333,'2019-11-25T22:00:00','Emirates');
INSERT INTO Have VALUES (333,'BARCA vs Real Madrid');
INSERT INTO Have VALUES (332,'Legia vs Leicester - draw');
INSERT INTO Have VALUES (337,'AC MILAN vs Arsenal');
INSERT INTO Have VALUES (331,'PSG vs Monaco');
INSERT INTO Have VALUES (374,'SEVILLA vs Real Madrid');
INSERT INTO Have VALUES (353,'Barca vs Inter - draw');
INSERT INTO Have VALUES (399,'LEIPZIG vs Valencia');
INSERT INTO Have VALUES (367,'Chelsea vs PSV EINDHOVEN');
INSERT INTO Have VALUES (311,'Ajax vs FC BAYERN');
INSERT INTO Have VALUES (336,'MAN UTD vs Lechia Gdansk');


********************************************************************


DROP TABLE Users
DROP TABLE Bets
DROP TABLE Football_Match
DROP TABLE Stadiums
DROP TABLE Leagues
DROP TABLE Teams
DROP TABLE Players
DROP TABLE "Events"
DROP TABLE Odds
DROP TABLE Referees
DROP TABLE Referee
DROP TABLE Have

**********************************************************************

UPDATE Players
SET Goals_Stat = 507
WHERE ID = 1;
	
SELECT *
FROM Players
ORDERED BY ID;
	
UPDATE Teams
	SET Budget = 60000000, Nr_Of_Players = 29
	WHERE ID = 1;
	
SELECT *
FROM Teams
ORDERED BY ID;
	
UPDATE Users
	SET Username = 'Noname'
	WHERE ID = 3;

SELECT *
FROM Users
ORDERED BY ID;

UPDATE Leagues
	SET Nr_Of_Clubs = 20
	WHERE ID = 6;

SELECT *
FROM Leagues
ORDERED BY ID;

UPDATE Referees
	SET Role = 'Main'
	WHERE License_Nr = 123456789;

SELECT *
FROM Referees;


***********

DELETE FROM Players
WHERE ID=2

SELECT *
FROM Players
ORDERED BY ID

DELETE FROM Users
WHERE ID=9

SELECT *
FROM Users
ORDERED BY ID

DELETE FROM Teams
WHERE S_Name='San Siro'

SELECT *
FROM Teams
ORDERED BY ID

DELETE FROM Leagues
WHERE ID=6

SELECT *
FROM Leagues
ORDERED BY ID

DELETE FROM Referees
WHERE License_Nr=1

SELECT *
FROM Referees





