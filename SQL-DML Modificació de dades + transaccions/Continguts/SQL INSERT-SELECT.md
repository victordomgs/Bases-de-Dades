# Inserir Dates a Través d'una Sentència SELECT en SQL

En SQL, pots inserir dates en una taula utilitzant una sentència `INSERT INTO ... SELECT`. Aquesta tècnica és útil quan necessites copiar dades d'una altra taula o generar dades basades en una selecció.

A continuació, es presenta una explicació detallada de com inserir dates en diferents situacions.

## Estructura General

La sintaxi bàsica per inserir dades mitjançant una selecció és:

```sql
INSERT INTO taula_destinació (columna1, columna2, columna_data, ...)
SELECT valor1, valor2, data_valor, ...
FROM taula_origen
WHERE condició;
```

### Components:
- **`taula_destinació`**: La taula on s'inseriran les dades.
- **Columnes**: Llista de columnes de la taula destinació on es col·locaran els valors.
- **`SELECT`**: La selecció que genera les dades a inserir.
- **`taula_origen`**: La taula d'on provenen les dades (pot ser una taula existent o una selecció més complexa).
- **`WHERE`** (opcional): Condició per filtrar les dades de la taula origen.

---

## Exemple Pràctic

### Taules Inicials

Suposem que tenim dues taules: 

#### Taula `esdeveniments`
```sql
CREATE TABLE esdeveniments (
    id INT PRIMARY KEY,
    nom VARCHAR(100),
    data_inici DATE
);
```

#### Taula `activitats`
```sql
CREATE TABLE activitats (
    id INT PRIMARY KEY,
    nom_activitat VARCHAR(100),
    data_activitat DATE
);
```

Volem inserir dades a la taula `activitats` a partir dels esdeveniments, reutilitzant el nom de l'esdeveniment i la data d'inici.

### Inserir Dades Amb Dates

#### Inserir directament de la taula origen

Podem copiar les dades de la taula `esdeveniments` a `activitats` utilitzant una sentència `SELECT`:

```sql
INSERT INTO activitats (id, nom_activitat, data_activitat)
SELECT id, nom, data_inici
FROM esdeveniments
WHERE data_inici >= '2025-01-01';
```

#### Explicació
- **`INSERT INTO activitats`**: Especifica que inserirem dades a la taula `activitats`.
- **Columnes especificades**: `id`, `nom_activitat`, `data_activitat` són les columnes on col·locarem els valors.
- **`SELECT`**: Selecciona dades de la taula `esdeveniments`.
- **Filtre `WHERE`**: Només s'inseriran els registres on la data d'inici sigui igual o posterior a l'1 de gener de 2025.

---

## Inserir una Data Fixa o Calculada

### Inserir amb una Data Fixa

Si necessites inserir una data fixa, pots especificar-la directament en la sentència `SELECT`:

```sql
INSERT INTO activitats (id, nom_activitat, data_activitat)
SELECT id, nom, '2025-01-01'
FROM esdeveniments;
```

#### Explicació
- En lloc de copiar la data de la taula origen, s'insereix la data fixa `'2025-01-01'` a la columna `data_activitat`.

### Inserir amb una Data Calculada

També pots calcular una nova data basada en una data existent utilitzant funcions com `DATE_ADD`:

```sql
INSERT INTO activitats (id, nom_activitat, data_activitat)
SELECT id, nom, DATE_ADD(data_inici, INTERVAL 7 DAY)
FROM esdeveniments;
```

#### Explicació
- **`DATE_ADD`**: S'utilitza per sumar dies a una data. En aquest cas, s'afegeixen 7 dies a la data d'inici de cada esdeveniment.
- La nova data calculada s'insereix a la columna `data_activitat`.

---

## Comprovar el Format de la Data

Quan treballes amb dates, assegura't que el format sigui compatible amb el tipus de dada `DATE` o `DATETIME` de la base de dades. Si necessites convertir formats, pots utilitzar funcions com `STR_TO_DATE()` en MySQL.

### Exemple amb Conversió de Format

```sql
INSERT INTO activitats (id, nom_activitat, data_activitat)
SELECT id, nom, STR_TO_DATE('31-12-2025', '%d-%m-%Y')
FROM esdeveniments;
```

#### Explicació
- **`STR_TO_DATE`**: Converteix una cadena de text a un format de data (`'%d-%m-%Y'` en aquest cas, representant dia-mes-any).
- La data convertida s'insereix a la columna `data_activitat`.

---

## Resum

La inserció de dates a través d'una sentència `SELECT` és molt versàtil i permet:

1. Copiar dades existents amb dates.
2. Assignar dates fixes.
3. Generar dates calculades utilitzant funcions com `DATE_ADD`.
4. Gestionar formats de dates utilitzant funcions com `STR_TO_DATE`.

Aquest enfocament és ideal quan necessites manipular o transferir dades entre taules mentre treballes amb valors de data.
