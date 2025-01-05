# SQL JOINS

Els **JOINS** en SQL s’utilitzen per combinar dades de dues o més taules basant-se en una condició comuna entre elles. 

Es poden definir un total de cinc tipus diferents de JOINS: 
- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL OUTER JOIN`
- `CROSS JOIN`

> [!NOTE]  
> Tingueu en compte que `LEFT OUTER JOIN` es lo mateix que `LEFT JOIN`, `RIGHT OUTER JOIN` és lo mateix que `RIGHT JOIN` i `INNER JOIN` és lo mateix que `JOIN`.

Imaginem que tenim dues taules: 

Taula `customers`:

| ID  | NAME           | CITY       |
|-----|----------------|------------|
| 1   | Himani Gupta   | Modinagar  |
| 2   | Shiva Tiwari   | Bhopal     |
| 3   | Ajeet Bhargav  | Meerut     |

Taula `orders`:

| ORDER_ID | CUSTOMER_ID | PRODUCT      |
|----------|-------------|--------------|
| 101      | 1           | Laptop       |
| 102      | 3           | Smartphone   |
| 103      | 4           | Tablet       |

---

## INNER JOIN (o JOIN)

Només retorna les files que compleixen la condició en ambdues taules. Es pot expressar a través d'un diagrama de Venn: 

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/images/innerjoin.png" alt="INNER JOIN" width="260" height="auto"/>
  </div>

Utilitzant les dues taules anteriors i la següent sentencia SQL: 

```sql
SELECT customers.NAME, orders.PRODUCT
FROM customers
INNER JOIN orders
ON customers.ID = orders.CUSTOMER_ID;
```

Obtindriem el següent resultat: 

| NAME           | PRODUCT      |
|----------------|--------------|
| Himani Gupta   | Laptop       |
| Ajeet Bhargav  | Smartphone   |

## LEFT JOIN (o LEFT OUTER JOIN)

Retorna totes les files de la taula esquerra i les que coincideixen de la taula dreta. Si no hi ha coincidència, mostra `NULL` per les columnes de la taula dreta. Es pot expressar a través d'un diagrama de Venn: 

  <div style="text-align: center;">
    <img src="" alt="INNER JOIN" width="260" height="auto"/>
  </div>

Utilitzant les dues taules anteriors i la següent sentencia SQL: 

```sql
SELECT customers.NAME, orders.PRODUCT
FROM customers
LEFT JOIN orders
ON customers.ID = orders.CUSTOMER_ID;
```

Obtindriem el següent resultat: 

| NAME           | PRODUCT      |
|----------------|--------------|
| Himani Gupta   | Laptop       |
| Shiva Tiwari   | NULL         |
| Ajeet Bhargav  | Smartphone   |

## RIGHT JOIN (o RIGHT OUTER JOIN)

És similar al **LEFT JOIN**, però retorna totes les files de la taula dreta i només les que coincideixen de la taula esquerra. Es pot expressar a través d'un diagrama de Venn: 

  <div style="text-align: center;">
    <img src="" alt="INNER JOIN" width="260" height="auto"/>
  </div>

Utilitzant les dues taules anteriors i la següent sentencia SQL: 

```sql
SELECT customers.NAME, orders.PRODUCT
FROM customers
RIGHT JOIN orders
ON customers.ID = orders.CUSTOMER_ID;
```

Obtindriem el següent resultat:

| NAME           | PRODUCT      |
|----------------|--------------|
| Himani Gupta   | Laptop       |
| Ajeet Bhargav  | Smartphone   |
| NULL           | Tablet       |

## FULL OUTER JOIN

Retorna totes les files de les dues taules, i si no coincideixen, omple amb `NULL`. Es pot expressar a través d'un diagrama de Venn: 

  <div style="text-align: center;">
    <img src="" alt="INNER JOIN" width="260" height="auto"/>
  </div>

Utilitzant les dues taules anteriors i la següent sentencia SQL: 

```sql
SELECT customers.NAME, orders.PRODUCT
FROM customers
FULL OUTER JOIN orders
ON customers.ID = orders.CUSTOMER_ID;
```

Obtindriem el següent resultat:

| NAME           | PRODUCT      |
|----------------|--------------|
| Himani Gupta   | Laptop       |
| Shiva Tiwari   | NULL         |
| Ajeet Bhargav  | Smartphone   |
| NULL           | Tablet       |

## CROSS JOIN

Combina totes les files de la primera taula amb totes les de la segona, creant el producte cartesià. Es pot expressar a través d'un diagrama de Venn: 

  <div style="text-align: center;">
    <img src="" alt="INNER JOIN" width="260" height="auto"/>
  </div>

Utilitzant les dues taules anteriors i la següent sentencia SQL: 

```sql
SELECT customers.NAME, orders.PRODUCT
FROM customers
CROSS JOIN orders;
```

Obtindriem el següent resultat:

| NAME           | PRODUCT      |
|----------------|--------------|
| Himani Gupta   | Laptop       |
| Himani Gupta   | Smartphone   |
| Himani Gupta   | Tablet       |
| Shiva Tiwari   | Laptop       |
| Shiva Tiwari   | Smartphone   |
| Shiva Tiwari   | Tablet       |
| Ajeet Bhargav  | Laptop       |
| Ajeet Bhargav  | Smartphone   |
| Ajeet Bhargav  | Tablet       |
