/*******************************************************************************
   Utilitzant la base de dades sakila, realitzeu els següents exercicis sobre modificació de bases de dades:
********************************************************************************/

/*Afegeix una columna phone_number de tipus VARCHAR(15) a la taula customer per poder emmagatzemar el número de telèfon dels clients. Aquesta columna ha de permetre valors nuls.*/
ALTER TABLE customer ADD COLUMN phone_number VARCHAR(15);

/*La columna amount de la taula payment és de tipus DECIMAL(5,2). Suposa que cal augmentar la precisió per permetre valors més grans. Modifica la columna perquè sigui DECIMAL(7,2).*/
ALTER TABLE payment MODIFY COLUMN amount DECIMAL(7,2);

/*La taula rental té una columna staff_id que referencia la columna staff_id de la taula staff. Afegeix una clau forana per garantir la integritat referencial.*/
ALTER TABLE actor DROP COLUMN middle_name;

/*La taula actor té una columna anomenada middle_name que ja no és necessària. Elimina aquesta columna.*/
ALTER TABLE rental ADD CONSTRAINT fk_staff FOREIGN KEY (staff_id) REFERENCES staff(staff_id);

/*Renombra la taula inventory a stock per adequar millor el nom a la seva funcionalitat.*/
ALTER TABLE inventory RENAME TO stock;
