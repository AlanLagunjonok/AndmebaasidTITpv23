CREATE DATABASE lagunjonokTIT;

use lagunjonokTIT;

CREATE TABLE firma(
firmaID int NOT NULL Primary Key identity(1,1),
firmanimi varchar(20) Unique,
aadress varchar(20),
telefon varchar(20)
);

INSERT INTO firma(firmanimi,aadress, telefon)
VALUES ('Garden','P O BOX 393','051900395'),
('Clothing','1 TALLMAN RD','021310591'),
('Health','MAC N9301-041','121141534'),
('Kids','909 S CLAY ST','111912605'),
('Books','P. O. BOX 10566','062200628'),
('Shoes','24 SECOND AVE SE','061201673'),
('Industrial','LOCATER 01/5138','072400353'),
('Toys','1630 4TH','262286950');
SELECT * FROM firma;

SELECT * FROM firma
WHERE firmanimi LIKE ’%a%’

CREATE TABLE praktikajuhendaja(
praktikajuhendajaID int NOT NULL Primary Key identity(1,1),
eesnimi varchar(20),
perekonnanimi varchar(30),
synniaeg varchar(20),
telefon varchar(20)
);

insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Sampson', 'Vevers', '9/9/1995', '122203950');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Horton', 'Blunsen', '8/16/1995', '063113057');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Jenilee', 'Cavie', '9/9/1998', '324377011');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Rockwell', 'Itzkovici', '11/20/1998', '086500634');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Chanda', 'Grunwald', '2/7/2000', '065001426');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Raeann', 'Prynne', '6/11/1996', '067016341');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Marylin', 'Ninnoli', '9/19/1986', '021300381');
SELECT * FROM Praktikajuhendaja;


CREATE TABLE praktikabaas(
praktikabaasID int NOT NULL Primary Key identity(1,1),
firmaID int,
praktikatingimused varchar(20),
arvutiprogramm varchar(20),
juhendajaID int,
);
SELECT * FROM firma

insert into praktikabaas (praktikatingimused, arvutiprogramm,juhendajaID,firmaID) values ('Daily', 'Industrial', '1', '1');
insert into praktikabaas (praktikatingimused, arvutiprogramm,juhendajaID,firmaID) values ('Yearly', 'Toys', '2', '2');
insert into praktikabaas (praktikatingimused, arvutiprogramm,juhendajaID,firmaID) values ('Daily', 'Electronics', '3', '3');
insert into praktikabaas (praktikatingimused, arvutiprogramm,juhendajaID,firmaID) values ('Never', 'Garden', '4', '4');
insert into praktikabaas (praktikatingimused, arvutiprogramm,juhendajaID,firmaID) values ('Yearly', 'Baby', '5', '5');
insert into praktikabaas (praktikatingimused, arvutiprogramm,juhendajaID,firmaID) values ('Yearly', 'Tools', '6', '6');
insert into praktikabaas (praktikatingimused, arvutiprogramm,juhendajaID,firmaID) values ('Seldom', 'Automotive', '7', '7');
SELECT * FROM praktikabaas;

DROP TABLE praktikabaas;

SELECT *
FROM praktikabaas p
JOIN firma f ON f.firmaID = p.firmaID
ORDER by f.firmanimi;

SELECT f.firmanimi, COUNT(p.praktikabassID) AS firmadeKogus
FROM firma f
JOIN praktikabaas p ON f.firmaID = p.firmaID
GROUP BY f.firmanimi;

CREATE TABLE praktikabaas_logi(
ID int NOT NULL Primary Key identity(1,1),
kasutaja varchar(50),
aeg varchar(30),
tegevus varchar(50),
andmed text);



CREATE TRIGGER praktikabaasLisamine
ON praktikabaas
FOR INSERT
AS
INSERT INTO praktikabaas_logi(kasutaja, aeg, tegevus, andmed)
SELECT
SYSTEM_USER,
'praktikabaas on lisatud',
GETDATE(),
CONCAT(inserted.praktikatingimused, ', ' ,inserted.arvutiprogramm)
FROM inserted;

--kontroll
INSERT INTO praktikabaas(praktikatingimused, arvutiprogramm, juhendajaID, firmaID)
VALUES ('window', 'cloud', 8, 8);
SELECT * FROM praktikabaas;
SELECT * FROM praktikabaas_logi;







CREATE TRIGGER praktikabaasUuendamine
ON praktikabaas
FOR UPDATE
AS
INSERT INTO praktikabaas_logi(kasutaja, aeg, tegevus, andmed)
SELECT
SYSTEM_USER,
'praktikabaas on uuendatud',
GETDATE(),
CONCAT(
'vana praktikabaas info - ', deleted.praktikatingimused, ', ' ,deleted.arvutiprogramm, ', ',
'uus praktikabaas info - ', inserted.praktikatingimused, ', ' ,inserted.arvutiprogramm, ', ')
FROM deleted INNER JOIN inserted
ON deleted.praktikabaasID=inserted.praktikabaasID;
--kontroll
UPDATE praktikabaas SET praktikatingimused=raamat, arvutiprogramm=word
WHERE praktikabaasID=2;
SELECT * FROM praktikabaas;
SELECT * FROM praktikabaas_logi;




CREATE TRIGGER trg_Check_Juhendaja_Synniaeg
ON praktikajuhendaja
INSTEAD OF INSERT
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted WHERE synniaeg > GETDATE())
BEGIN
RAISERROR('Sünniaeg ei tohi olla tulevikus.', 16, 1);
END
ELSE
BEGIN
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
SELECT eesnimi, perekonnanimi, synniaeg, telefon
FROM inserted;
END
END;

INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
VALUES ('Jaan', 'Kask', '1990-05-10', '55567890');



SELECT * FROM Praktikajuhendaja;
WHERE puuId=2;
SELECT * FROM puud;
SELECT * FROM logi;
