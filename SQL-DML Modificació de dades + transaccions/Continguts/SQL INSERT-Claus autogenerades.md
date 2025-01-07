# Inserir dades amb claus autogenerades en SQL

En SQL, les claus autogenerades són valors únics que es creen automàticament per la base de dades quan s'insereix una nova fila. 

---

## Què són les claus autogenerades?

Les claus autogenerades són valors generats automàticament per la base de dades mitjançant una funcionalitat interna, com ara:

1. **Auto-increment (`AUTO_INCREMENT`)**: En bases de dades com MySQL, es pot definir una columna com a `AUTO_INCREMENT` perquè es generi un nou valor seqüencial cada vegada que s'insereix una fila.

2. **Sequences**: En bases de dades com PostgreSQL i Oracle, es poden utilitzar seqüències per generar valors únics.

3. **UUID**: Algunes bases de dades permeten generar claus úniques utilitzant identificadors únics universals (UUID).

Aquestes claus garanteixen que cada fila tingui un identificador únic, evitant conflictes de claus duplicades.

---

## Crear una taula amb claus autogenerades

### Exemple amb `AUTO_INCREMENT` (MySQL)

```sql
CREATE TABLE empleats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    departament_id INT
);
```

- **`AUTO_INCREMENT`**: Indica que la columna `id` serà autogenerada amb un valor seqüencial.
- **`PRIMARY KEY`**: Defineix que `id` és la clau primària.

### Exemple amb sequences (PostgreSQL)

```sql
CREATE TABLE empleats (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    departament_id INT
);
```

- **`SERIAL`**: Genera automàticament valors seqüencials per a la columna `id`.
- Això és similar a `AUTO_INCREMENT` en MySQL.

---

## Inserir dades amb claus autogenerades

Quan una columna està configurada per generar claus automàticament, no cal incloure-la en la sentència `INSERT INTO`. La base de dades s'encarrega de generar el valor per a aquesta columna.

### Exemple bàsic d'inserció

#### MySQL o PostgreSQL
```sql
INSERT INTO empleats (nom, departament_id)
VALUES ('Anna', 2);
```

- En aquest cas, la base de dades genera automàticament el valor de la columna `id`.

#### Resultat:
| id  | nom  | departament_id |
|-----|------|----------------|
| 1   | Anna | 2              |

---

## Recuperar el valor generat

Després d'inserir una fila amb una clau autogenerada, pots recuperar el valor generat utilitzant una funció o una instrucció específica, depenent del sistema de gestió de bases de dades:

### MySQL
```sql
SELECT LAST_INSERT_ID();
```

- Això retorna el valor de l'última clau autogenerada en la sessió actual.

### PostgreSQL
```sql
INSERT INTO empleats (nom, departament_id)
VALUES ('Bernat', 3)
RETURNING id;
```

- La clausula `RETURNING` retorna directament el valor generat per la columna `id`.

---

## Claus autogenerades i `INSERT INTO ... SELECT`

També pots inserir dades en una taula amb claus autogenerades utilitzant una sentència `SELECT`.

### Exemple
Suposem que tenim una taula `nous_empleats` amb les següents dades:

```sql
CREATE TABLE nous_empleats (
    id AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    departament_id INT
);

| id  | nom    | departament_id |
|-----|--------|----------------|
| 1   | Clara  | 1              |
| 2   | David  | 2              |

Podem copiar aquestes dades a la taula `empleats` amb una clau autogenerada per a cada registre:

```sql
INSERT INTO empleats (nom, departament_id)
SELECT nom, departament_id
FROM nous_empleats;
```

- El valor de `id` es genera automàticament com un valor únic.

#### Resultat:
| id  | nom    | departament_id |
|-----|--------|----------------|
| 1   | Anna   | 2              |
| 2   | Clara  | 1              |
| 3   | David  | 2              |

---

## Claus autogenerades amb UUID

En lloc de valors seqüencials, pots utilitzar identificadors únics universals (`UUID`) per a generar claus primàries. Aquesta tècnica és útil quan necessites claus úniques globalment i no només dins d'una taula específica.

### Exemple amb UUID (MySQL o PostgreSQL)

#### Crear una taula
```sql
CREATE TABLE empleats (
    id UUID PRIMARY KEY DEFAULT (UUID_GENERATE_V4()),
    nom VARCHAR(100),
    departament_id INT
);
```

#### Inserir dades
```sql
INSERT INTO empleats (nom, departament_id)
VALUES ('Eva', 3);
```

- El valor de `id` es genera automàticament com un UUID.

---
