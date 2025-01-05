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

### Exemple 1
