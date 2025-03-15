-- 1. Crear la base de dades
CREATE DATABASE cinema_management;

-- 2. Crear l'usuari cinemaadmin i assignar-li la base de dades
CREATE USER cinemaadmin WITH PASSWORD 'cinema123';
ALTER DATABASE cinema_management OWNER TO cinemaadmin;

-- Connectar-se a la base de dades
\c cinema_management

-- 3. Crear els esquemes
CREATE SCHEMA movies AUTHORIZATION cinemaadmin;
CREATE SCHEMA sessions AUTHORIZATION cinemaadmin;
CREATE SCHEMA staff AUTHORIZATION cinemaadmin;

-- 4. Crear els rols i assignar permisos
CREATE ROLE Projectionist;
GRANT USAGE, CREATE ON SCHEMA sessions TO Projectionist;

CREATE ROLE TicketSeller;
GRANT USAGE ON SCHEMA movies TO TicketSeller;
GRANT USAGE ON SCHEMA sessions TO TicketSeller;

CREATE ROLE Manager;
GRANT USAGE, CREATE ON SCHEMA movies TO Manager;
GRANT USAGE, CREATE ON SCHEMA sessions TO Manager;
GRANT USAGE, CREATE ON SCHEMA staff TO Manager;
GRANT CREATE ON SCHEMA movies TO Manager;
GRANT CREATE ON SCHEMA sessions TO Manager;
GRANT CREATE ON SCHEMA staff TO Manager;

-- 5. Crear els usuaris i assignar-los rols
CREATE USER laura WITH PASSWORD 'laurapass';
GRANT Projectionist TO laura;

CREATE USER marc WITH PASSWORD 'marcpass';
GRANT TicketSeller TO marc;

CREATE USER ana WITH PASSWORD 'anapass';
GRANT Manager TO ana;
