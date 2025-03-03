# SQL Subconsultes

Les **subconsultes** (també anomenades subqueries o nested queries) són consultes SQL que es troben dins d'una altra consulta. Són molt útils per resoldre problemes complexos mitjançant l'ús de consultes encadenades.

**Característiques principals**

Una subconsulta és una consulta SQL dins d'una altra consulta. La subconsulta pot retornar un valor únic, una fila, o un conjunt de registres. 

Tenim subconsultes de dos tipus: 
- **Subconsultes simples:** Retornen un sol valor.
- **Subconsultes correlacionades:** Depenen de la consulta externa.

Aquestes subconsultes les podem utilitzar en: 
- La clàusula `WHERE`.
- La clàusula `FROM`.
- La clàusula `SELECT`.

La sintaxi bàsica d'una subconsulta a la clàusula `WHERE`seria: 

```sql
SELECT columna1
FROM taula1
WHERE columna2 = (SELECT columnaX FROM taula2 WHERE condició);
```

---

## Tipus de subconsultes

### Subconsultes simples

Són subconsultes independents que es resolen primer, i el resultat s'utilitza a la consulta externa.

Imaginem que tenim la següent taula: 

| ID  | NAME           | SALARY |
|-----|----------------|--------|
| 1   | Himani Gupta   | 22000  |
| 2   | Shiva Tiwari   | 21000  |
| 3   | Ajeet Bhargav  | 65000  |
| 4   | Neeru Sharma   | 40000  |

Volem trobar tots els treballadors que tenen un salari superior al salari mitjà:

```sql
SELECT NAME
FROM customers
WHERE SALARY > (SELECT AVG(SALARY) FROM customers);
```

> [!IMPORTANT]  
> En aquest cas hem d'estar segurs que la subconsulta retornarà només un valor, ja que si retornes més d'un la comparació `>`, no tindria sentit. 

Com a resultat obtindrem: 

| NAME           |
|----------------|
| Ajeet Bhargav  |
| Neeru Sharma   |

### Subconsultes correlacionades

Aquestes subconsultes depenen de la consulta externa i es processen per cada fila de la consulta principal.

Imaginem que tenim la següent taula: 

| ID  | NAME           | CITY       | SALARY |
|-----|----------------|------------|--------|
| 1   | Himani Gupta   | Modinagar  | 22000  |
| 2   | Shiva Tiwari   | Bhopal     | 21000  |
| 3   | Ajeet Bhargav  | Meerut     | 65000  |
| 4   | Neeru Sharma   | Modinagar  | 40000  |

Volem trobar els treballadors amb un salari superior al salari mitjà de la seva ciutat:

```sql
SELECT NAME, CITY, SALARY
FROM customers c1
WHERE SALARY > (SELECT AVG(SALARY)
                FROM customers c2
                WHERE c1.CITY = c2.CITY);
```

Aquesta consulta està comparant el valor individual del salari de cada treballador en la seva ciutat, amb el salari mitjà d'aquesta mateixa ciutat. 

Com a resultat obtindrem:

| NAME           | CITY       | SALARY |
|----------------|------------|--------|
| Neeru Sharma   | Modinagar  | 40000  |

### Subconsultes a la clàusula FROM

Aquestes subconsultes s’utilitzen per crear taules temporals o subtaules que la consulta principal pot utilitzar.

Suposem que tenim una taula `orders` amb informació sobre les comandes d’una botiga, i volem calcular la comanda més alta per a cada client.

| ORDER_ID | CUSTOMER_ID | AMOUNT |
|----------|-------------|--------|
| 101      | 1           | 200    |
| 102      | 2           | 450    |
| 103      | 1           | 300    |
| 104      | 3           | 500    |
| 105      | 2           | 400    |
| 106      | 1           | 150    |
| 107      | 3           | 700    |

Volem trobar el client amb l'import màxim de comanda:

```sql
SELECT CUSTOMER_ID, MAX_AMOUNT
FROM (
    SELECT CUSTOMER_ID, MAX(AMOUNT) AS MAX_AMOUNT
    FROM orders
    GROUP BY CUSTOMER_ID
) AS max_orders
ORDER BY MAX_AMOUNT DESC
LIMIT 1;
```

> [!TIP]
> La subconsulta a la clàusula `FROM` agrupa els registres per `CUSTOMER_ID` i calcula l'import màxim `MAX(AMOUNT)` de cada client.
> ```sql
> SELECT CUSTOMER_ID, MAX(AMOUNT) AS MAX_AMOUNT
> FROM orders
> GROUP BY CUSTOMER_ID
> ```
>
> La consulta externa extreu els resultats de la subconsulta i ordena els clientes per la seva comanda màxima en ordre descendent limitant els resultats a un únic registre.
> ```sql
> SELECT CUSTOMER_ID, MAX_AMOUNT
> FROM (...)
> ORDER BY MAX_AMOUNT DESC;
> ```

Com a resultat obtenim: 

| CUSTOMER_ID | MAX_AMOUNT |
|-------------|------------|
| 3           | 700        |
| 2           | 450        |
| 1           | 300        |

### Subconsultes a la clàusula SELECT

Aquestes subconsultes calculen valors que es mostren com a columnes.

Tornant a la taula de salaris. 

| ID  | NAME           | CITY       | SALARY |
|-----|----------------|------------|--------|
| 1   | Himani Gupta   | Modinagar  | 22000  |
| 2   | Shiva Tiwari   | Bhopal     | 21000  |
| 3   | Ajeet Bhargav  | Meerut     | 65000  |
| 4   | Neeru Sharma   | Modinagar  | 40000  |

Mostra els treballadors i el percentatge del seu salari respecte del salari total:

```sql
SELECT NAME,
       SALARY,
       (SALARY / (SELECT SUM(SALARY) FROM customers)) * 100 AS PercentSalary
FROM customers;
```

Resultat: 

| NAME           | SALARY | PercentSalary |
|----------------|--------|---------------|
| Himani Gupta   | 22000  | 20.37         |
| Shiva Tiwari   | 21000  | 19.44         |
| Ajeet Bhargav  | 65000  | 60.19         |
