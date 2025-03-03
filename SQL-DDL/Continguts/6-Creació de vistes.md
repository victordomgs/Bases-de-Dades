# Creació de vistes

## 1. Creació d'una vista

### **1.1. Sintaxi bàsica**

La sintaxi per crear una vista és:

```sql
CREATE VIEW nom_de_la_vista AS
SELECT columna1, columna2, ...
FROM taula
WHERE condició;
```

Exemple:

```sql
CREATE VIEW vista_clients AS
SELECT id, nom, email FROM clients;
```

Aquesta vista permet accedir només a les columnes `id`, `nom` i `email` de la taula `clients`, ocultant altres dades sensibles.

---

## 2. Avantatges de les vistes

### **2.1. Simplificació de consultes**
- Permeten reutilitzar consultes complexes sense haver d'escriure-les repetidament.
- Exemple:
  ```sql
  CREATE VIEW clients_actius AS
  SELECT id, nom FROM clients WHERE actiu = 1;
  ```
  Després, podem fer:
  ```sql
  SELECT * FROM clients_actius;
  ```

### **2.2. Seguretat i control d'accés**
- Les vistes poden restringir l'accés a certes columnes d'una taula.
- Exemple:
  ```sql
  CREATE VIEW vista_empleats AS
  SELECT nom, càrrec FROM empleats;
  ```
  Els usuaris amb accés a `vista_empleats` no podran veure els sous.

### **2.3. Independència de dades**
- Si es modifica l'estructura d'una taula, la vista pot seguir operant sense necessitat de modificar les consultes.

---

## 3. Modificació d'una vista

Per modificar una vista existent, fem servir `CREATE OR REPLACE VIEW`:

```sql
CREATE OR REPLACE VIEW vista_clients AS
SELECT id, nom, email, telefon FROM clients;
```

Aquesta ordre sobreescriu la vista `vista_clients` afegint la columna `telefon`.

---

## 4. Eliminació d'una vista

Per eliminar una vista:

```sql
DROP VIEW nom_de_la_vista;
```

Exemple:

```sql
DROP VIEW IF EXISTS vista_clients;
```

Aquesta ordre assegura que no es produeixi un error si la vista no existeix.

---

## 5. Limitacions de les vistes

### **5.1. No es poden modificar dades directament en algunes vistes**
- Les vistes basades en múltiples taules o amb funcions agregades (`SUM`, `AVG`, etc.) poden ser només de lectura.
- Exemple d'una vista no modificable:
  ```sql
  CREATE VIEW total_vendes AS
  SELECT client_id, SUM(import) AS total FROM vendes GROUP BY client_id;
  ```

### **5.2. Depenen de l'existència de les taules**
- Si una taula referenciada per una vista s'elimina o es modifica, la vista pot deixar de funcionar.

---

## 6. Exemple complet

```sql
-- Creació d'una taula de clients
CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    actiu BOOLEAN DEFAULT 1
);

-- Creació d'una vista per veure només els clients actius
CREATE VIEW clients_actius AS
SELECT id, nom, email FROM clients WHERE actiu = 1;

-- Consultar la vista
SELECT * FROM clients_actius;

-- Modificar la vista per afegir més informació
CREATE OR REPLACE VIEW clients_actius AS
SELECT id, nom, email, actiu FROM clients;

-- Eliminar la vista si ja no és necessària
DROP VIEW IF EXISTS clients_actius;
```
