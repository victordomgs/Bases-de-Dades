# La sentència `DELETE` en SQL

La sentència `DELETE` s'utilitza per eliminar registres d'una taula en una base de dades. Aquesta operació es realitza basant-se en una condició especificada amb la clausula `WHERE`. Sense aquesta condició, tots els registres de la taula seran eliminats.

## Sintaxi bàsica

```sql
DELETE FROM nom_taula
WHERE condició;
```

### Explicació dels elements:
- **`nom_taula`**: Nom de la taula d'on es volen eliminar els registres.
- **`WHERE`**: Clausula opcional que especifica quins registres s'eliminaran. Si no s'inclou, s'eliminaran tots els registres de la taula.

## Exemple senzill

Suposem que tenim una taula anomenada `Empleats` amb la següent estructura:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 1    | Anna        | Vendes      | 3000  |
| 2    | Joan        | IT          | 3500  |
| 3    | Maria       | Vendes      | 2800  |

### Eliminar un registre específic
Per eliminar l'empleat amb nom "Maria":

```sql
DELETE FROM Empleats
WHERE Nom = 'Maria';
```

Resultat:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 1    | Anna        | Vendes      | 3000  |
| 2    | Joan        | IT          | 3500  |

### Eliminar registres basats en una condició
Si volem eliminar tots els empleats del departament de `Vendes`:

```sql
DELETE FROM Empleats
WHERE Departament = 'Vendes';
```

Resultat:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
| 2    | Joan        | IT          | 3500  |

## Eliminar tots els registres
Si volem buidar completament la taula, ho podem fer ometent la clausula `WHERE`. Això eliminarà totes les files:

```sql
DELETE FROM Empleats;
```

Després d'executar aquesta sentència, la taula quedarà buida:

| ID  | Nom         | Departament | Sou  |
|------|-------------|-------------|-------|
|      |             |             |       |

## Recomanacions importants

> [!IMPORTANT]  
> **Utilitza sempre la clausula `WHERE` amb cura**: Si no especifiques una condició, tots els registres de la taula seran eliminats.
> 
> **Prova amb una consulta `SELECT` prèvia**: Utilitza una consulta `SELECT` amb la mateixa condició per assegurar-te que eliminaràs els registres correctes.
> 
> **Coneix la diferència amb `TRUNCATE`**: La sentència `TRUNCATE` també elimina tots els registres d'una taula, però és més ràpida i no permet especificar condicions. També reinicia els valors autoincrementats.

## Exemple amb subconsulta
També podem utilitzar subconsultes dins d'una sentència `DELETE`. Suposem que volem eliminar tots els empleats amb un sou inferior al sou mitjà de la taula:

```sql
DELETE FROM Empleats
WHERE Sou < (SELECT AVG(Sou) FROM Empleats);
```

Aquesta sentència eliminarà els empleats que tenen un sou inferior a la mitjana.
