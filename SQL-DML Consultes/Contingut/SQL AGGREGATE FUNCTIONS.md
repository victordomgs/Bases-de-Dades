# SQL AGGREGATE FUNCTIONS

Les funcions agregades són funcions que processen grups de files per retornar un únic valor. 

- `COUNT()`: Retorna el nombre de files.
- `SUM()`: Retorna la suma dels valors d'una columna.
- `AVG()`: Retorna la mitjana dels valors d'una columna.
- `MAX()`: Retorna el valor màxim d'una columna.
- `MIN()`: Retorna el valor mínim d'una columna.

> [!IMPORTANT]  
> Es necessari utilitzar `GROUP BY` en les següents situacions:
> - Comptar registres per grup.
> - Filtrar resultats agrupats amb `HAVING`.
> - Trobar màxim o mínim per grup.

**Exemples d'ús de la clàusula `GROUP BY`**

Taula `sales`:

| ID  | CATEGORY    | AMOUNT |
|-----|-------------|--------|
| 1   | Electronics | 1000   |
| 2   | Furniture   | 500    |
| 3   | Electronics | 700    |
| 4   | Furniture   | 400    |
| 5   | Groceries   | 300    |
| 6   | Electronics | 1200   |

Si utilitzem una funció agregada sense `GROUP BY`, s'aplicarà a totes les files: 

```sql
SELECT SUM(AMOUNT) AS Total_Amount
FROM sales;
```

Resultat: 

| Total_Amount |
|--------------|
| 4100         |

Amb `GROUP BY`:

Si volem sumar `Amount` per categoria: 

```sql
SELECT CATEGORY, SUM(AMOUNT) AS Total_Amount
FROM sales
GROUP BY CATEGORY;
```

Resultat: 

| CATEGORY    | Total_Amount |
|-------------|--------------|
| Electronics | 2900         |
| Furniture   | 900          |
| Groceries   | 300          |

Aquí, `GROUP BY` agrupa les files per `Category`, i la funció agregada `SUM()` calcula la suma per a cada grup.

Volem comptar els productes que hi ha a la taula `products` de cada categoria: 

```sql
SELECT CATEGORY, COUNT(*) AS Product_Count
FROM sales
GROUP BY CATEGORY;
```

Volem trobar categories on la suma total és superior a 100: 

```sql
SELECT CATEGORY, SUM(AMOUNT) AS Total_Amount
FROM sales
GROUP BY CATEGORY
HAVING SUM(AMOUNT) > 1000;
```

Volem trobar la categoria amb la quantitat més alta de vendes: 

```sql
SELECT CATEGORY, MAX(AMOUNT) AS Max_Sale
FROM sales
GROUP BY CATEGORY;
```

**Exemples d'ús de la clàusula `HAVING`**

La clàusula `HAVING` filtra els resultats després de l'agrupació.

Imagina que, seguint amb la taula `sales` volem mostrar les categories amb una suma total superior a 500. 

```sql
SELECT CATEGORY, SUM(AMOUNT) AS Total_Amount
FROM sales
GROUP BY CATEGORY
HAVING SUM(AMOUNT) > 500;
```

Obtindrem com a resultat: 

| CATEGORY    | Total_Amount |
|-------------|--------------|
| Electronics | 2900         |
| Furniture   | 900          |

> [!IMPORTANT]  
> `GROUP BY` s'ha de especificar sempre **abans** de `HAVING`.
