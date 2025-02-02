/*******************************************************************************
   Utilitzant la base de dades Chinook, realitzeu els següents exercicis amb TRANSACTIONS:
********************************************************************************/


/*Exercicis creats per Joan Queralt: https://gitlab.com/joanq/DAM-M2-BasesDeDades/-/blob/master/UF2/1-DML/activitats/activitat_modificacio_sakila.adoc?ref_type=heads*/
/*Per a cada qüestió, indica totes les sentències que has necessitat per a realitzar la modificació necessària. Si es necessiten consultes intermèdies per resoldre una qüestió, cal guardar els valors necessaris en variables, o utilitzar subconsultes.*/


/*1. Afegeix-te com a client a la botiga. No cal que posis dades reals, a part del teu nom i cognom, però has d’omplir correctament tots els camps.*/

START TRANSACTION;

SET @SupportRepId = (SELECT EmployeeId FROM employee LIMIT 1);

SET @customer_id = (SELECT MAX(CustomerId) + 1 FROM customer);

INSERT INTO customer (CustomerId, FirstName, LastName, Company, Address, City, State, Country, PostalCode, Phone, Fax, Email, SupportRepId) 
VALUES (@customer_id, 'Víctor', 'García', 'INS Sabadell', 'Carrer Juvenal, 1', 'Sabadell', 'Catalunya', 'Espanya', '08201', '123-456-7890', NULL, 'vgarc103@ies-sabadell.cat', @SupportRepId);

COMMIT;

/*2. Volem introduir un nou artista i algun dels seus àlbums a la base de dades. L’artista es diu M.I.A. i l’àlbum que volem introduir és Kala. Pots consultar la llista de àlbums a https://en.wikipedia.org/wiki/Kala_%28album%29.*/

START TRANSACTION;

SET @artist_id = (SELECT MAX(ArtistId) + 1 FROM artist);
INSERT INTO artist (ArtistId, Name) VALUES (@artist_id, 'M.I.A.');

SET @album_id = (SELECT MAX(AlbumId) + 1 FROM album);
INSERT INTO album (AlbumId, Title, ArtistId) VALUES (@album_id, 'Kala', @artist_id);

COMMIT;

/*3. Crea una nova llista de reproducció i afegeix-hi almenys 5 cançons (que ja estiguin a la base de dades).*/
START TRANSACTION;

SET @playlist_id = (SELECT MAX(PlaylistId) + 1 FROM playlist);
INSERT INTO playlist (PlaylistId, Name) VALUES (@playlist_id, 'INS Sabadell Playlist');

SET @track1 = (SELECT TrackId FROM track ORDER BY RAND() LIMIT 1);
SET @track2 = (SELECT TrackId FROM track WHERE TrackId <> @track1 ORDER BY RAND() LIMIT 1);
SET @track3 = (SELECT TrackId FROM track WHERE TrackId NOT IN (@track1, @track2) ORDER BY RAND() LIMIT 1);
SET @track4 = (SELECT TrackId FROM track WHERE TrackId NOT IN (@track1, @track2, @track3) ORDER BY RAND() LIMIT 1);
SET @track5 = (SELECT TrackId FROM track WHERE TrackId NOT IN (@track1, @track2, @track3, @track4) ORDER BY RAND() LIMIT 1);

INSERT INTO playlisttrack (PlaylistId, TrackId) VALUES (@playlist_id, @track1),(@playlist_id, @track2),(@playlist_id, @track3),(@playlist_id, @track4),(@playlist_id, @track5);

COMMIT;

/*4. El client Niklas Schröder ha fet una nova compra a la nostra botiga. Ha adquirit dos exemplars de la cançó Losing My Religion i un exemplar de la cançó Heartland. Introdueix les dades corresponents a les taules Invoice i InvoiceLine, suposant que ha facturat a la seva adreça habitual.*/
START TRANSACTION;

SET @customer_id = (SELECT CustomerId FROM customer WHERE FirstName = 'Niklas' AND LastName = 'Schröder' LIMIT 1);

