# Transaccions en SQL

## Què és una transacció?

Una **transacció** és una unitat d'execució de treball en una base de dades que es tracta com una única operació lògica. Les transaccions garanteixen que un conjunt d'operacions en la base de dades es realitzin de manera completa i consistent.

Les transaccions segueixen les propietats **ACID**:

1. **Atomicitat**: Una transacció es realitza completament o no es realitza en absolut.
2. **Consistència**: La base de dades ha d'estar en un estat consistent abans i després de la transacció.
3. **Aïllament**: Les operacions de diferents transaccions no interfereixen entre elles.
4. **Durabilitat**: Els canvis realitzats per una transacció confirmada es conserven fins i tot en cas de fallades del sistema.

---

## Inici i finalització de transaccions

Les transaccions en SQL es poden gestionar amb els següents comandos:

### Iniciar una transacció
```sql
START TRANSACTION;
```
Aquest comando indica l'inici d'una transacció.

### Confirmar una transacció
```sql
COMMIT;
```
Aquest comando confirma la transacció i fa permanents els canvis a la base de dades.

### Desfer una transacció
```sql
ROLLBACK;
```
Aquest comando desfà tots els canvis realitzats des de l'inici de la transacció.

---

## Exemples pràctics

### Exemple 1: Transacció senzilla
```sql
START TRANSACTION;

UPDATE comptes SET saldo = saldo - 100 WHERE id = 1;
UPDATE comptes SET saldo = saldo + 100 WHERE id = 2;

COMMIT;
```
En aquest exemple, es transfereixen 100 unitats del compte 1 al compte 2. La transacció es confirma amb `COMMIT`.

### Exemple 2: Desfer canvis
```sql
START TRANSACTION;

UPDATE productes SET estoc = estoc - 10 WHERE id = 5;

ROLLBACK;
```
Aquest exemple desfà l'actualització de l'estoc del producte amb id 5.

---

## Control de transaccions automàtiques

### Mode autocommit
Molts sistemes de bases de dades utilitzen el mode **autocommit** per defecte. Això significa que cada instrucció SQL es tracta com una transacció independent.

Per desactivar l'autocommit:
```sql
SET autocommit = 0;
```
Per activar-lo de nou:
```sql
SET autocommit = 1;
```

---

## Punts de recuperació

SQL permet establir **punts de recuperació** (savepoints) dins d'una transacció per tal de desfer només una part dels canvis:

### Crear un punt de recuperació
```sql
SAVEPOINT punt1;
```

### Tornar a un punt de recuperació
```sql
ROLLBACK TO punt1;
```

### Eliminar un punt de recuperació
```sql
RELEASE SAVEPOINT punt1;
```

---

## Errors comuns

- **Oblidar el `COMMIT`:** Si no es confirma una transacció, els canvis no es reflectiran a la base de dades.
- **Conflictes d'aïllament:** Pot ocórrer quan dues transaccions intenten modificar les mateixes dades simultàniament. Això es pot gestionar amb diferents nivells d'aïllament.

---

## Nivells d'aïllament

SQL ofereix diferents nivells d'aïllament per controlar el comportament de les transaccions en entorns amb concurrència:

1. **Read Uncommitted:** Permet llegir dades no confirmades.
2. **Read Committed:** Només permet llegir dades confirmades.
3. **Repeatable Read:** Garanteix que les dades llegides no canviaran durant la transacció.
4. **Serializable:** El nivell més alt d'aïllament; garanteix que les transaccions es processen seqüencialment.

Configurar el nivell d'aïllament:
```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```
