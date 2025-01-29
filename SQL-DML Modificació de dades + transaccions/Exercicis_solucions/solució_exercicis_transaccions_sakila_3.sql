/*******************************************************************************
   Utilitzant la base de dades sakila, realitzeu els següents exercicis amb TRANSACTIONS:
********************************************************************************/


/*Exercicis creats per Joan Queralt: https://gitlab.com/joanq/DAM-M2-BasesDeDades/-/blob/master/UF2/1-DML/activitats/activitat_modificacio_sakila.adoc?ref_type=heads*/

/*Per a cada qüestió, indica totes les sentències que has necessitat per a realitzar la modificació necessària. Si es necessiten consultes intermèdies per resoldre una qüestió, cal guardar els valors necessaris en variables, o utilitzar subconsultes.*/


/*1. Afegeix una nova actriu a la BD amb el nom Charlize Theron.*/

START TRANSACTION;

INSERT INTO actor (first_name, last_name, last_update)
VALUES ('Charlize', 'Theron', NOW());

COMMIT;

/*2. Afegeix la pel·licula Monster a la BD, de l’any 2003 i amb les mateixes característiques que la pel·lícula BOOGIE AMELIE.*/
START TRANSACTION;

INSERT INTO film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update)
SELECT 'Monster', description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, NOW()
FROM film
WHERE title = 'BOOGIE AMELIE'
LIMIT 1;


COMMIT;

/*3. Afegeix l’actriu del primer exercici a la pel·lícula del segon exercici.*/
START TRANSACTION;

SET @actor_id = (SELECT actor_id FROM actor WHERE first_name = 'Charlize' AND last_name = 'Theron' LIMIT 1);

SET @film_id = (SELECT film_id FROM film WHERE title = 'Monster' LIMIT 1);

INSERT INTO film_actor (actor_id, film_id, last_update)
VALUES (@actor_id, @film_id, NOW());

COMMIT;

/*4. Afegeix la pel·lícula Monster a la categoria de Drama.*/
START TRANSACTION;

SET @film_id = (SELECT film_id FROM film WHERE title = 'Monster' LIMIT 1);

SET @category_id = (SELECT category_id FROM category WHERE name = 'Drama' LIMIT 1);

INSERT INTO film_category (film_id, category_id, last_update)
VALUES (@film_id, @category_id, NOW());

COMMIT;

/*5. Afegeix una nova pel·lícula, la que vulguis, amb les mateixes dades que la pel·lícula que tingui menys durada.*/
START TRANSACTION;

SET @shortest_film_id = (SELECT film_id FROM film ORDER BY length ASC LIMIT 1);

INSERT INTO film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update)
SELECT 'Victor Movie', description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, NOW()
FROM film
WHERE film_id = @shortest_film_id;

COMMIT;

/*6. Insereix una nova categoria amb el nom Noir.*/
START TRANSACTION;

INSERT INTO category (name, last_update)
VALUES ('Noir', NOW());

COMMIT;

/*7. Afegeix un nou client de la ciutat on hi hagi més clients. La resta de dades les pots inventar.*/
START TRANSACTION;

SET @city_id = (SELECT city_id FROM address WHERE address_id IN (SELECT address_id FROM customer) GROUP BY city_id ORDER BY COUNT(*) DESC LIMIT 1);

SET @address_id = (SELECT address_id FROM address WHERE city_id = @city_id LIMIT 1);

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', @address_id, 1, NOW(), NOW());

COMMIT;

/*8. Fes les operacions que calgui per tal d’afegir un nou lloguer a aquest client.*/
START TRANSACTION;

SET @customer_id = (SELECT customer_id FROM customer ORDER BY create_date DESC LIMIT 1);

SET @inventory_id = (SELECT inventory_id FROM inventory WHERE inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL) LIMIT 1);

SET @staff_id = (SELECT staff_id FROM staff LIMIT 1);

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (NOW(), @inventory_id, @customer_id, NULL, @staff_id, NOW());

COMMIT;

/*9. Augmenta en dos minuts la durada de les pel·lícules de la categoria d’acció.*/
START TRANSACTION;

SET @category_id = (SELECT category_id FROM category WHERE name = 'Action' LIMIT 1);

UPDATE film SET length = length + 2 WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = @category_id);

COMMIT;

/*10. Canvia l’adreça de la clienta Elizabeth Brown. La seva nova adreça és 150 Blue Avenue enlloc de 53 Idfu Parkway.*/
START TRANSACTION;

SET @customer_id = (SELECT customer_id  FROM customer  WHERE first_name = 'Elizabeth' AND last_name = 'Brown' LIMIT 1);

SET @old_address_id = (SELECT address_id  FROM customer  WHERE customer_id = @customer_id);

UPDATE address SET address = '150 Blue Avenue', last_update = NOW() WHERE address_id = @old_address_id;

COMMIT;

/*11. Disminueix un 10% la quantitat dels pagaments fets al juliol del 2005.*/
START TRANSACTION;

UPDATE payment SET amount = amount * 0.90 WHERE MONTH(payment_date) = 7 AND YEAR(payment_date) = 2005;

COMMIT;

/*12. Esborra el client o els clients que hagin fet només un lloguer.*/
START TRANSACTION;

SET @customer_todelete = SELECT GROUP_CONCAT(customer_id) FROM (SELECT customer_id FROM rental GROUP BY customer_id HAVING COUNT(rental_id) = 1) AS temp_customers;

DELETE FROM rental WHERE FIND_IN_SET(customer_id, @customer_todelete);

DELETE FROM customer WHERE FIND_IN_SET(customer_id, @customer_todelete);

COMMIT;

/*13. Esborra la pel·lícula que dura menys de la BD.*/
START TRANSACTION;

SET @film_id = (SELECT film_id FROM film ORDER BY length ASC LIMIT 1);

DELETE FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = @film_id);

DELETE FROM inventory WHERE film_id = @film_id;

DELETE FROM film_actor WHERE film_id = @film_id;

DELETE FROM film_category WHERE film_id = @film_id;

DELETE FROM film WHERE film_id = @film_id;

COMMIT;

/*14. Esborra la categoria Travel.*/
START TRANSACTION;

SET @category_id = (SELECT category_id FROM category WHERE name = 'Travel' LIMIT 1);

DELETE FROM film_category WHERE category_id = @category_id;

DELETE FROM category WHERE category_id = @category_id;

COMMIT;
