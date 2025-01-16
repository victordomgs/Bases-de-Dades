/*******************************************************************************
   Utilitzant la base de dades SteamDB inserta la següent informació: 
********************************************************************************/

-- Exercicis d'inserció SQL per als alumnes

-- **Exercici 1: Afegir desenvolupadors**
-- A la taula "developers", afegiu tres desenvolupadors amb les següents característiques:
-- 1. Un desenvolupador japonès conegut pel seu treball en videojocs icònics com "Super Mario" i "The Legend of Zelda".
INSERT INTO developers (name, country) 
VALUES ('Nintendo', 'Japan');
-- 2. Un estudi nord-americà especialitzat en jocs d'acció i món obert com "Grand Theft Auto".
INSERT INTO developers (name, country) 
VALUES ('Rockstar Games', 'USA');
-- 3. Un desenvolupador polonès famós per la sèrie "The Witcher".
INSERT INTO developers (name, country) 
VALUES ('CD Projekt Red', 'Poland');
-- No ens deixarà, ja que ja existeix a la taula. I el camp "name" està definit com a UNIQUE.

-- **Exercici 2: Afegir jocs**
-- A la taula "games", afegiu tres jocs amb aquestes dades:
-- 1. Un joc d'aventura llançat el 3 de març de 2017 per un desenvolupador japonès. El seu preu és de 59.99 euros i pertany al gènere d'aventures.
INSERT INTO games (name, release_date, developer_id, price, genre) 
SELECT 'The Legend of Zelda', '2017-03-03', (SELECT developer_id FROM developers WHERE name = 'Nintendo'), 59.99, 'Aventura';
-- 2. Un joc d'acció i món obert llançat el 17 de setembre de 2013 per un estudi nord-americà. Té un preu de 29.99 euros.
INSERT INTO games (name, release_date, developer_id, price, genre) 
SELECT 'Grand Theft Auto', '2013-09-17', (SELECT developer_id FROM developers WHERE name = 'Rockstar Games'), 39.99, 'Action RPG';
-- 3. Un RPG premiat, llançat el 19 de maig de 2015, desenvolupat per un estudi polonès. El preu és de 39.99 euros.
INSERT INTO games (name, release_date, developer_id, price, genre) 
SELECT 'The Witcher', '2015-05-19', (SELECT developer_id FROM developers WHERE name = 'CD Projekt Red'), 39.99, 'RPG';

-- **Exercici 3: Afegir usuaris**
-- A la taula "users", creeu tres usuaris amb la següent informació:
-- 1. Un usuari apassionat de "The Legend of Zelda", amb el nom d'usuari que reflecteixi el seu amor per Link. Es va registrar el 1 de gener de 2024.
INSERT INTO users (username, email, password_hash, join_date) 
VALUES ('LinkLover', 'player2378@hotmail.com', 'u398574f', '2024-01-01');
-- 2. Un usuari entusiasta de "Grand Theft Auto", amb un correu electrònic relacionat amb el joc i un nom d'usuari adequat. Es va unir el 2 de gener de 2024.
INSERT INTO users (username, email, password_hash, join_date) 
VALUES ('MafiaLover', 'gta6waiting@hotmail.com', 'j923843@8945', '2024-01-02');
-- 3. Un fan incondicional de "The Witcher". El nom d'usuari ha de fer referència al títol del joc. Es va registrar el 3 de gener de 2024.
INSERT INTO users (username, email, password_hash, join_date) 
VALUES ('witchUser', 'paco@hotmail.com', 'je98023nf9e', '2024-01-03');

-- **Exercici 4: Afegir transaccions**
-- Registreu tres transaccions a la taula "transactions" amb les següents dades:
-- 1. Una compra feta per l'usuari de "The Legend of Zelda" el 5 de gener de 2024 per un import de 59.99 euros.
INSERT INTO transactions (user_id, game_id, transaction_date, amount) 
SELECT (SELECT user_id FROM users WHERE username = 'LinkLover'), (SELECT game_id FROM games WHERE name = 'The Legend of Zelda'), '2024-01-05', 59.99; 
-- 2. Una transacció realitzada per l'usuari fan de "Grand Theft Auto" el 6 de gener de 2024, amb un import de 29.99 euros.
INSERT INTO transactions (user_id, game_id, transaction_date, amount) 
SELECT (SELECT user_id FROM users WHERE email LIKE ("%gta%")), (SELECT game_id FROM games WHERE name = 'Grand Theft Auto'), '2024-01-06', 29.99; 
-- 3. Una compra del joc "The Witcher 3" efectuada pel seu fan el 7 de gener de 2024, amb un cost de 39.99 euros.
INSERT INTO transactions (user_id, game_id, transaction_date, amount) 
SELECT (SELECT user_id FROM users WHERE username LIKE ("%witch%")), (SELECT game_id FROM games WHERE name = 'The Witcher'), '2024-01-07', 39.99; 

-- **Exercici 5: Afegir ressenyes**
-- A la taula "reviews", afegiu les opinions dels usuaris sobre els seus jocs favorits:
-- 1. Una ressenya de 5 estrelles per "The Legend of Zelda", destacant el seu món obert fascinant. La ressenya es va publicar el 10 de gener de 2024.
INSERT INTO reviews (user_id, game_id, rating, review_text, review_date) 
SELECT (SELECT user_id FROM users WHERE username = 'LinkLover'), (SELECT game_id FROM games WHERE name = 'The Legend of Zelda'), 5, 'Great open world', '2024-01-10';
-- 2. Una opinió de 4 estrelles sobre "Grand Theft Auto", mencionant la seva història captivadora. Publicada l'11 de gener de 2024.
INSERT INTO reviews (user_id, game_id, rating, review_text, review_date) 
SELECT (SELECT user_id FROM users WHERE email LIKE ("%gta%")), (SELECT game_id FROM games WHERE name = 'Grand Theft Auto'), 4, 'Great story', '2024-01-11';
-- 3. Una ressenya de 5 estrelles per "The Witcher 3", descrivint-lo com el millor RPG de tots els temps. Escrita el 12 de gener de 2024.
INSERT INTO reviews (user_id, game_id, rating, review_text, review_date) 
SELECT (SELECT user_id FROM users WHERE username LIKE ("%witch%")), (SELECT game_id FROM games WHERE name = 'The Witcher'), 5, 'The GOAT RPG', '2024-01-12';
