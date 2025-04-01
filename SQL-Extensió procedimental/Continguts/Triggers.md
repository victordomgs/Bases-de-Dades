# Triggers a PostgreSQL

Un **trigger** és un mecanisme que permet executar una acció automàtica en resposta a certs esdeveniments que passen a una taula o vista dins d'una base de dades.

Els triggers són útils per implementar **lògica de negoci**, fer **validacions**, mantenir **auditories** o actualitzar **taules relacionades** de forma automàtica.

## Quan s'executa un trigger?

Un trigger es pot activar en els següents moments:

- **BEFORE**: abans que es realitzi l'operació (INSERT, UPDATE, DELETE).
- **AFTER**: després de realitzar l'operació.
- **INSTEAD OF**: en comptes de l'operació (només vàlid per a vistes).

## Sobre quines operacions pot actuar?

Els triggers poden respondre a:

- `INSERT`
- `UPDATE`
- `DELETE`
- `TRUNCATE` (només en triggers per a taules)

## Com es defineix un trigger?

Un trigger sempre s’associa a una **funció** que defineix què ha de fer. Aquesta funció ha de retornar `TRIGGER`.

### 1. Crear la funció trigger

```sql
CREATE OR REPLACE FUNCTION check_city_population()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.population < 0 THEN
    RAISE EXCEPTION 'La població no pot ser negativa';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

### 2. Crear el trigger associat a una taula

```sql
CREATE TRIGGER trg_check_city_population
BEFORE INSERT OR UPDATE ON city
FOR EACH ROW
EXECUTE FUNCTION check_city_population();
```

## Altres variables especials

Dins d’un trigger, es poden usar variables proporcionades pel sistema:

- `TG_OP`: indica l’operació (`INSERT`, `UPDATE`, `DELETE`)
- `TG_TABLE_NAME`: nom de la taula que ha activat el trigger
- `TG_WHEN`: moment del trigger (`BEFORE`, `AFTER`)
- `NEW`: nova fila (només en `INSERT` o `UPDATE`)
- `OLD`: fila anterior (només en `UPDATE` o `DELETE`)

Un trigger, també pot ser utilitzat per registrar auditories sobre canvis que es realitzen en la base de dades. Imaginem que volem registrar els canvis que és realitzen sobre la població d'un país (`country`): 

Primer creem la taula:

```sql
CREATE TABLE country_population_log (
  id SERIAL PRIMARY KEY,
  country_code CHAR(3),
  old_population INTEGER,
  new_population INTEGER,
  modified_at TIMESTAMP DEFAULT now()
);
```

Seguidament defnim la funció que insireix la informació a la taula: 

```sql
CREATE OR REPLACE FUNCTION log_country_population_change()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.population <> OLD.population THEN
    INSERT INTO country_population_log(country_code, old_population, new_population)
    VALUES (OLD.code, OLD.population, NEW.population);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

I finalment, creem el trigguer que s'encarrega d'actualitzar la informació al log quan s'executa una actualització sobre la taula `country`:

```sql
CREATE TRIGGER trg_log_country_population
AFTER UPDATE ON country
FOR EACH ROW
WHEN (OLD.population IS DISTINCT FROM NEW.population)
EXECUTE FUNCTION log_country_population_change();
```
