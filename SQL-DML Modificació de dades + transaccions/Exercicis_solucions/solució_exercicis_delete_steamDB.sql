/*******************************************************************************
   Utilitzant la base de dades SteamDB, realitzeu els següents exercicis DELETE:
********************************************************************************/

-- **Exercici 1: Eliminar desenvolupadors**
-- 1. Elimineu el desenvolupador japonès.
DELETE FROM developers
WHERE country = 'Japan';
-- 2. Esborreu l'estudi nord-americà de la taula "developers".
DELETE FROM developers
WHERE country = 'USA';
-- 3. Suprimiu el desenvolupador polonès.
DELETE FROM developers
WHERE country = 'Poland';

-- **Exercici 2: Eliminar jocs**
-- 1. Esborreu el joc d'aventura de la taula "games".
DELETE FROM games
WHERE genre = 'Adventure';
-- 2. Elimineu el joc d'acció i món obert.
DELETE FROM games
WHERE genre = 'Action' AND name LIKE '%Open World%';
-- 3. Suprimiu l'RPG desenvolupat per l'estudi polonès.
DELETE FROM games
WHERE genre = 'RPG' AND developer_id = (
    SELECT developer_id FROM developers WHERE country = 'Poland'
);

-- **Exercici 3: Eliminar usuaris**
-- 1. Esborreu l'usuari apassionat de "The Legend of Zelda".
DELETE FROM users
WHERE user_id IN (
    SELECT user_id FROM reviews
    WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Legend of Zelda')
);
-- 2. Elimineu el fan de "Grand Theft Auto".
DELETE FROM users
WHERE user_id IN (
    SELECT user_id FROM reviews
    WHERE game_id = (SELECT game_id FROM games WHERE name = 'Grand Theft Auto')
);
-- 3. Suprimiu l'usuari fan de "The Witcher".
DELETE FROM users
WHERE user_id IN (
    SELECT user_id FROM reviews
    WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Witcher')
);

-- **Exercici 4: Eliminar transaccions**
-- 1. Esborreu la transacció del fan de "Grand Theft Auto".
DELETE FROM transactions
WHERE user_id IN (
    SELECT user_id FROM reviews
    WHERE game_id = (SELECT game_id FROM games WHERE name = 'Grand Theft Auto')
);
-- 2. Elimineu la transacció del joc "The Witcher 3".
DELETE FROM transactions
WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Witcher 3');
-- 3. Suprimiu la transacció del joc d'aventura.
DELETE FROM transactions
WHERE game_id IN (
    SELECT game_id FROM games WHERE genre = 'Adventure'
);

-- **Exercici 5: Eliminar ressenyes**
-- 1. Esborreu la ressenya de "The Legend of Zelda".
DELETE FROM reviews
WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Legend of Zelda');
-- 2. Elimineu la ressenya de "Grand Theft Auto".
DELETE FROM reviews
WHERE game_id = (SELECT game_id FROM games WHERE name = 'Grand Theft Auto');
-- 3. Suprimiu la ressenya de "The Witcher 3".
DELETE FROM reviews
WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Witcher 3');
