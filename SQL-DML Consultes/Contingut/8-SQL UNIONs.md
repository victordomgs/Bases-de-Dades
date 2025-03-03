# SQL UNIONs

L'operador `UNION` en SQL s'utilitza per combinar els resultats de dues o més consultes en un únic conjunt de resultats. És útil quan volem obtenir dades de diverses taules o consultes que tenen una estructura similar.

**Característiques de UNION:**

1. **Elimina duplicats:** Per defecte, `UNION` elimina les files duplicades del conjunt de resultats.
2. **Mateix nombre i tipus de columnes:** Les consultes que es combinen amb `UNION` han de tenir el mateix nombre de columnes i tipus de dades compatibles en cadascuna.
3. **Ordre de les columnes:** L'ordre de les columnes ha de coincidir entre les consultes.
4. **`ORDER BY` omés en l'última consulta:** Només pots utilitzar la clàusula `ORDER BY` al final de l'última consulta per ordenar els resultats combinats.

La sintaxis bàsica per tant seria: 

```sql
SELECT columna1, columna2
FROM taula1
UNION
SELECT columna1, columna2
FROM taula2;
```

---

## Exemples pràctics

### Combinar dades de dues taules

Suposem que tenim dues taules, `students_2024` i `students_2025`, i volem obtenir una llista combinada de tots els estudiants.

Taula `students_2024`:

| ID  | NAME          |
|-----|---------------|
| 1   | Himani Gupta  |
| 2   | Shiva Tiwari  |
| 3   | Ajeet Bhargav |

Taula `students_2025`:

| ID  | NAME          |
|-----|---------------|
| 4   | Ritesh Yadav  |
| 5   | Neeru Sharma  |
| 2   | Shiva Tiwari  |

Si apliquem la següent consulta: 

```sql
SELECT ID, NAME
FROM students_2024
UNION
SELECT ID, NAME
FROM students_2025;
```

Obtindrem la unió de les dues taules: 

| ID  | NAME          |
|-----|---------------|
| 1   | Himani Gupta  |
| 2   | Shiva Tiwari  |
| 3   | Ajeet Bhargav |
| 4   | Ritesh Yadav  |
| 5   | Neeru Sharma  |

> [!NOTE]  
> La clàusula UNION elimina els duplicats automàticament. Per exemple, l'estudiant `Shiva Tiwari` tot i estar en les dues taules, només apareix una vegada en els resultats.

Si volguessim mantenir els duplicats, utilitzariem la clàusula `UNION ALL`: 

```sql
SELECT ID, NAME
FROM students_2024
UNION ALL
SELECT ID, NAME
FROM students_2025;
```

Com a resultat: 

| ID  | NAME          |
|-----|---------------|
| 1   | Himani Gupta  |
| 2   | Shiva Tiwari  |
| 3   | Ajeet Bhargav |
| 4   | Ritesh Yadav  |
| 5   | Neeru Sharma  |
| 2   | Shiva Tiwari  |

### Ordenar resultats amb UNION

Quan volem ordenar els resultats combinats, utilitzem `ORDER BY` al final.

Utilitzant les dues taules anteriors: `students_2024` i `students_2025`. Imaginem que volem ordenar els estudiants per ordre alfabètic del seu nom. 

```sql
SELECT ID, NAME
FROM students_2024
UNION
SELECT ID, NAME
FROM students_2025
ORDER BY NAME ASC;
```

Com a resultat obtindrem: 

| ID  | NAME          |
|-----|---------------|
| 3   | Ajeet Bhargav |
| 1   | Himani Gupta  |
| 5   | Mahesh Sharma |
| 2   | Shiva Tiwari  |


