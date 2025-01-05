# Instrucció SQL WHERE

La clàusula **WHERE** en SQL és una instrucció del llenguatge de manipulació de dades (**DML**, Data Manipulation Language).

Tot i que no és obligatori incloure una clàusula **WHERE** en les instruccions DML, s’utilitza sovint per limitar el nombre de files afectades per una instrucció SQL (com **UPDATE** o **DELETE**) o retornades per una consulta (**SELECT**).

La clàusula **WHERE** serveix per aplicar condicions específiques als registres. Només retorna o afecta aquells registres que compleixen les condicions especificades.

La clàusula **WHERE** es pot utilitzar amb les instruccions **SELECT**, **UPDATE**, **DELETE**, entre d’altres.

---

## Sintaxi de l'instrucció WHERE en SQL

```sql
SELECT column1, column2, ... columnN  
FROM table_name  
WHERE [conditions]
```

La clàusula WHERE utilitza una selecció de condicions: 

| Operador | Significat                      |
|----------|---------------------------------|
| =        | Igual                          |
| >        | Major que                      |
| <        | Menor que                      |
| >=       | Major o igual que              |
| <=       | Menor o igual que              |
| <>       | Diferent de (no igual a)       |

A més, per combinar l'ús de diferents condicions s'han d'utilitzar els operadors lógics `AND` i `OR`.

```sql
SELECT column1, column2, ... columnN  
FROM table_name  
WHERE [condition1] AND [condition2] AND [condition3] AND ... [conditionN]
```

O una altra opció:

```sql
SELECT column1, column2, ... columnN  
FROM table_name  
WHERE ([condition1] AND [condition2]) OR [condition3]...
```

Explorem aquest tema amb més detall mitjançant exemples. Suposem que tenim una taula anomenada `customers` amb els següents registres:

| ID  | NAME               | AGE | ADDRESS      | SALARY |
|-----|--------------------|-----|--------------|--------|
| 1   | Himani Gupta       | 21  | Modinagar    | 22000  |
| 2   | Shiva Tiwari       | 22  | Bhopal       | 21000  |
| 3   | Ajeet Bhargav      | 45  | Meerut       | 65000  |
| 4   | Ritesh Yadav       | 36  | Azamgarh     | 26000  |
| 5   | Balwant Singh      | 45  | Varanasi     | 36000  |
| 6   | Mahesh Sharma      | 26  | Mathura      | 22000  |
| 7   | Rohit Shrivastav   | 19  | Ahemdabad    | 38000  |
| 8   | Neeru Sharma       | 29  | Pune         | 40000  |
| 9   | Aakash Yadav       | 32  | Mumbai       | 43500  |
| 10  | Sahil Sheikh       | 35  | Aurangabad   | 68800  |

### Exemple 1

Escriviu una consulta per filtrar els clients que tenen menys de 40 anys i que tenen un salari superior o igual a 38000: 

```sql
SELECT *
FROM customers  
WHERE Age < 40 AND Salary >= 38000
```

Obtindriem els següents resultats: 

| ID  | NAME               | AGE | ADDRESS      | SALARY |
|-----|--------------------|-----|--------------|--------|
| 7   | Rohit Shrivastav   | 19  | Ahemdabad    | 38000  |
| 8   | Neeru Sharma       | 29  | Pune         | 40000  |
| 9   | Aakash Yadav       | 32  | Mumbai       | 43500  |
| 10  | Sahil Sheikh       | 35  | Aurangabad   | 68800  |


### Exemple 2

Utilitzem la condició lògica `OR`.

Escriviu una consulta per filtrar els clients que o bé el seu nom comença per "A" o bé tenen un salari inferior o igual a 22000.

> [!NOTE]  
> Per filtrar els noms que comencen per "A" hem d'utilitzar la clàusula **LIKE**. La clàusula **LIKE** en SQL s'utilitza per cercar patrons específics en columnes de text (no és sensible a majúscules i minúscules en la majoria de SGBDs). El símbol **%** substitueix qualsevol nombre de caràcters (incloent cap) dins del patró. Per exemple:
> - `WHERE name LIKE 'A%'` retorna noms que comencen amb "A".
> - `WHERE name LIKE '%sh%'` retorna noms que contenen "sh".
> - `WHERE name LIKE '%A'` retorna noms que acaba amb "A".

Per tant, la consulta quedaria tal que: 

```sql
SELECT *
FROM customers  
WHERE Name LIKE 'A%' OR Salary <= 22000
```

| ID  | NAME               | AGE | ADDRESS      | SALARY |
|-----|--------------------|-----|--------------|--------|
| 1   | Himani Gupta       | 21  | Modinagar    | 22000  |
| 3   | Ajeet Bhargav      | 45  | Meerut       | 65000  |
| 6   | Mahesh Sharma      | 26  | Mathura      | 22000  |
| 9   | Aakash Yadav       | 32  | Mumbai       | 43500  |

### Exemple 3

Escriviu una consula per filtrar eles clients que viuen a Mumbai i Modinagar.

Una possible solució seria: 

```sql
SELECT *
FROM customers  
WHERE Address = 'Mumbai' OR Salary Address = 'Modinagar'
```

Però per no repetir dues vegades `Address`, podem utilitzar la clàusula `IN`. 

> [!TIP]
> La clàusula `IN` en SQL s'utilitza per especificar una llista de valors i verificar si una columna conté algun d’aquests valors. És una alternativa més compacta i llegible a múltiples condicions amb `OR`.

```sql
SELECT *
FROM customers  
WHERE Address IN ('Mumbai', 'Modinagar')
```

Obtenint d'aquesta manera els següents resultats: 

| ID  | NAME               | AGE | ADDRESS      | SALARY |
|-----|--------------------|-----|--------------|--------|
| 1   | Himani Gupta       | 21  | Modinagar    | 22000  |
| 9   | Aakash Yadav       | 32  | Mumbai       | 43500  |

