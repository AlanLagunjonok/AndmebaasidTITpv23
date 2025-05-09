create database TITtriger;
use TITtriger;

--tabel, mida automaatselt täidab triger
CREATE TABLE logi(
id int primary key identity(1,1),
tegevus varchar(25),
kasutaja varchar(25),
aeg datetime,
andmed TEXT)

--tabel, millega töötab kasutaja
CREATE TABLE puud(
puuId int primary key identity(1,1),
puuNimi varchar(25),
pikkus int,
aasta int)

insert into puud(puuNimi, pikkus, aasta)
VALUES('kask', '5', '10');

--triger, mis jälgib tabeli puud täitmine
CREATE TRIGGER puuLisamine
ON puud
FOR INSERT
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on lisatud',
GETDATE(),
CONCAT(inserted.puuNimi, ', ' ,inserted.pikkus, ', ' ,inserted.aasta)
FROM inserted;

--kontroll
INSERT INTO puud(puuNimi, pikkus, aasta)
VALUES ('vaher', 22, 2000);
SELECT * FROM puud;
SELECT * FROM logi;

drop trigger puuLisamine;

--triger, mis jälgib tabelis kustutamine

CREATE TRIGGER puuKustutamine
ON puud
FOR DELETE
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on kustutatud',
GETDATE(),
CONCAT(deleted.puuNimi, ', ' ,deleted.pikkus, ', ' ,deleted.aasta)
FROM deleted;
--kontroll
DELETE FROM puud WHERE puuId=1;
SELECT * FROM puud;
SELECT * FROM logi;


--triger, mis jälgib tabelis uuendamine
CREATE TRIGGER puuUuendamine
ON puud
FOR UPDATE
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on uuendatud',
GETDATE(),
CONCAT(
'vana puu info - ', deleted.puuNimi, ', ' ,deleted.pikkus, ', ' ,deleted.aasta,
'uus puu info - ', inserted.puuNimi, ', ' ,inserted.pikkus, ', ' ,inserted.aasta
)
FROM deleted INNER JOIN inserted
ON deleted.puuId=inserted.puuId;
--kontroll
UPDATE puud SET pikkus=25555, aasta=1900
WHERE puuId=2;
SELECT * FROM puud;
SELECT * FROM logi;
