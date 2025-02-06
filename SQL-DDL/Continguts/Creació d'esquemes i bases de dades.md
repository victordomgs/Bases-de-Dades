# Creació d'esquemes i bases de dades

## 1. Creació d'una base de dades

### **1.1. Sintaxi bàsica**

Per crear una base de dades en SQL, s'utilitza la instrucció `CREATE DATABASE`:

```sql
CREATE DATABASE nom_de_la_base_de_dades;
```

### **1.2. Definició de codificació i col·lació**

En molts SGBD, podem definir la codificació de caràcters i la col·lació (ordre de classificació de text). Exemples:

```sql
CREATE DATABASE exemple_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;
```

- `CHARACTER SET utf8mb4`: Defineix el joc de caràcters per suportar emojis i idiomes diversos.
- `COLLATE utf8mb4_general_ci`: Defineix com es comparen i ordenen les dades textuals.

### **1.3. Comprovar si la base de dades ja existeix**

Per evitar errors si la base de dades ja existeix:

```sql
CREATE DATABASE IF NOT EXISTS exemple_db;
```

Aquesta instrucció només crearà la base de dades si no existeix prèviament.

---

## 2. Eliminació d'una base de dades

### **2.1. Sintaxi per eliminar una base de dades**

```sql
DROP DATABASE nom_de_la_base_de_dades;
```

Aquesta ordre **esborra completament** la base de dades i totes les seves taules, per tant, cal fer-ho amb precaució.

### **2.2. Evitar errors si la base de dades no existeix**

```sql
DROP DATABASE IF EXISTS exemple_db;
```

Aquest enfocament evita errors si la base de dades no existeix.

---

## 3. Modificació d'una base de dades

### **3.1. Modificar la col·lació o codificació**

```sql
ALTER DATABASE exemple_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Aquesta ordre canvia la codificació i col·lació de la base de dades, però no modifica les taules existents.

---

## 4. Llistat de bases de dades

Per veure les bases de dades disponibles en un SGBD:

```sql
SHOW DATABASES;
```

Exemple de sortida:

```
+--------------------+
| Database          |
+--------------------+
| exemple_db        |
| information_schema |
| mysql             |
| performance_schema |
+--------------------+
```

---

## 5. Seleccionar una base de dades

Abans de treballar amb una base de dades, cal seleccionar-la:

```sql
USE exemple_db;
```

Aquesta ordre estableix `exemple_db` com la base de dades activa per a les operacions posteriors.

---

## 6. Exemple complet

```sql
-- Creació de la base de dades
CREATE DATABASE IF NOT EXISTS exemple_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

-- Selecció de la base de dades
USE exemple_db;

-- Modificació de la codificació
ALTER DATABASE exemple_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Eliminació segura de la base de dades
DROP DATABASE IF EXISTS exemple_db;
```
