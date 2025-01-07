# La sentència `UPDATE` en SQL

La sentència `UPDATE` s'utilitza per modificar els registres existents en una taula d'una base de dades. Amb aquesta instrucció, podem canviar el valor d'una o més columnes en una o diverses files que compleixin una condició determinada.

## Sintaxi bàsica

```sql
UPDATE nom_taula
SET columna1 = valor1, columna2 = valor2, ...
WHERE condició;
```

### Explicació dels elements:
- **`nom_taula`**: Nom de la taula que volem modificar.
- **`SET`**: Clausula que indica les columnes i els nous valors que volem assignar.
- **`columna1 = valor1`**: Assigna un nou valor a una columna especificada.
- **`WHERE`**: Opcional, especifica una condició per determinar quines files seran actualitzades. Si no s'especifica, totes les files seran modificades.

## Exemple senzill

Suposem que tenim una taula anomenada `Empleats` amb la següent estructura:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 1    | Anna        | Vendes      | 3000  |
| 2    | Joan        | IT          | 3500  |
| 3    | Maria       | Vendes      | 2800  |

### Actualitzar el sou d'un empleat
Si volem augmentar el sou de Joan a 4000, farem:

```sql
UPDATE Empleats
SET Sou = 4000
WHERE Nom = 'Joan';
```

Resultat:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 1    | Anna        | Vendes      | 3000  |
| 2    | Joan        | IT          | 4000  |
| 3    | Maria       | Vendes      | 2800  |

### Actualitzar diverses columnes
També podem modificar més d'una columna alhora. Per exemple, canviem el departament de Maria a `IT` i augmentem el seu sou a 3200:

```sql
UPDATE Empleats
SET Departament = 'IT', Sou = 3200
WHERE Nom = 'Maria';
```

Resultat:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 1    | Anna        | Vendes      | 3000  |
| 2    | Joan        | IT          | 4000  |
| 3    | Maria       | IT          | 3200  |

## Actualitzacions massives
Si no s'utilitza la clausula `WHERE`, totes les files de la taula seran modificades. Per exemple:

```sql
UPDATE Empleats
SET Departament = 'General';
```

Resultat:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 1    | Anna        | General     | 3000  |
| 2    | Joan        | General     | 4000  |
| 3    | Maria       | General     | 3200  |

## Recomanacions importants

1. **Usar sempre la clausula `WHERE` amb cura**: Sense una condició específica, es poden modificar totes les files de la taula, provocant resultats inesperats.
3. **Provar amb una consulta `SELECT` primer**: Executar una consulta `SELECT` amb la mateixa condició que el `WHERE` per verificar quines files seran afectades.

## Exemple amb subconsulta
També es poden utilitzar subconsultes per calcular els valors a assignar. Suposem que volem augmentar el sou de tots els empleats al mateix nivell que el sou més alt de la taula:

```sql
UPDATE Empleats
SET Sou = (SELECT MAX(Sou) FROM Empleats);
```

Resultat:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 1    | Anna        | General     | 4000  |
| 2    | Joan        | General     | 4000  |
| 3    | Maria       | General     | 4000  |
