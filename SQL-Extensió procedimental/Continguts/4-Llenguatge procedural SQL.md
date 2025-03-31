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
CREATE FUNCTION actualitza_poblacio(city_id integer, nova_poblacio integer) RETURNS integer AS $$
DECLARE
  poblacio_final integer;
BEGIN
  UPDATE city
  SET population = nova_poblacio
  WHERE id = city_id
  RETURNING population INTO poblacio_final;

  RETURN poblacio_final;
END;
$$ LANGUAGE plpgsql;
```

| Element                          | Descripció                                                                                   |
|----------------------------------|-----------------------------------------------------------------------------------------------|
| `city_id integer`                | Paràmetre d’entrada: ID de la ciutat a la taula `City`.                                       |
| `nova_poblacio integer`         | Paràmetre d’entrada: nova població que es vol assignar a la ciutat.                          |
| `poblacio_final integer`        | Variable local per guardar el valor actualitzat de la població.                              |
| `UPDATE ... RETURNING population`| Actualitza el camp `Population` de la ciutat indicada i retorna el nou valor actualitzat.    |
| `INTO poblacio_final`           | Assigna el valor retornat per `RETURNING` a la variable local `poblacio_final`.              |
| `RETURN poblacio_final`         | Retorna el valor final de la població un cop actualitzada, com a resultat de la funció.      |

<br>

## ÚS de `SELECT ... INTO` 

En PL/pgSQL, podem fer que una funció retorni **una fila completa** (tipus compost) d'una taula. Per fer-ho, utilitzem `SELECT ... INTO` per guardar els valors de la fila dins d’una variable de tipus `RECORD` o d’un tipus de taula específic.

Suposem que tenim una taula `empleats(id, nom, sou)` i volem fer una funció que ens retorni totes les dades d’un empleat a partir del seu ID:

```sql
CREATE FUNCTION get_ciutat(city_id integer) RETURNS RECORD AS $$
DECLARE
  ciutat_info RECORD;
BEGIN
  SELECT * INTO ciutat_info
  FROM city
  WHERE id = city_id;

  RETURN ciutat_info;
END;
$$ LANGUAGE plpgsql;
```

```sql
SELECT get_ciutat(14);
```

Com a resultat obtenim: 

```
 id |    name    | countrycode |     district    | population 
----+------------+-------------+-----------------+-----------
 14 |  Nijmegen  |    NLD      |    Gelderland   |  152463
(1 row)
```

<br>

## Paràmetres de sortida

Els **paràmetres de sortida** (`OUT`) permeten retornar diversos valors des d’una funció de manera clara i estructurada, sense necessitat d’utilitzar tipus compostos ni retornar `RECORD`.

Són molt útils quan volem retornar **múltiples resultats separats** (com valors calculats) en una sola crida.

```sql
CREATE FUNCTION calc_rect(base numeric, height numeric, OUT area numeric, OUT perimeter numeric) AS $$
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
SELECT calc_rect(2, 4);
```

Com a resultat obtenim: 

```
   area  |  perimeter  
---------+------------
    8    |     12
(1 row)
```

<br>

## Tractament d'excepcions

El **tractament d’excepcions** consisteix en capturar i gestionar els **errors que poden ocórrer** durant l’execució d’un bloc de codi SQL dins una funció o procediment. Això permet **evitar que el programa falli completament** i oferir una resposta controlada davant d’una situació inesperada, com per exemple: valors inexistents, divisions per zero, duplicats, errors de tipus, etc.

En PL/pgSQL (PostgreSQL), això es fa amb la clàusula `EXCEPTION`.

Imaginem que tenim la següent funció que retorna informació d'una ciutat pel seu `ID`. Si el `ID` no existeix, captura l'error i retorna un missatge controlat. 

```sql
CREATE FUNCTION info_ciutat(city_id integer) RETURNS TEXT AS $$
DECLARE
  resultat TEXT;
  nom_ciutat TEXT;
