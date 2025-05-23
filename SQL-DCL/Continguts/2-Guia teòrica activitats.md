# Guia teòrica per al desenvolupament de les activitats DCL

## 1. Creació d'una base de dades i usuaris en PostgreSQL

### 1.1. Creació d'una base de dades
Per crear una nova base de dades en PostgreSQL utilitzant l'usuari `postgres`, fem servir:
```sql
CREATE DATABASE nom_database;
```

### 1.2. Creació d'un usuari amb permisos de creació
Per a crear un usuari i assignar-li permisos de creació de nous usuaris:
```sql
CREATE USER nom_user WITH PASSWORD 'contrasenya' CREATEDB CREATEROLE;
```

També es pot utilitzar: 
```sql
CREATE ROLE nom_role WITH LOGIN PASSWORD 'contrasenya' CREATEDB CREATEROLE;
```


### 1.3. Assignació de propietat de la base de dades
```sql
ALTER DATABASE nom_database OWNER TO nom_rol;
```

## 2. Creació d'esquemes
Els esquemes permeten organitzar les taules en diferents categories:
```sql
CREATE SCHEMA nom_schema;
```

> [!TIP]
> Els SCHEMAS s'han de crear desde el usuari que vol tenir la propietat d'aquests. Sino, s'haura d'utilitzar la següent comanda:
> ```sql
> ALTER SCHEMA nom_schema OWNER TO nom_rol;
> ```

## 3. Creació de rols i assignació de privilegis

Els rols permeten definir grups d'usuaris amb privilegis específics sobre els esquemes de la base de dades.

### 3.1. Creació de rols
```sql
CREATE ROLE nom_rol;
```

### 3.2. Assignació de privilegis
```sql
GRANT USAGE ON SCHEMA nom_schema TO nom_rol;
GRANT USAGE, CREATE ON SCHEMA flights TO AirTrafficControl;
```

O afegir més d'un tipus de privilegi a un rol o usuari: 
```sql
GRANT USAGE, CREATE ON SCHEMA nom_schema TO nom_rol;
```

### 3.3. Concepte d'herència

El concepte d'herència sobre rols en PostgreSQL significa que un rol ot heretar automàticament els permisos i privilegis de l'altre rol sense necessitat de que s'assignin explícitament. 

> [!WARNING]
> Per defecte l'herència està activada a PostgreSQL.

S'ha d'especificar quan volem activar o desactivar aquest concepte: 
```sql
ALTER ROLE nom_rol INHERIT;
```

```sql
ALTER ROLE nom_rol NOINHERIT;
```

## 4. Creació d'usuaris i assignació de rols

Per cada usuari s'han d'assignar els rols corresponents i els permisos per connectar-se.

```sql
CREATE USER nom_user WITH PASSWORD 'password' LOGIN;
GRANT nom_rol TO nom_user;
ALTER ROLE nom_user NOINHERIT; --En cas que fos necessari.
```

## 5. Creació de taules i permisos necessaris

Quan es creen taules, cal tenir en compte els permisos de referència per les claus foranes.

A l'activitat `act01_airport.md`:

Per permetre a `Reservations` referenciar `FlightSchedules`:
```sql
GRANT REFERENCES ON TABLE flights.FlightSchedules TO pere;
```

## 7. Verificació de permisos

Per verificar els privilegis assignats:
```sql
SELECT grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name = 'Airports';
```
