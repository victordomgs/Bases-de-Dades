# Funcions útils

---

## 1. **Mostrar bases de dades**

### Comanda: `SHOW DATABASES;`
Aquesta comanda mostra una llista de totes les bases de dades disponibles en el servidor.

```sql
SHOW DATABASES;
```

Exemple de sortida:
```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| my_database        |
| test               |
+--------------------+
```

---

## 2. **Seleccionar una base de dades**

### Comanda: `USE`
Permet seleccionar una base de dades per defecte per treballar-hi.

```sql
USE nom_base_de_dades;
```

Sortida:
```
Database changed
```

---

## 3. **Mostrar taules d'una base de dades**

### Comanda: `SHOW TABLES;`
Llista totes les taules d'una base de dades activa.

```sql
SHOW TABLES;
```

Exemple de sortida:
```
+------------------+
| Tables_in_my_db  |
+------------------+
| clients          |
| orders           |
| products         |
+------------------+
```

---

## 4. **Descriure l'estructura d'una taula**

### Comanda: `DESCRIBE`
Proporciona informació sobre les columnes d'una taula, incloent tipus de dades, claus, i si permeten valors nuls.

```sql
DESCRIBE nom_taula;
```

Exemple:
```sql
DESCRIBE clients;
```

Sortida:
```
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| id          | int         | NO   | PRI | NULL    | auto_increment |
| name        | varchar(50) | YES  |     | NULL    |                |
| email       | varchar(100)| YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
```

---

## 5. **Executar un fitxer SQL**

### Comanda: `SOURCE`
Permet executar un fitxer SQL des d'un directori específic.

```sql
SOURCE ruta_al_fitxer.sql;
```

Exemple:
```sql
SOURCE /path/to/script.sql;
```

> [!IMPORTANT]
> Aquesta comanda és útil per importar dades o executar scripts de configuració.

---

## 6. **Comprovar l'estat del servei**

### Comanda: `STATUS`
Mostra informació sobre l'estat de la connexió actual i del servidor MySQL.

```sql
STATUS;
```

Exemple de sortida:
```
--------------
mysql  Ver 8.0.33 for Linux on x86_64 (MySQL Community Server - GPL)
Connection id:          10
Current database:       my_database
Current user:           user@localhost
...
```

---

## 7. **Mostrar l'estructura d'una base de dades**

### Comanda: `SHOW CREATE DATABASE`
Mostra l'ordre SQL que es va utilitzar per crear una base de dades.

```sql
SHOW CREATE DATABASE nom_base_de_dades;
```

Exemple:
```sql
SHOW CREATE DATABASE my_database;
```
Sortida:
```
+-----------------+-------------------------------------------------------+
| Database        | Create Database                                       |
+-----------------+-------------------------------------------------------+
| my_database     | CREATE DATABASE `my_database` /*!40100 DEFAULT ... */ |
+-----------------+-------------------------------------------------------+
```

---

## 8. **Mostrar l'estructura d'una taula**

### Comanda: `SHOW CREATE TABLE`
Mostra l'ordre SQL utilitzat per crear una taula.

```sql
SHOW CREATE TABLE nom_taula;
```

Exemple:
```sql
SHOW CREATE TABLE clients;
```
Sortida:
```
+---------+------------------------------------------------------------+
| Table   | Create Table                                               |
+---------+------------------------------------------------------------+
| clients | CREATE TABLE `clients` (                                   |
|         |   `id` int NOT NULL AUTO_INCREMENT,                        |
|         |   `name` varchar(50) DEFAULT NULL,                        |
|         |   PRIMARY KEY (`id`)                                      |
|         | ) ENGINE=InnoDB DEFAULT CHARSET=utf8                       |
+---------+------------------------------------------------------------+
```

---

## 9. **Mostrar Informació sobre els usuaris**

### Comanda: `SELECT USER()`
Aquesta comanda mostra l'usuari actual connectat al servidor MySQL.

```sql
SELECT USER();
```

Exemple de sortida:
```
+----------------+
| USER()         |
+----------------+
| user@localhost |
+----------------+
```