BEGIN
  SELECT name INTO nom_ciutat
  FROM city
  WHERE id = city_id;

  resultat := 'La ciutat és: ' || nom_ciutat;
  RETURN resultat;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'No s’ha trobat cap ciutat amb aquest ID.';
  WHEN TOO_MANY_ROWS THEN
    RETURN 'Retorna més d’una línea.';
END;
$$ LANGUAGE plpgsql;
```

> [!WARNING]  
> En PostgreSQL, la captura de `NO_DATA_FOUND` com a tal no està disponible com a excepció directa com en Oracle, però es pot simular o capturar amb condicions addicionals. Aquest exemple és conceptual i pot requerir millores segons el comportament exacte desitjat.

## Condicionals

Hi ha dos tipus de condicionals en PL/pgSQL: la sentència `IF` i la sentència `CASE`, de la qual hi ha diverses variants.

### `IF` / `ELSIF` / `ELSE`

S'utilitza per a executar blocs de codi segons si una condició és certa.

Volem fer una funció que digui si una ciutat té una població gran o petita. Suposem que considerem que més de 500.000 habitants és "gran":

```sql
CREATE FUNCTION classificacio_ciutat(city_id integer) RETURNS TEXT AS $$
DECLARE
  poblacio integer;
BEGIN
  SELECT population INTO poblacio
  FROM city
  WHERE id = city_id;

  IF poblacio > 500000 THEN
    RETURN 'Ciutat gran';
  ELSIF poblacio > 100000 THEN
    RETURN 'Ciutat mitjana';
  ELSE
    RETURN 'Ciutat petita';
  END IF;
END;
$$ LANGUAGE plpgsql;
```

### `CASE`

La sentència `CASE` permet comparar múltiples valors d'una variable o expressió de manera més ordenada quan hi ha molts casos.

Podem fer el mateix exemple que hem vist amb `IF` utilitzant `CASE`:

```sql
CREATE FUNCTION classificacio_ciutat_case(city_id integer) RETURNS TEXT AS $$
DECLARE
  poblacio integer;
BEGIN
  SELECT population INTO poblacio
  FROM city
  WHERE id = city_id;

  RETURN CASE
    WHEN poblacio > 500000 THEN 'Ciutat gran'
    WHEN poblacio > 100000 THEN 'Ciutat mitjana'
    ELSE 'Ciutat petita'
  END;
END;
$$ LANGUAGE plpgsql;
```

<br>

## Bucles

Hi ha diversos tipus de bucles en PL/pgSQL, en veurem alguns.

Els bucles permeten repetir un bloc de codi diverses vegades segons una condició (`WHILE`) o un rang (`FOR`).

### `WHILE`

Repeteix un bloc de codi mentre una condició sigui certa.

Aquest exemple imprimeix els noms de les primeres 5 ciutats (segons el seu id de l’1 al 5):

Aquesta funció **no retorna re**s, només mostra les 5 primeres ciutats (per `id`) a través de missatges `RAISE NOTICE`.

Pot donar error si algun `id` entre 1 i 5 no existeix (encara que a `world.city` habitualment sí que existeixen).

```sql
CREATE FUNCTION mostra_cinc_ciutats() RETURNS VOID AS $$
DECLARE
  comptador integer := 1;
  ciutat_nom TEXT;
BEGIN
  WHILE comptador <= 5 LOOP
    SELECT name INTO ciutat_nom
    FROM city
    WHERE id = comptador;

    RAISE NOTICE 'Ciutat %: %', comptador, ciutat_nom;

    comptador := comptador + 1;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
```

Anem a veure el codi pas per pas: 

```sql
CREATE FUNCTION mostra_cinc_ciutats() RETURNS VOID AS $$
```
- Crea una funció anomenada `mostra_cinc_ciutats`.
- No retorna cap valor (`RETURNS VOID`).
- El cos de la funció està delimitat per `$$`.

```sql
DECLARE
  comptador integer := 1;
  ciutat_nom TEXT;
