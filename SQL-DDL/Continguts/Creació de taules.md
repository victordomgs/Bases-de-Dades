# Creació de Taules

## 1. Sintaxi bàsica

La sintaxi general per crear una taula és:

```sql
CREATE TABLE nom_de_la_taula (
    columna1 TIPUS_DE_DADA CONSTRAINTS,
    columna2 TIPUS_DE_DADA CONSTRAINTS,
    ...
);
```

Exemple:

```sql
CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefon VARCHAR(15),
    data_registre TIMESTAMP DEFAULT TIMESTAMP
);
```

Aquest exemple defineix una taula `clients` amb:
- Un identificador únic `id` amb autoincrement.
- Un camp `nom` obligatori (`NOT NULL`).
- Un camp `email` únic per evitar duplicats.
- Un camp `telefon` opcional.
- Un camp `data_registre` amb valor per defecte a la data actual.

---

## 2. Tipus de dades

Seleccionar el tipus de dada correcte és essencial per a un bon disseny de taula. Alguns dels tipus més comuns són:

| Tipus de Dada | Descripció |
|--------------|------------|
| `INT` | Enter, útil per a identificadors |
| `VARCHAR(n)` | Text de longitud variable `n` |
| `TEXT` | Text llarg, per a descripcions |
| `DATE` | Data en format `AAAA-MM-DD` |
| `DATETIME` | Data i hora |
| `BOOLEAN` | Valors `TRUE` o `FALSE` |
| `DECIMAL(m, d)` | Número decimal amb `m` dígits i `d` decimals |

**Exemple d'ús:**
```sql
CREATE TABLE productes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    preu DECIMAL(10,2) CHECK (preu > 0),
    stock INT DEFAULT 0
);
```

Aquest disseny assegura que el `preu` sempre sigui positiu i estableix un valor per defecte de `0` per `stock`.

---

## 3. Restriccions (*Constraints*)

Les restriccions ajuden a garantir la integritat de les dades.

| Restriccions | Descripció |
|---------------|------------|
| `PRIMARY KEY` | Identifica un registre únic en una taula |
| `FOREIGN KEY` | Crea una relació entre dues taules |
| `UNIQUE` | Garanteix que els valors d'una columna siguin únics |
| `NOT NULL` | Evita valors nuls |
| `CHECK` | Defineix una condició per a una columna |
| `DEFAULT` | Assigna un valor per defecte |
| `AUTO_INCREMENT` | Incrementa automàticament una columna (per a claus primàries numèriques) |

**Exemple amb diverses restriccions:**

```sql
CREATE TABLE comandes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    total DECIMAL(10,2) CHECK (total >= 0),
    data_comanda DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);
```

Aquesta estructura:
- Enllaça `client_id` amb `clients(id)` com a clau forana.
- Assegura que `total` no sigui negatiu.
- Assigna la data i hora actual per defecte a `data_comanda`.

---

## 4. Bones pràctiques en la creació de taules

### **4.1. Utilitzar noms descriptius**
- Evita noms genèrics com `taula1` o `dades`.
- Usa noms en singular (`usuari` en lloc de `usuaris` si cada fila representa un usuari).

### **4.2. Evitar tipus de dades innecessàriament grans**
- No usar `TEXT` si `VARCHAR(255)` és suficient.
- Evita `BIGINT` si `INT` cobreix les necessitats.

### **4.3. Definir claus primàries i foranas sempre que sigui possible**
- Les claus primàries ajuden a l'indexació i eficiència de cerques.
- Les claus foranes mantenen la coherència entre taules.

### **4.4. Utilitzar valors per defecte i restriccions per evitar errors**
- Assignar `DEFAULT` quan tingui sentit.
- Aplicar `NOT NULL` quan la dada sigui obligatòria.

---

## 5. Exemple complet

```sql
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE productes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    preu DECIMAL(10,2) CHECK (preu > 0),
    stock INT DEFAULT 0,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categories(id)
);
```

Aquest disseny:
- Garanteix que cada categoria tingui un nom únic.
- Enllaça `productes` amb `categories` mitjançant `categoria_id`.
- Limita `preu` perquè només accepti valors positius.
