# Instrucció SQL SELECT

L'instrucció **SELECT** és la comanda més utilitzada en el llenguatge SQL (Structured Query Language). Serveix per accedir als registres d'una o més taules o vistes d'una base de dades. També permet recuperar dades específiques que compleixin les condicions definides.

Mitjançant aquesta comanda, també podem accedir a un registre concret d'una columna específica d'una taula. La taula que emmagatzema els registres retornats per la instrucció SELECT s'anomena **taula de resultats**.

## Sintaxi de l'instrucció SELECT en SQL

```sql
SELECT Nom_Columna_1, Nom_Columna_2, ..., Nom_Columna_N FROM Nom_Taula;
```

En aquesta sintaxi:
- **Nom_Columna_1**, **Nom_Columna_2**, ..., **Nom_Columna_N** són els noms de les columnes de la taula de les quals volem llegir les dades.
- **Nom_Taula** és el nom de la taula on es troben les dades.

Si voleu accedir a totes les files i columnes d'una taula, podeu utilitzar la següent sintaxi amb l'asterisc `*`:

```sql
SELECT * FROM Nom_Taula;
```

Aquesta instrucció retornarà totes les dades disponibles de totes les columnes de la taula especificada.

### Exemple de l'ús de SELECT

Imagina que tenim una taula amb 6 columnes i 7 registres en total. La taula s'anomena `Student_Records`. 

Si nosaltres executem el següent codi: 

```sql
SELECT * FROM Student_Records;
```

Obtindrem **tots** els registres d'aquesta taula: 

| **Student_ID** | **First_Name** | **Address**   | **Age** | **Percentage** | **Grade** |
|-----------------|---------------|---------------|---------|----------------|-----------|
| 201             | Akash         | Delhi         | 18      | 89             | A2        |
| 202             | Bhavesh       | Kanpur        | 19      | 93             | A1        |
| 203             | Yash          | Delhi         | 20      | 89             | A2        |
| 204             | Bhavna        | Delhi         | 19      | 78             | B1        |
| 205             | Yatin         | Lucknow       | 20      | 75             | B1        |
| 206             | Ishika        | Ghaziabad     | 19      | 91             | C1        |
| 207             | Vivek         | Goa           | 20      | 80             | B2        |

D'altra banda, si nosaltres especifiquem unes columnes en particular, només obtindrem les columnes especificades:  

```sql
SELECT Student_Id, Age, Percentage, Grade FROM Employee;
```

Obtindrem:

| **Student_ID**  | **Age** | **Percentage** | **Grade** |
|-----------------|---------|----------------|-----------|
| 201             | 18      | 89             | A2        |
| 202             | 19      | 93             | A1        |
| 203             | 20      | 89             | A2        |
| 204             | 19      | 78             | B1        |
| 205             | 20      | 75             | B1        |
| 206             | 19      | 91             | C1        |
| 207             | 20      | 80             | B2        |


<table>
  <thead>
    <tr style="background-color: #00000;">
      <th><b>Student_ID</b></th>
      <th><b>Age</b></th>
      <th><b>Percentage</b></th>
      <th><b>Grade</b></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>201</td>
      <td>18</td>
      <td>89</td>
      <td>A2</td>
    </tr>
    <tr>
      <td>202</td>
      <td>19</td>
      <td>93</td>
      <td>A1</td>
    </tr>
    <tr>
      <td>203</td>
      <td>20</td>
      <td>89</td>
      <td>A2</td>
    </tr>
    <tr>
      <td>204</td>
      <td>19</td>
      <td>78</td>
      <td>B1</td>
    </tr>
    <tr>
      <td>205</td>
      <td>20</td>
      <td>75</td>
      <td>B1</td>
    </tr>
    <tr>
      <td>206</td>
      <td>19</td>
      <td>91</td>
      <td>C1</td>
    </tr>
    <tr>
      <td>207</td>
      <td>20</td>
      <td>80</td>
      <td>B2</td>
    </tr>
  </tbody>
</table>
