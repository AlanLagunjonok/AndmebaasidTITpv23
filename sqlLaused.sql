--Разрешения предопределенных ролей базы данных:
--https://technet.microsoft.com/ru-ru/library/ms189612(v=sql.105).aspx.

-- SQL kommentaar
-- SQL Server Managment Studio
-- (localdb)\mssqllocaldb
-- Authenfication: Windows Auth - admini õigused localhostis
-- Authenfication: SQL  Server Auth - varem loodud kasutajad
-- New Query 
CREATE DATABASE lagunjonokTIT;
--Object Explorer on vaja pidevalt uuendada käsitsi!
USE lagunjonokTIT;
--tabeli loomine
CREATE TABLE opilane(
oplilaneID int Primary Key identity(1,1),
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
