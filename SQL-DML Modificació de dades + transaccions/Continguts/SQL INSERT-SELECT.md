# Inserir Dades a Través d'una Sentència SELECT en SQL

En SQL, pots inserir dades en una taula utilitzant una sentència `INSERT INTO ... SELECT`. Aquesta tècnica és útil quan necessites copiar dades d'una altra taula o generar dades basades en una selecció.

## Estructura General

La sintaxi bàsica per inserir dades mitjançant una selecció és:

```sql
INSERT INTO taula_destinació (columna1, columna2, ...)
SELECT valor1, valor2, ...
FROM taula_origen
WHERE condició;
```

### Components:
- **`taula_destinació`**: La taula on s'inseriran les dades.
- **`columnes`**: Llista de columnes de la taula destinació on es col·locaran els valors.
- **`SELECT`**: La selecció que genera les dades a inserir.
- **`taula_origen`**: La taula d'on provenen les dades (pot ser una taula existent o una selecció més complexa).
- **`WHERE`** (opcional): Condició per filtrar les dades de la taula origen.

---

## Exemple Pràctic

### Taules Inicials

Suposem que tenim dues taules: 

#### Taula `empleats`
```sql
CREATE TABLE empleats (
    id INT PRIMARY KEY,
    nom VARCHAR(100),
    departament_id INT
);
```

#### Taula `nous_empleats`
```sql
CREATE TABLE nous_empleats (
    id INT PRIMARY KEY,
    nom VARCHAR(100),
    departament_id INT
);
```

Volem inserir dades de la taula `nous_empleats` a la taula `empleats`.

### Inserir Dades

#### Inserir directament de la taula origen

Podem copiar les dades de la taula `nous_empleats` a `empleats` utilitzant una sentència `SELECT`:

```sql
INSERT INTO empleats (id, nom, departament_id)
SELECT id, nom, departament_id
FROM nous_empleats;
```

#### Explicació
- **`INSERT INTO empleats`**: Especifica que inserirem dades a la taula `empleats`.
- **Columnes especificades**: `id`, `nom`, `departament_id` són les columnes on col·locarem els valors.
- **`SELECT`**: Selecciona dades de la taula `nous_empleats`.

---

## Inserir Dades Amb Transformacions

### Inserir Amb Dades Calculades

També pots transformar o calcular els valors durant la selecció abans d'inserir-los. Per exemple, suposem que volem afegir un prefix al nom dels empleats abans d'inserir-los:

```sql
INSERT INTO empleats (id, nom, departament_id)
SELECT id, CONCAT('Nou-', nom), departament_id
FROM nous_empleats;
```

#### Explicació
- **`CONCAT`**: S'utilitza per concatenar una cadena de text amb el valor de la columna `nom`.
- El nom dels empleats inserits tindrà el prefix `Nou-`.

### Inserir Amb Valors Fixos

Si necessites inserir un valor fix per a una columna, pots especificar-lo directament en la sentència `SELECT`:

```sql
INSERT INTO empleats (id, nom, departament_id)
SELECT id, nom, 1
FROM nous_empleats;
```

#### Explicació
- En lloc de copiar el valor de la columna `departament_id` de la taula origen, s'insereix el valor fix `1` a totes les files.

---

## Inserir Amb Condicions

Pots utilitzar una condició per filtrar quines dades s'inseriran a la taula destinació. Per exemple, només volem inserir els empleats que pertanyen al departament 2:

```sql
INSERT INTO empleats (id, nom, departament_id)
SELECT id, nom, departament_id
FROM nous_empleats
WHERE departament_id = 2;
```

#### Explicació
- **`WHERE departament_id = 2`**: Només les files de la taula `nous_empleats` amb `departament_id = 2` s'inseriran a `empleats`.

---

## Comprovar Integritat de les Dades

Quan treballes amb dades a inserir, assegura't que:

1. Els tipus de dades de les columnes seleccionades coincideixin amb els de les columnes de la taula destinació.
2. Les restriccions de la taula destinació (com claus primàries o valors únics) no es violin.

Per exemple, si `id` és una clau primària a la taula `empleats`, no pots inserir dues files amb el mateix `id`.