```
- S’inicia la secció `DECLARE`, on es declaren variables locals.
- `comptador`: variable per portar el control del nombre d’iteracions, inicialitzada a 1.
- `ciutat_nom`: variable que guardarà el nom de la ciutat llegida de la base de dades.

```sql
BEGIN
  WHILE comptador <= 5 LOOP
```
- Inicia el cos principal de la funció.
- Comença un **bucle** `WHILE` que s’executarà **mentre** `comptador` **sigui menor o igual a 5**.

```sql
    SELECT name INTO ciutat_nom
    FROM city
    WHERE id = comptador;
```
- Aquesta consulta selecciona el **nom de la ciutat** (`name`) de la taula `city` amb `id = comptador`.
- El resultat s’assigna a la variable `ciutat_nom`.

```sql
    RAISE NOTICE 'Ciutat %: %', comptador, ciutat_nom;
```
- Mostra un missatge **informatiu al log** de PostgreSQL, per exemple:
```python
Ciutat 1: Kabul
Ciutat 2: Qandahar
...
```

```sql
comptador := comptador + 1;
```
- Incrementa el valor del **comptador** per passar al següent `id` en la pròxima iteració.

```sql
  END LOOP;
END;
$$ LANGUAGE plpgsql;
```
- Finalitza el bucle `WHILE` i el bloc principal `BEGIN ... END`.
- S’indica que el llenguatge utilitzat és **PL/pgSQL**, propi de PostgreSQL.

### `FOR`

Aquesta sentència es molt útil per fer-la iterar **sobre un rang de valors** o sobre un conjunt de files d'una consulta. 

Imaginem que volem mostrar el conjunt de les ciutats espanyoles que apareixen a la base de dades:

```sql
CREATE FUNCTION mostra_ciutats() RETURNS VOID AS $$
DECLARE
  registre RECORD;
BEGIN
  FOR registre IN SELECT id, name FROM city WHERE countrycode = 'ESP' LOOP
    RAISE NOTICE 'ID: %, Nom: %', registre.id, registre.name;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
```

Anem a veure el codi pas per pas: 

```sql
CREATE FUNCTION mostra_ciutats_espanoles() RETURNS VOID AS $$
```
- Declara la creació d’una **funció anomenada** `mostra_ciutats_espanoles`.
- Aquesta funció **no retorna cap valor**, per això s’indica `RETURNS VOID`.
- El codi de la funció comença amb `$$`.

```sql
DECLARE
  registre RECORD;
```
- S’inicia la secció de **declaració de variables locals**.
- Es declara una variable `registre` de tipus `RECORD`, que pot **emmagatzemar una fila sencera** (amb múltiples columnes) del resultat d’una consulta.
- En aquest cas, cada fila contindrà un `id` i un `name` de la taula `city`.

```sql
BEGIN
  FOR registre IN SELECT id, name FROM city WHERE countrycode = 'ESP' LOOP
```
- Inici del cos principal de la funció.
- Comença un **bucle** `FOR` que **itera sobre totes les ciutats de la taula** `city` on el `countrycode` **és 'ESP'** (Espanya).
- Cada fila que retorna aquesta consulta és assignada a la variable `registre`, que conté els camps `id` i `name`.

```sql
    RAISE NOTICE 'ID: %, Nom: %', registre.id, registre.name;
```
- Aquesta línia **imprimeix per pantalla (o al log de PostgreSQL)** el valor dels camps de la fila actual:
`registre.id`: identificador de la ciutat.
`registre.name`: nom de la ciutat.

Per exemple: 
```yaml
BEGIN
  FOR registre IN SELECT id, name FROM city WHERE countrycode = 'ESP' LOOP
```

```sql
  END LOOP;
