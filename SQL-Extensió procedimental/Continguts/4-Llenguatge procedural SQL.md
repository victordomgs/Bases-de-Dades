# Funcions PLpg/SQL

PL/pgSQL (on "PL" significa Procedural Language) és un **llenguatge de programació procedimental** que s’integra perfectament amb SQL. Permet combinar instruccions SQL amb estructures pròpies d’un llenguatge de programació, com ara bucles, condicions i declaració de variables.

Aquest llenguatge complementa SQL aportant funcionalitats que són necessàries per a implementar processos més complexos, com ara la lògica de control de flux o la gestió d’estats mitjançant variables.

<br>

## Sintaxi bàsica

**PL/pgSQL** ja està activat per defecte a totes les bases de dades PostgreSQL modernes. Per tant, no és necessari instal·lar cap paquet.

Per escriure una funció en PL/pgSQL, podem utilitzar una estructura com la següent:

```sql
CREATE FUNCTION HolaMon() RETURNS text AS $$
BEGIN
  RETURN 'Hola món!';
END;
$$ LANGUAGE plpgsql;
```

| Element                     | Descripció                                                       |
|----------------------------|-------------------------------------------------------------------|
| `CREATE FUNCTION`          | Defineix una nova funció.                                        |
| `HolaMon()`                | És el nom de la funció.                                          |
| `RETURNS text`             | Indica el tipus de valor que retorna la funció.                  |
| `AS $$ ... $$`             | Delimita el bloc de codi que forma el cos de la funció.          |
| `LANGUAGE plpgsql`         | Especifica que la funció utilitza el llenguatge PL/pgSQL.        |

### Estructura del bloc PL/pgSQL

El cos de la funció es defineix dins d’un bloc `BEGIN ... END`, que pot contenir una o més sentències SQL o PL/pgSQL.

També podem declarar variables locals amb la secció `DECLARE`, que va just abans del `BEGIN`:

```sql
CREATE FUNCTION HolaMon() RETURNS text AS $$
DECLARE
  result text := 'Hola, PostgreSQL!';
BEGIN
  RETURN result;
END;
$$ LANGUAGE plpgsql;
```

<br>

## Paràmetres d'entrada

Les funcions en PL/pgSQL poden rebre **paràmetres d'entrada**, que permeten passar valors a la funció quan es crida.

```sql
CREATE FUNCTION saluda(nom text) RETURNS text AS $$
BEGIN
  RETURN 'Hola, ' || nom || '!';
END;
$$ LANGUAGE plpgsql;
```

En aquest cas, la funció `saluda` rep un paràmetre anomenat `nom` de tipus `text` i retorna una salutació personalitzada.

<br>

## Ús de `RETURNING` dins funcions PL/pgSQL

Quan fem operacions `INSERT`, `UPDATE` o `DELETE`, podem utilitzar la clàusula `RETURNING` per **recuperar valors de les files afectades**. Aquesta funcionalitat és molt útil dins de funcions, ja que permet retornar directament informació modificada.

Suposem que tenim una taula `empleats(id, nom, sou)` i volem fer una funció que actualitzi el sou d’un empleat i ens retorni el nou sou.

```sql
CREATE FUNCTION actualitza_sou(emp_id integer, nou_sou numeric) RETURNS numeric AS $$
DECLARE
  sou_final numeric;
BEGIN
  UPDATE empleats
  SET sou = nou_sou
  WHERE id = emp_id
  RETURNING sou INTO sou_final;

  RETURN sou_final;
END;
$$ LANGUAGE plpgsql;
```

| Element                   | Descripció                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| `emp_id integer`          | Paràmetre d’entrada: ID de l’empleat.                                      |
| `nou_sou numeric`         | Paràmetre d’entrada: nou sou a assignar.                                   |
| `sou_final numeric`       | Variable local per guardar el sou actualitzat.                             |
| `UPDATE ... RETURNING sou`| Actualitza el sou i retorna el valor actualitzat de la columna `sou`.      |
| `INTO sou_final`          | Assigna el valor retornat per `RETURNING` a la variable `sou_final`.       |
| `RETURN sou_final`        | Retorna el resultat final com a resposta de la funció.                     |

<br>

## ÚS de `SELECT ... INTO` 

En PL/pgSQL, podem fer que una funció retorni **una fila completa** (tipus compost) d'una taula. Per fer-ho, utilitzem `SELECT ... INTO` per guardar els valors de la fila dins d’una variable de tipus `RECORD` o d’un tipus de taula específic.

Suposem que tenim una taula `empleats(id, nom, sou)` i volem fer una funció que ens retorni totes les dades d’un empleat a partir del seu ID:

```sql
CREATE FUNCTION get_empleat(emp_id integer) RETURNS RECORD AS $$
DECLARE
  emp_info RECORD;
BEGIN
  SELECT * INTO emp_info
  FROM empleats
  WHERE id = emp_id;

  RETURN emp_info;
END;
$$ LANGUAGE plpgsql;
```

```sql
SELECT * FROM get_empleat('14');
```

Com a resultat obtenim: 

```
   id  |  nom  |  sou 
-------+-------+-------
   14  | Maria |  1500 
(1 row)
```

<br>

## Paràmetres de sortida

Els **paràmetres de sortida** (`OUT`) permeten retornar diversos valors des d’una funció de manera clara i estructurada, sense necessitat d’utilitzar tipus compostos ni retornar `RECORD`.

Són molt útils quan volem retornar **múltiples resultats separats** (com valors calculats) en una sola crida.

```sql
CREATE FUNCTION calc_rect(base numeric, height numeric, 
                          OUT area numeric, OUT perimeter numeric)
AS $$
BEGIN
  SELECT base * height, 2 * (base + height) INTO area, perimeter;
END;
$$ LANGUAGE plpgsql;
```

| Element                                 | Descripció                                                             |
|-----------------------------------------|-------------------------------------------------------------------------|
| `OUT area numeric`, `OUT perimeter numeric` | Paràmetres de sortida: es poden omplir dins el cos de la funció.       |
| `SELECT ... INTO area, perimeter`       | Assigna valors a les variables de sortida.                              |

Podem cridar a la funció: 

```sql
SELECT * FROM calc_rect(2, 4);
```

Com a resultat obtenim: 

```
   area  |  perimeter  
---------+------------
    8    |     12
(1 row)
```
