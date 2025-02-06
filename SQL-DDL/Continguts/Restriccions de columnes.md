# Restriccions de columnes

## 1. Introducció

Les **restriccions de columnes** en bases de dades garanteixen la integritat i validesa de les dades, evitant errors i inconsistències. S'apliquen quan es defineix o modifica una taula i ajuden a establir regles específiques sobre els valors que es poden emmagatzemar en cada columna.

---

## 2. Tipus de restriccions

### **2.1. NOT NULL**

La restricció `NOT NULL` assegura que una columna no pugui contenir valors nuls (`NULL`).

```sql
CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefon VARCHAR(15)
);
```

En aquest exemple, `nom` és obligatori i no pot ser `NULL`.

Si volem afegir `NOT NULL` a una columna existent:

```sql
ALTER TABLE clients MODIFY COLUMN telefon VARCHAR(15) NOT NULL;
```

Per eliminar la restricció:

```sql
ALTER TABLE clients MODIFY COLUMN telefon VARCHAR(15) NULL;
```

---

### **2.2. UNIQUE**

La restricció `UNIQUE` garanteix que tots els valors d’una columna siguin únics.

```sql
CREATE TABLE usuaris (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);
```

Si volem afegir `UNIQUE` a una columna existent:

```sql
ALTER TABLE usuaris ADD CONSTRAINT un_email UNIQUE (email);
```

Per eliminar la restricció:

```sql
ALTER TABLE usuaris DROP CONSTRAINT un_email;
```

---

### **2.3. PRIMARY KEY**

La clau primària (`PRIMARY KEY`) identifica de manera única cada registre d'una taula. Només pot existir una clau primària per taula i no pot tenir valors `NULL`.

```sql
CREATE TABLE comandes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    total DECIMAL(10,2) NOT NULL
);
```

Per afegir una clau primària a una taula existent:

```sql
ALTER TABLE comandes ADD PRIMARY KEY (id);
```

Per eliminar-la:

```sql
ALTER TABLE comandes DROP PRIMARY KEY;
```

---

### **2.4. FOREIGN KEY**

Les claus foranes (`FOREIGN KEY`) estableixen relacions entre taules, garantint la integritat referencial.

```sql
CREATE TABLE comandes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);
```

Si volem afegir una clau forana a una taula existent:

```sql
ALTER TABLE comandes ADD CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES clients(id);
```

Per eliminar-la:

```sql
ALTER TABLE comandes DROP FOREIGN KEY fk_client;
```

---

### **2.5. CHECK**

La restricció `CHECK` assegura que els valors d'una columna compleixin una condició específica.

```sql
CREATE TABLE productes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    preu DECIMAL(10,2) CHECK (preu > 0)
);
```

Si volem afegir una restricció `CHECK` a una columna existent:

```sql
ALTER TABLE productes ADD CONSTRAINT chk_preu CHECK (preu > 0);
```

Per eliminar-la:

```sql
ALTER TABLE productes DROP CONSTRAINT chk_preu;
```

---

### **2.6. DEFAULT**

La restricció `DEFAULT` assigna un valor per defecte a una columna si no s’especifica cap valor en la inserció.

```sql
CREATE TABLE empleats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    salari DECIMAL(10,2) DEFAULT 1500.00
);
```

Si volem afegir `DEFAULT` a una columna existent:

```sql
ALTER TABLE empleats ALTER COLUMN salari SET DEFAULT 1800.00;
```

Per eliminar-lo:

```sql
ALTER TABLE empleats ALTER COLUMN salari DROP DEFAULT;
```

---

### **2.7. AUTO_INCREMENT**

La restricció `AUTO_INCREMENT` permet que una columna generi automàticament valors únics, generalment per a claus primàries.

```sql
CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
);
```

Cada nou registre inserit en `clients` tindrà un `id` que s'incrementarà automàticament.

Si volem afegir `AUTO_INCREMENT` a una columna existent:

```sql
ALTER TABLE clients MODIFY COLUMN id INT AUTO_INCREMENT;
```

Per eliminar `AUTO_INCREMENT`, es pot modificar la columna:

```sql
ALTER TABLE clients MODIFY COLUMN id INT;
```

---

## 3. Bones pràctiques en l'ús de restriccions

### **3.1. Planificació prèvia**
- Definir `NOT NULL` per a columnes essencials per evitar registres incomplets.
- Usar `UNIQUE` per a dades que han de ser úniques, com correus electrònics o noms d'usuari.

### **3.2. Evitar restriccions innecessàries**
- No abusar de `CHECK`, ja que pot incrementar la complexitat de la base de dades.
- Usar `DEFAULT` només quan hi hagi un valor per defecte raonable.

### **3.3. Comprovar dependències**
- No eliminar una clau forana si la taula depèn d'una altra taula per mantenir la integritat de les dades.
- Repassar les relacions entre taules abans d'afegir o eliminar `FOREIGN KEY`.

### **3.4. Utilitzar noms clars per les restriccions**
- Assignar noms a les restriccions per facilitar la seva gestió:
  ```sql
  ALTER TABLE usuaris ADD CONSTRAINT un_email UNIQUE (email);
  ```
  En lloc de confiar en noms automàtics generats pel SGBD.
