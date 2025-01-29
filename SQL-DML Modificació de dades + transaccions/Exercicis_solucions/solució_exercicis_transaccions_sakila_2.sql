/*******************************************************************************
   Utilitzant la base de dades sakila, realitzeu els següents exercicis amb TRANSACTIONS:
********************************************************************************/

/*Augmenta el preu de lloguer de les pel·lícules de més durada: Augmenta en 2.00 el preu ('rental_rate') de totes les pel·lícules que tenen una durada superior a 150 minuts.*/
START TRANSACTION;
UPDATE film
SET rental_rate = rental_rate + 2.00
WHERE length > 150;
COMMIT;

/*Marca com a inactius ('active' = 0) tots els clients que van ser creats fa més de 5 anys i a que a més no tenen cap lloguer actiu.*/
START TRANSACTION;

SET @inactive_customers = (
    SELECT GROUP_CONCAT(customer_id)
    FROM customer
    WHERE create_date < DATE_SUB(CURRENT_DATE(), INTERVAL 5 YEAR)
      AND customer_id NOT IN (
          SELECT DISTINCT customer_id
          FROM rental
          WHERE return_date IS NULL
      )
);

UPDATE customer
SET active = 0
WHERE FIND_IN_SET(customer_id, @inactive_customers);

COMMIT;

/*Modifica la classificació ('rating') de les pel·lícules per a una classificació més restrictiva: Totes les pel·lícules amb classificació PG es canvien a 'PG-13'.*/
START TRANSACTION;

UPDATE film
SET rating = 'PG-13'
WHERE rating = 'PG';

COMMIT;

/*Afegeix un nou client amb una adreça fictícia.*/
START TRANSACTION;

INSERT INTO address (address, address2, district, city_id, postal_code, phone)
VALUES ('Fictitious Street 123', '', 'Imaginary District', 1, '00000', '123456789');

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', LAST_INSERT_ID(), 1, NOW());

COMMIT;

/*Crea una nova ciutat.*/
START TRANSACTION;

INSERT INTO city (city, country_id, last_update)
VALUES ('New City', 1, NOW());

COMMIT;

/*Afegeix una nova pel·lícula al catàleg.*/
START TRANSACTION;

INSERT INTO film (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update)
VALUES ('New Movie', 'A brand new movie description.', 2025, 1, 3, 4.99, 120, 19.99, 'PG', 'Deleted Scenes,Behind the Scenes', NOW());

COMMIT;
