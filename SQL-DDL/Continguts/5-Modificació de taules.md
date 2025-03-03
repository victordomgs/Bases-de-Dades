# Modificació de taules

## 1. Afegir columnes

És possible afegir noves columnes a una taula existent mitjançant `ALTER TABLE ... ADD COLUMN`.

```sql
ALTER TABLE nom_de_la_taula ADD COLUMN nom_columna TIPUS_DE_DADA CONSTRAINTS;
```

Exemple:

```sql
ALTER TABLE clients ADD COLUMN edat INT NOT NULL DEFAULT 18;
```

Aquest exemple afegeix una columna `edat` de tipus `INT` amb un valor per defecte de `18`.

---

## 2. Modificar columnes existents

Podem canviar el tipus de dada, la mida o altres propietats d’una columna amb `MODIFY COLUMN` o `CHANGE COLUMN`.

```sql
ALTER TABLE nom_de_la_taula MODIFY COLUMN nom_columna NOU_TIPUS_DE_DADA;
```

Exemple:

```sql
ALTER TABLE clients MODIFY COLUMN edat SMALLINT;
```

Aquesta ordre redueix la mida de la columna `edat` de `INT` a `SMALLINT`.

Si també volem canviar el nom de la columna:

```sql
ALTER TABLE nom_de_la_taula CHANGE COLUMN nom_actual nou_nom TIPUS_DE_DADA;
```

Exemple:

```sql
ALTER TABLE clients CHANGE COLUMN edat anys SMALLINT;
```

Aquest canvi renombra `edat` a `anys` i ajusta el tipus de dada.

---

## 3. Eliminar columnes

Per eliminar una columna de la taula, fem servir `DROP COLUMN`.

```sql
ALTER TABLE nom_de_la_taula DROP COLUMN nom_columna;
```

Exemple:

```sql
ALTER TABLE clients DROP COLUMN telefon;
```

Aquesta ordre elimina la columna `telefon` de la taula `clients`.

---

## 4. Afegir i eliminar restriccions

Podem modificar les restriccions d'una taula afegint o eliminant claus primàries, claus foranes i altres restriccions.

### **4.1. Afegir una clau primària**

```sql
ALTER TABLE nom_de_la_taula ADD PRIMARY KEY (nom_columna);
```

Exemple:

```sql
ALTER TABLE clients ADD PRIMARY KEY (id);
```

### **4.2. Afegir una clau forana**

```sql
ALTER TABLE nom_de_la_taula ADD CONSTRAINT nom_clau FOREIGN KEY (columna) REFERENCES altra_taula(columna);
```

Exemple:

```sql
ALTER TABLE comandes ADD CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES clients(id);
```

### **4.3. Eliminar una clau forana**

```sql
ALTER TABLE nom_de_la_taula DROP FOREIGN KEY nom_clau;
```

Exemple:

```sql
ALTER TABLE comandes DROP FOREIGN KEY fk_client;
```

### **4.4. Eliminar una clau primària**

```sql
ALTER TABLE nom_de_la_taula DROP PRIMARY KEY;
```

Exemple:

```sql
ALTER TABLE clients DROP PRIMARY KEY;
```

---

## 5. Renombrar taules

Per canviar el nom d'una taula, s'utilitza `RENAME TO`.

```sql
ALTER TABLE nom_actual RENAME TO nou_nom;
```

Exemple:

```sql
ALTER TABLE clients RENAME TO usuaris;
```

Aquest canvi modifica el nom de la taula `clients` a `usuaris`.

---

## 6. Bones pràctiques en la modificació de taules

### **6.1. Planificar els canvis**
- Abans de modificar una taula, assegura't que el canvi no afectarà altres taules relacionades.
- Fes una còpia de seguretat de la base de dades en cas que sigui necessari restaurar dades.

### **6.2. Comprovar dependències**
- Revisa si la columna a eliminar està sent usada en altres parts de la base de dades (claus foranes, vistes, procediments).

### **6.3. Realitzar canvis de forma escalonada**
- Si cal modificar moltes columnes, és recomanable fer-ho en diverses etapes per evitar problemes de compatibilitat.

### **6.4. Evitar canvis innecessaris**
- No modificar columnes massa sovint, ja que pot afectar el rendiment de la base de dades.

---

## 7. Exemple complet

```sql
-- Afegir una nova columna
ALTER TABLE clients ADD COLUMN data_naixement DATE;

-- Modificar el tipus de dada d'una columna existent
ALTER TABLE clients MODIFY COLUMN data_naixement DATETIME;

-- Canviar el nom d'una columna
ALTER TABLE clients CHANGE COLUMN data_naixement data_neix DATETIME;

-- Afegir una clau forana
ALTER TABLE comandes ADD CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES clients(id);

-- Eliminar una clau forana
ALTER TABLE comandes DROP FOREIGN KEY fk_client;

-- Eliminar una columna
ALTER TABLE clients DROP COLUMN telefon;

-- Canviar el nom d'una taula
ALTER TABLE clients RENAME TO usuaris;
```