END;
$$ LANGUAGE plpgsql;
```
- Finalitza el bucle `FOR` i el bloc principal `BEGIN ... END`.
- S’indica que el llenguatge utilitzat és **PL/pgSQL**, propi de PostgreSQL.

## Cursors

Els **cursors** en PL/pgSQL permeten recórrer el resultat d’una consulta fila a fila. Són útils quan es vol fer tractament seqüencial de dades que retornen múltiples registres.

L’interès d’estudiar els cursors és que, encara que ara ho fem amb PL/pgSQL, tots els llenguatges de programació utilitzen aquest mecanisme quan envien una consulta a una base de dades, així que el concepte i les idees que veiem ens serviran després per aplicar-les a Java, Python, PHP o el llenguatge que sigui que utilitzem.

---

### Quan s'utilitzen?

- Quan volem tractar una a una les files retornades per una consulta.
- Quan treballem amb moltes dades i volem processar-les progressivament.
- Quan volem aplicar condicions específiques a cada fila retornada.

---

### Tipus de cursors

#### 1. Cursors explícits
S'han de declarar, obrir, llegir i tancar manualment.

#### 2. Cursors implícits
Són gestionats automàticament dins d’un bucle `FOR`.

---

### Exemple 1: Cursor explícit

Suposem que volem mostrar per pantalla els països amb una població superior a 100 milions.

```sql
DO $$
DECLARE
    pais RECORD;
    paisos_cursor CURSOR FOR
        SELECT name, population FROM country WHERE population > 100000000;
BEGIN
    OPEN paisos_cursor;
    LOOP
        FETCH paisos_cursor INTO pais;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'País: %, Població: %', pais.name, pais.population;
    END LOOP;
    CLOSE paisos_cursor;
END $$;
```

## Diferents tipus de FETCH

PL/pgSQL permet diverses variants de la instrucció `FETCH` per controlar **quines files** es volen recuperar del cursor.

- **`FETCH NEXT`**: **Per defecte**. Recupera la **següent fila** del cursor. Equivalent al que fa el codi de l’exemple (`FETCH paisos_cursor INTO pais;`).
- **`FETCH PRIOR`**: Recupera la **fila anterior** (només funciona amb cursors SCROLL). Útil si cal anar enrere.
- **`FETCH FIRST`**: Recupera la **primera fila** del conjunt. **`FETCH ABSOLUTE n`** recupera la fila número **n**.
- **`FETCH LAST`**: Recupera l’**última fila**.
- **`FETCH RELATIVE n`**: Avança o retrocedeix **n** files respecte de la posició actual.
  `FETCH RELATIVE 2` → avança 2 files.
  `FETCH RELATIVE -1` → retrocedeix 1.

> [!WARNING]  
> Per utilitzar `PRIOR`, `ABSOLUTE`, `RELATIVE`, etc., s'ha de declarar el cursor amb l'opció `SCROLL`:
>
> ```sql
> paisos_cursor SCROLL CURSOR FOR ...
> ```

## Cursors amb paràmetres

Un cursor pot rebre **paràmetres** quan es declara, cosa que permet reutilitzar-lo per a diferents valors de cerca. Aquesta funcionalitat és útil quan volem aplicar filtres dinàmics.

### Exemple 2: Mostrar les ciutats d'un país concret

Volem crear un cursor que, donat un codi de país (`countrycode`), mostri totes les ciutats d’aquell país.

```sql
DO $$
DECLARE
    ciutat RECORD;
    codi_pais TEXT := 'ESP';  -- Aquí pots posar el país que vulguis
    cursor_ciutats CURSOR(codi TEXT) FOR
        SELECT name, population FROM city WHERE countrycode = codi;
BEGIN
    OPEN cursor_ciutats(codi_pais);

    LOOP
        FETCH cursor_ciutats INTO ciutat;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Ciutat: %, Habitants: %', ciutat.name, ciutat.population;
    END LOOP;

    CLOSE cursor_ciutats;
END $$;
```

## Recorregut pels resultats d'un cursor

Aquest és l'ús més habitual d'un cursor: recórrer tots els seus resultats. 

### Passos per fer el recorregut

1. **Obrir el cursor** amb `OPEN`.
2. **Recórrer les files** amb un bucle (`LOOP` o `WHILE`) i `FETCH`.
3. **Sortir del bucle** quan no hi ha més resultats (`EXIT WHEN NOT FOUND`).
4. **Tancar el cursor** amb `CLOSE`.
