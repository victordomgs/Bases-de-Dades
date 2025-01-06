# SQL DATE FUNCTIONS

Les funcions de temps en SQL permeten treballar amb dates i hores. A continuació tenim alguns exemples de funcions de temps bastant utilitzades, tingues en compte, que existeixen moltes funcions de data i temps més.

---

## CURRENT_DATE()

Retorna la data actual del sistema (sense l'hora). 

```sql
SELECT CURRENT_DATE();
```

**Format de sortida**: `YYYY-MM-DD`

## NOW()

Retorna la data i hora actuals del sistema.

```sql
SELECT NOW();
```

**Format de sortida**: `YYYY-MM-DD HH:MM:SS`

## DATE_ADD()

Afegeix un interval de temps a una data determinada.

**Sintaxi:**

```sql
DATE_ADD(data, INTERVAL valor tipus)
```

**Exemple:** Afegeix 10 dies a la data actual.

```sql
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 10 DAY);
```

**Resultat:** `2025-01-15` (tenint en compte que estem a dia 2025-01-05)

## DATE_SUB()

Resta un interval de temps d'una data determinada.

**Sintaxi:**

```sql
DATE_SUB(data, INTERVAL valor tipus)
```

**Exemple:** Resta 2 mesos de la data actual.

```sql
SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 2 MONTH);
```

**Resultat:** `2024-11-05` (tenint en compte que estem a dia 2025-01-05)

## Altres funcions de data

- `DAY()`: Retorna el número del dia del mes de la data especificada.
- `WEEK()`: Retorna el número de setmana de l'any de la data especificada.
- `MONTH()`: Retorna el número del mes (1-12) de la data especificada.
- `YEAR()`: Retorna l'any de la data especificada.

**Exemples:**

```sql
SELECT DAY(CURRENT_DATE());
```

```sql
SELECT WEEK(CURRENT_DATE());
```

```sql
SELECT MONTH(CURRENT_DATE());
```

```sql
SELECT YEAR(CURRENT_DATE());
```
