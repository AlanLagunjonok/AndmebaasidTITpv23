-- SQL kommentaar
-- XAMP Control Panel
-- conect to
-- localhost
-- Authenfication
-- kasutajanimi - root
-- parool ei ole
-- 
CREATE DATABASE lagunjonokTIT;
--Object Explorer on vaja pidevalt uuendada käsitsi!
USE lagunjonokTIT;
--tabeli loomine
CREATE TABLE opilane(
opilaneID int Primary Key identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) Unique,
synniaeg date,
aadress TEXT,
opilaskodu bit
);
SELECT * FROM opilane;
--tebeli kustutamine
DROP table opilane;
--andmete lisamine tabelisse
INSERT INTO opilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu)
VALUES ('Alan', 'Pavlovich', '2000-12-5', 'Tallinn', 1),
('Kolya', 'Kuus', '2005-4-1', 'Tallinn', 1),
('Roma', 'Lenon', '2002-2-7', 'Tallinn', 1);

--table Rühm
CREATE TABLE ryhm(
ryhmID int not null primary key identity(1,1),
ryhm varchar(101) unique,
osakond varchar(20),
opetajaID int
);
INSERT INTO ryhm(ryhm, osakond)
Values('TITpv23', 'IT'),('KRRpv23', 'Rätsep');

Select * from ryhm;
--lisame uus veerg  RyhmID tabelisse opilane
ALTER TABLE opilane ADD ryhmID int;

Select * from opilane;

--lisame foreign key veergule ryhmID mis on seotud tabeliga ryhm ja veerguga ryhmID
ALTER TABLE opilane 
Add foreign key (ryhmID) references ryhm(ryhmID);

--foreign key kontroll
INSERT  INTO opilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu, ryhmID)
VALUES ('Andrei', 'Clat', '2002-1-5', 'Tallinn', 1, 3);

SELECT * FROM opilane;
--kasutame seos tabelite vahel -JOIN
SELECT * FROM opilane JOIN ryhm
ON opilane.ryhmID=ryhm.ryhmID;

SELECT opilane.perenimi, ryhm.ryhm FROM opilane JOIN ryhm
ON opilane.ryhmID=ryhm.ryhmID;

--lihtsaim vaade
SELECT o.perenimi, r.ryhm, o.aadress
FROM opilane o JOIN ryhm r
ON o.ryhmID=r.ryhmID;

INSERT  INTO opilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu, ryhmID)
VALUES ('Andrei', 'Clat', '2002-1-5', 'Tallinn', 1, 3);

--tabel hinne
CREATE TABLE hinne(
hinneID int Primary Key identity(1,1),
opilaneID int,
hinne int,
õppeaine varchar(40)
);
ALTER TABLE hinne
ADD foreign key (opilaneID) references opilane(opilaneID);

INSERT INTO hinne(opilaneID, hinne, õppeaine)
Values(1, '4', 'Matemaatika'),(9, '5', 'Vene keel');
Select * from hinne;

-- join opilane!

SELECT o.perenimi, h.hinne
FROM opilane o JOIN hinne h
ON o.opilaneID=h.opilaneID


CREATE TABLE opetaja(
opetajaID int Primary Key identity(1,1),
nimi varchar(25),
perenimi varchar(30) Unique,
telefon varchar(15) 
);

ALTER TABLE opetaja
ADD foreign key (opetajaID) references ryhm(opetajaID);

INSERT INTO opetaja(nimi, perenimi, telefon)
Values('Katja', 'Pilkins', '55555555');
Select * from opetaja;

--PROCEDURE
BEGIN
SELECT filmNimetus, pikkus
FROM film
WHERE filmNimetus LIKE CONCAT(taht, '%');
END

--This is wrong:
SELECT r.perenimi, h.hinne
FROM opilane o JOIN hinne h
ON r.opetajaID=o.opetajaID
