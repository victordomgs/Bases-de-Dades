
/*******************************************************************************
   Utilitzant la base de dades SteamDB, realitzeu els següents exercicis UPDATE:
********************************************************************************/

-- **Exercici 1: Actualitzar desenvolupadors**
-- 1. Canvieu el país del desenvolupador japonès a "Asia".
UPDATE developers
SET country = 'Asia'
WHERE country = 'Japó';
-- 2. Actualitzeu el nom de l'estudi nord-americà per afegir-hi "Studios".
UPDATE developers
SET name = CONCAT(name, ' Studios')
WHERE country = 'Estats Units';
-- 3. Modifiqueu el nom del desenvolupador polonès per incloure-hi "(Polònia)".
UPDATE developers
SET name = CONCAT(name, ' (Polònia)')
WHERE country = 'Polònia';

-- **Exercici 2: Actualitzar jocs**
-- 1. Canvieu el preu del joc d'aventura a 49.99 euros.
UPDATE games
SET price = 49.99
WHERE genre = 'Aventura';
-- 2. Modifiqueu el gènere del joc d'acció i món obert a "Acció/Aventura".
UPDATE games
SET genre = 'Acció/Aventura'
WHERE genre = 'Action RPG';
-- 3. Actualitzeu la data de llançament de l'RPG al 20 de maig de 2015.
UPDATE games
SET release_date = '2015-05-20'
WHERE genre = 'RPG'

-- **Exercici 3: Actualitzar usuaris**
-- 1. Canvieu el correu electrònic de l'usuari de "Grand Theft Auto" per un que inclogui "fanatic".
UPDATE users 
SET email = CONCAT(SUBSTRING_INDEX(email, '@', 1), 'fanatic@', SUBSTRING_INDEX(email, '@', -1)) 
WHERE user_id = (SELECT user_id FROM transactions t JOIN games g ON t.game_id = g.game_id WHERE g.name = 'Grand Theft Auto');
-- 2. Actualitzeu el nom d'usuari del fan de "The Witcher" per afegir "Pro".
UPDATE users 
SET username = CONCAT(username, 'pro')
WHERE user_id = (SELECT user_id FROM transactions t JOIN games g ON t.game_id = g.game_id WHERE g.name = 'The Witcher');
-- 3. Modifiqueu la data de registre de l'usuari de "The Legend of Zelda" al 2 de gener de 2024.
UPDATE users 
SET join_date = '2024-01-02'  
WHERE user_id = (SELECT user_id FROM transactions t JOIN games g ON t.game_id = g.game_id WHERE g.name = 'The Legend of Zelda');

-- **Exercici 4: Actualitzar transaccions**
-- 1. Canvieu l'import de la transacció del fan de "Grand Theft Auto" a 25.99 euros.
UPDATE transactions 
SET amount = 25.99 
WHERE game_id = (SELECT game_id FROM games WHERE name = 'Grand Theft Auto');
-- 2. Modifiqueu la data de transacció de la compra de "The Witcher" al 8 de gener de 2024.
UPDATE transactions
SET transaction_date = '2024-01-08' 
WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Witcher');
-- 3. Afegiu un descompte del 10% a l'import de la transacció del joc d'aventura.
UPDATE transactions
SET amount = amount*0.90
WHERE game_id = (SELECT game_id FROM games WHERE genre = 'Aventura');

-- **Exercici 5: Actualitzar ressenyes**
-- 1. Reduïu la puntuació de la ressenya de "Grand Theft Auto" a 3 estrelles.
UPDATE reviews 
SET rating = (rating-3)
WHERE game_id = (SELECT game_id FROM games WHERE name = 'Grand Theft Auto');
-- 2. Modifiqueu la ressenya del joc "The Witcher" per destacar el seu sistema de combat.
UPDATE reviews
SET review_text = 'Great combat system' 
WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Witcher');
-- 3. Actualitzeu la data de publicació de la ressenya de "The Legend of Zelda" al 11 de gener de 2024.
UPDATE reviews
SET review_date = '2024-01-11' 
WHERE game_id = (SELECT game_id FROM games WHERE name = 'The Legend of Zelda');