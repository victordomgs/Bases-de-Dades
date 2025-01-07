# Com utilitzar la funció INSERT en SQL

La funció `INSERT` s'utilitza en SQL per afegir noves files (registres) a una taula d'una base de dades.

---

## **Sintaxi bàsica**

```sql
INSERT INTO nom_taula (columna1, columna2, columna3, ...)
VALUES (valor1, valor2, valor3, ...);
```

- **`nom_taula`**: Nom de la taula on es volen inserir les dades.
- **`columna1, columna2, columna3`**: Noms de les columnes en les quals es volen inserir els valors.
- **`valor1, valor2, valor3`**: Els valors que es volen afegir a cada columna.

---

## **Exemple bàsic**

Suposem que tenim una taula anomenada `usuaris` amb les següent columnes:

```sql
CREATE TABLE Usuaris (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    edat INT NOT NULL
);
```

| id | nom     | correu                | edat |
|----|---------|-----------------------|------|
| 1  | Anna    | anna@example.com      | 25   |
| 2  | Marc    | marc@example.com      | 30   |

Volem afegir un nou usuari a aquesta taula. La consulta seria:

```sql
INSERT INTO usuaris (nom, correu, edat)
VALUES ('Joan', 'joan@example.com', 35);
```

Després d'executar aquesta consulta, la taula quedarà:

| id | nom     | correu                | edat |
|----|---------|-----------------------|------|
| 1  | Anna    | anna@example.com      | 25   |
| 2  | Marc    | marc@example.com      | 30   |
| 3  | Joan    | joan@example.com      | 35   |

---

## **Inserir dades a totes les columnes**
Si vols inserir dades a **totes les columnes** de la taula, pots ometre els noms de les columnes. Però l'ordre dels valors ha de coincidir amb l'ordre de les columnes de la taula.

```sql
INSERT INTO usuaris
VALUES (4, 'Maria', 'maria@example.com', 28);
```

---

## **Insercions multiples**
També pots inserir diverses files alhora utilitzant una única consulta `INSERT`:

```sql
INSERT INTO usuaris (nom, correu, edat)
VALUES
  ('Pau', 'pau@example.com', 22),
  ('Laura', 'laura@example.com', 27),
  ('Carla', 'carla@example.com', 32);
```

Aquest codi inserirà tres nous registres en la taula `usuaris`.

---

## **Consideracions**
1. **Valors nuls (`NULL`)**:
   - Si una columna permet valors nuls, pots inserir el valor `NULL` per indicar que la dada no està disponible.
   - Exemple:
     ```sql
     INSERT INTO usuaris (nom, correu, edat)
     VALUES ('Guillem', NULL, 29);
     ```
> [!IMPORTANT]  
> No podem inserir valors `NULL` en algun d'aquests supòsits:
> 1. Restricció `NOT NULL`. Si una columna té la restricció `NOT NULL, no se li permeten valors `NULL`.
> 2. Les claus primàries no poden contenir valors `NULL`. Això és perquè una clau primària ha de ser única i no pot estar buida per identificar de manera unívoca un registre en una taula.

2. **Tipus de dades**:
   - Assegura't que els valors inserits coincideixen amb els tipus de dades definits per cada columna (per exemple, text, enter, data, etc.).

3. **Claus primàries**:
   - Si la taula té una clau primària, assegura't que els valors inserits en aquesta columna són únics.

---

## **Errors comuns**
1. **Omplir columnes obligatòries**:
   - Si una columna està definida com a `NOT NULL`, has d'inserir-hi un valor.
   - Exemple d'error:
     ```sql
     INSERT INTO usuaris (nom, correu)
     VALUES ('Anna', 'anna@example.com');
     -- Error: falta la columna "edat"
     ```

2. **Duplicats en claus primàries**:
   - Si intentes inserir un valor duplicat en una columna amb clau primària, rebràs un error.
   - Exemple:
     ```sql
     INSERT INTO usuaris (id, nom, correu, edat)
     VALUES (1, 'Pere', 'pere@example.com', 40);
     -- Error: valor duplicat a la clau primària "id"
     ```

---