SELECT BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode INTO @BillingAddress, @BillingCity, @BillingState, @BillingCountry, @BillingPostalCode FROM invoice WHERE CustomerId = @customer_id LIMIT 1;

SET @invoice_id = (SELECT MAX(InvoiceId) + 1 FROM invoice); INSERT INTO invoice (InvoiceId, CustomerId, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES (@invoice_id, @customer_id, NOW(), @BillingAddress, @BillingCity, @BillingState, @BillingCountry, @BillingPostalCode, 0);

SET @track1 = (SELECT TrackId FROM track WHERE Name = 'Losing My Religion' LIMIT 1);
SET @track2 = (SELECT TrackId FROM track WHERE Name = 'Heartland' LIMIT 1);

SET @unit_price1 = (SELECT UnitPrice FROM track WHERE TrackId = @track1);
SET @unit_price2 = (SELECT UnitPrice FROM track WHERE TrackId = @track2);

SET @invoice_line_id = (SELECT MAX(InvoiceLineId) + 1 FROM invoiceline); INSERT INTO invoiceline (InvoiceLineId, InvoiceId, TrackId, UnitPrice, Quantity) VALUES  (@invoice_line_id, @invoice_id, @track1, @unit_price1, 2), (@invoice_line_id + 1, @invoice_id, @track2, @unit_price2, 1);

UPDATE invoice  SET Total = (SELECT SUM(UnitPrice * Quantity) FROM invoiceline WHERE InvoiceId = @invoice_id) WHERE InvoiceId = @invoice_id;

COMMIT;

/*5. Hem contractat al client John Gordon. El càrrec que ocuparà serà el de Sales Manager i el seu cap serà la Nancy Edwards. Afegeix una nova fila a la taula d’empleats, copiant totes les dades possibles de la taula de clients.*/
START TRANSACTION;

SELECT FirstName, LastName, Address, City, State, Country, PostalCode, Phone, Fax, Email INTO @FirstName, @LastName, @Address, @City, @State, @Country, @PostalCode, @Phone, @Fax, @Email FROM customer WHERE FirstName = 'John' AND LastName = 'Gordon' LIMIT 1;

SET @manager_id = (SELECT EmployeeId FROM employee WHERE FirstName = 'Nancy' AND LastName = 'Edwards' LIMIT 1);

SET @employee_id = (SELECT MAX(EmployeeId) + 1 FROM employee);

INSERT INTO employee (EmployeeId, LastName, FirstName, Title, ReportsTo, HireDate, Address, City, State, Country, PostalCode, Phone, Fax, Email) VALUES (@employee_id, @LastName, @FirstName, 'Sales Manager', @manager_id, NOW(), @Address, @City, @State, @Country, @PostalCode, @Phone, @Fax, @Email);

COMMIT;

/*6. El client Mark Taylor s’ha canviat d’adreça. Ara viu a 68-70 Oxford St, Darlinghurst NSW 2010, Australia. Modifica la seva entrada a la base de dades d’acord amb aquest canvi.*/
START TRANSACTION;

UPDATE customer SET Address = '68-70 Oxford St', City = 'Darlinghurst', State = 'NSW', Country = 'Australia', PostalCode = '2010' WHERE FirstName = 'Mark' AND LastName = 'Taylor';

COMMIT;

/*7. Disminueix un 20% els preus de les 30 cançons més curtes de la base de dades.*/
START TRANSACTION;

SET @var_trackId = (SELECT GROUP_CONCAT(TrackId) FROM track ORDER BY Milliseconds ASC LIMIT 30);

UPDATE track SET UnitPrice = UnitPrice * 0.8 WHERE FIND_IN_SET(TrackId, @var_trackId);

COMMIT;

/*8. Augmenta un 15% els preus de les 20 cançons més venudes de la base de dades.*/

START TRANSACTION;

SET @var_trackId = (SELECT GROUP_CONCAT(TrackId) FROM (SELECT TrackId FROM invoiceline GROUP BY TrackId ORDER BY SUM(Quantity) DESC LIMIT 20) AS temp_table);

UPDATE track SET UnitPrice = UnitPrice * 1.15 WHERE FIND_IN_SET(TrackId, @var_trackId);

COMMIT;

/*9. Fins ara, els clients de la Índia tenien com a assistent a l’empleada Jane Peacock, però a partir d’ara tindran a la Margaret Park. Fes el canvi corresponent a la base de dades.*/
START TRANSACTION;

SET @old_rep = (SELECT EmployeeId FROM employee WHERE FirstName = 'Jane' AND LastName = 'Peacock' LIMIT 1);
SET @new_rep = (SELECT EmployeeId FROM employee WHERE FirstName = 'Margaret' AND LastName = 'Park' LIMIT 1);

UPDATE customer SET SupportRepId = @new_rep WHERE Country = 'India' AND SupportRepId = @old_rep;

COMMIT;

/*10. El client Eduardo Martins s’ha queixat d’un error a la seva última factura. A més de les cançons que hi consten, assegura que també va comprar un exemplar de la cançó Garota De Ipanema. Modifica la seva última factura per afegir aquesta compra.*/
START TRANSACTION;

SET @customer_id = (SELECT CustomerId FROM customer WHERE FirstName = 'Eduardo' AND LastName = 'Martins' LIMIT 1);

SET @last_invoice_id = (SELECT InvoiceId FROM invoice WHERE CustomerId = @customer_id ORDER BY InvoiceDate DESC LIMIT 1);

SET @track_id = (SELECT TrackId FROM track WHERE Name = 'Garota De Ipanema' LIMIT 1);
SET @unit_price = (SELECT UnitPrice FROM track WHERE TrackId = @track_id);

SET @invoice_line_id = (SELECT MAX(InvoiceLineId) + 1 FROM invoiceline); 
INSERT INTO invoiceline (InvoiceLineId, InvoiceId, TrackId, UnitPrice, Quantity) VALUES (@invoice_line_id, @last_invoice_id, @track_id, @unit_price, 1);

UPDATE invoice SET Total = (SELECT SUM(UnitPrice * Quantity) FROM invoiceline WHERE InvoiceId = @last_invoice_id) WHERE InvoiceId = @last_invoice_id;

COMMIT;

/*11. Un error ha fet que totes les factures emeses el dia 24 d'agost de 2021 siguin errònies: es van guardar a la base de dades, però no es van cobrar ni es van entregar les cançons. Elimina totes les factures emeses aquest dia.*/
START TRANSACTION;

DELETE FROM invoiceline WHERE InvoiceId IN (SELECT InvoiceId FROM invoice WHERE YEAR(InvoiceDate) = 2021 AND MONTH(InvoiceDate) = 8 AND DAY(InvoiceDate) = 24);

DELETE FROM invoice  WHERE YEAR(InvoiceDate) = 2021 AND MONTH(InvoiceDate) = 8 AND DAY(InvoiceDate) = 24;

COMMIT;

/*12. Sembla que hi ha dues llistes de reproducció repetides a la base de dades. Són les que tenen com a nom Music. Elimina una de les dues llistes de reproducció completament.*/
START TRANSACTION;

SET @playlist_id = (SELECT PlaylistId FROM playlist WHERE Name = 'Music' LIMIT 1);

DELETE FROM playlisttrack WHERE PlaylistId = @playlist_id;

DELETE FROM playlist WHERE PlaylistId = @playlist_id;

COMMIT;

/*13. Esborra totes les cançons de la base de dades que no s’hagin venut cap vegada fins ara.*/
START TRANSACTION;

DELETE FROM playlisttrack WHERE TrackId IN (SELECT TrackId FROM track WHERE TrackId NOT IN (SELECT DISTINCT TrackId FROM invoiceline));

DELETE FROM track WHERE TrackId NOT IN (SELECT DISTINCT TrackId FROM invoiceline);

COMMIT;