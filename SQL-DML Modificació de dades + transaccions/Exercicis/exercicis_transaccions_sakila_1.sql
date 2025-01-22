
/*******************************************************************************
   Utilitzant la base de dades sakila, realitzeu els següents exercicis amb TRANSACTIONS:
********************************************************************************/

/* Afegeix un nou client a la taula 'customer' amb nom: Maria, cognom: Lopez, adreça: qualsevol adreça existent a la taula 'address',
email: maria.lopez@gmail.com, store_id: 1. */

START TRANSACTION;

INSERT INTO (store_id, first_name, last_name, email, address_id, create_date) VALUES (1, 'Maria', 'Lopez', 'maria.lopez@gmail.com', (SELECT address_id FROM address LIMIT 1), NOW());

SELECT * FROM customer ORDER BY customer_id DESC LIMIT 1;

COMMIT;

/* Es vol augmentar el preu del lloguer ('rental_rate') en un 10% per a totes les pel·lícules amb una classificació ('rating') igual a 'PG-13'.*/

START TRANSACTION;

UPDATE film SET rental_rate * 1.10 WHERE rating = 'PG-13';

COMMIT;

/* Elimina un client de la base de dades amb el seu customer_id, però només si: 
- No té lloguers actius a la taula rental. 
- El client té més de 3 anys registrat. */

START TRANSACTION;

SELECT customer_id FROM customer c WHERE NOT EXISTS (SELECT 1 FROM rental r WHERE r.customer_id = c.customer_id AND r.return_date IS NULL) AND create_date < DATE_SUB(CURRENT_DATE(), INTERVAL 3 YEAR) LIMIT 10;

SET @check_ids = (SELECT GROUP_CONCAT(customer_id) FROM customer c WHERE NOT EXISTS (SELECT 1 FROM rental r WHERE r.customer_id = c.customer_id AND r.return_date IS NULL) AND create_date < DATE_SUB(CURRENT_DATE(), INTERVAL 3 YEAR));

SELECT @checks_ids;

DELETE FROM customer WHERE FIND_IN_SET(customer_id, @check_ids); --Obtindrem un error: ON DELETE CASCADE

--Eliminem primer de la taula 'payment' i 'rental'

DELETE FROM payment WHERE customer_id IN (SELECT customer_id FROM customer WHERE FIND_IN_SET(customer_id, @check_values));

DELETE FROM rental WHERE customer_id IN (SELECT customer_id FROM customer WHERE FIND_IN_SET(customer_id, @check_values));

--Comprobar que s'ha realitzat correctament.

COMMIT;

/* Afegeix un nou registre a la taula rental per a un client existent. Dades a inserir: 
rental_date: dia i hora actual, invetory_id: pel·lícula disponible, customer_id: l'últim client afegit a la taula 'customer', staff_id: 1. */

START TRANSACTION;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
  VALUES (NOW(), (SELECT inventory_id FROM inventory 
  WHERE inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL) LIMIT 1), 
  (SELECT customer_id FROM customer ORDER BY create_date DESC LIMIT 1), 1);

--Tornarà un error, ja que s'està intentant actualitzar una taula amb innformació de la mateixa taula. Per tant, s'ha de setejar un valor a una variable.

SET @variable_temp = (SELECT inventory_id FROM inventory WHERE inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL) LIMIT 1);

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
  VALUES (NOW(), @variable_temp, 
  (SELECT customer_id FROM customer ORDER BY create_date DESC LIMIT 1), 1);

SELECT * FROM rental ORDER BY rental_date DESC LIMIT 1;

COMMIT;
