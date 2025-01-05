# Instrucció SQL ORDER BY

Quan volem ordenar els registres basant-nos en les columnes emmagatzemades a les taules d’una base de dades SQL, fem servir la clàusula **ORDER BY**.

La clàusula **ORDER BY** en SQL ens permet ordenar els registres segons una columna específica d’una taula. Això vol dir que tots els valors emmagatzemats en la columna sobre la qual apliquem la clàusula ORDER BY seran ordenats, i els valors corresponents de les altres columnes es mostraran seguint la seqüència definida en aquest procés.

Amb la clàusula **ORDER BY**, podem ordenar els registres en ordre ascendent o descendent, segons les nostres necessitats.

- Si utilitzem la paraula clau **ASC**, els registres s’ordenaran en **ordre ascendent**.
- Si utilitzem la paraula clau **DESC**, s’ordenaran en **ordre descendent**.

> [!IMPORTANT] 
> Si no especifiquem cap paraula clau després de la columna sobre la qual volem ordenar els registres, l’ordre per defecte serà ascendent.

Abans d’escriure les consultes per ordenar els registres, vegem la **sintaxi**.

Sintaxi per ordenar els registres en ordre ascendent:

```sql
SELECT ColumnName1,...,ColumnNameN FROM TableName ORDER BY ColumnName1 ASC;
```

Sintaxi per ordenar els registres en ordre descendent:

```sql
SELECT ColumnName1,...,ColumnNameN FROM TableName ORDER BY ColumnName1 DESC;
```

Sintaxi per ordenar els registres en ordre ascendent sense utilitzar la paraula clau ASC:

```sql
SELECT ColumnName1,...,ColumnNameN FROM TableName ORDER BY ColumnName1; 
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

### Exemple 1: 

Escriviu una consulta per ordenar els registres en **ordre ascendent** dels noms de clients emmagatzemats a la taula de `customers`.

```sql
SELECT *FROM customers ORDER BY Name ASC;  
```

Aquí, en una consulta `SELECT`, s'aplica una clàusula `ORDER BY` a la columna `Name` per ordenar els registres. La paraula clau `ASC` ordenarà els registres en ordre ascendent. 

> [!IMPORTANT]  
> En el cas de ser una columna de tipus `varchar()`, els registres s'ordenen per ordre alfabètic.
> 
> També funcionaria:
> ```sql
> SELECT *FROM customers ORDER BY Name;
> ```

Obtindreu la següent sortida:

| ID  | NAME               | AGE | ADDRESS      | SALARY |
|-----|--------------------|-----|--------------|--------|
| 9   | Aakash Yadav       | 32  | Mumbai       | 43500  |
| 3   | Ajeet Bhargav      | 45  | Meerut       | 65000  |
| 5   | Balwant Singh      | 45  | Varanasi     | 36000  |
| 1   | Himani Gupta       | 21  | Modinagar    | 22000  |
| 6   | Mahesh Sharma      | 26  | Mathura      | 22000  |
| 8   | Neeru Sharma       | 29  | Pune         | 40000  |
| 4   | Ritesh Yadav       | 36  | Azamgarh     | 26000  |
| 7   | Rohit Shrivastav   | 19  | Ahemdabad    | 38000  |
| 10  | Sahil Sheikh       | 35  | Aurangabad   | 68800  |
| 2   | Shiva Tiwari       | 22  | Bhopal       | 21000  |

