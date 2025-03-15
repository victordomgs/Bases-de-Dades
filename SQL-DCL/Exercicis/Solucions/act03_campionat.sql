-- 1. Crear la base de dades
CREATE DATABASE championship_management;

-- 2. Crear l'usuari champadmin i assignar-li la base de dades
CREATE USER champadmin WITH PASSWORD 'champ123';
ALTER DATABASE championship_management OWNER TO champadmin;

-- Connectar-se a la base de dades
\c championship_management

-- 3. Crear els esquemes
CREATE SCHEMA teams AUTHORIZATION champadmin;
CREATE SCHEMA matches AUTHORIZATION champadmin;
CREATE SCHEMA staff AUTHORIZATION champadmin;

-- 4. Crear els rols i assignar permisos
CREATE ROLE Coach;
GRANT USAGE ON SCHEMA teams TO Coach;
GRANT USAGE, CREATE ON SCHEMA staff TO Coach;

CREATE ROLE Referee;
GRANT USAGE, CREATE ON SCHEMA matches TO Referee;
GRANT USAGE ON SCHEMA staff TO Referee;

CREATE ROLE Manager;
GRANT USAGE, CREATE ON SCHEMA teams TO Manager;
GRANT USAGE ON SCHEMA matches TO Manager;
GRANT USAGE, CREATE ON SCHEMA staff TO Manager;

-- 5. Crear els usuaris i assignar-los rols
CREATE USER marta WITH PASSWORD 'martapass';
GRANT Coach TO marta;

CREATE USER jordi WITH PASSWORD 'jordipass';
GRANT Referee TO jordi;

CREATE USER alex WITH PASSWORD 'alexpass';
GRANT Manager TO alex;

