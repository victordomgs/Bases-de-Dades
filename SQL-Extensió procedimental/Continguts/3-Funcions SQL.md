# Funcions SQL

PostgreSQL accepta la creació de **funcions** en diferents llenguatges de programació. Nosaltres, utilitzarem el llenguatge propi SQL. 

Aquestes funcions estan formades per un conjunt d'instruccions en llenguatge SQL i retornen el resultat de l'última sentència executada. 

## Sintaxi bàsica

Anem a comentar el següent exemple: 

```sql
CREATE FUNCTION helloworld() RETURNS TEXT AS $$
  SELECT ('Hello World!');
$$ LANGUAGE SQL;
```

| **Part** | **Explicació** | 
|-----------------|---------------|
| CREATE FUNCTION helloworld()             | Es crea una funció amb el nom helloworld, que no rep cap paràmetre.        | 
| RETURNS integer            | Indica que la funció retorna un valor de tipus enter.      | 
| AS $$ ... $$             | El codi de la funció s'escriu entre dos delimitadors ($$). Això permet escriure blocs de codi amb més llibertat, especialment si hi ha cometes dins del cos.          |
| SELECT ("Hello World!");          | Aquest és el cos de la funció. Retorna el valor "Hello World!" i el dona un àlies (result).       | 
| LANGUAGE SQL             | S'indica que el llenguatge usat per la funció és SQL pur (no PL/pgSQL, que permet més complexitat com variables o bucles).         |   

Evidentment, podem obtenir qualsevol resultat que vulguem. Imaginem que estem treballant amb la base de dades `World`. Volem saber la població mitjana que hi ha a cada ciutat: 

```sql
CREATE FUNCTION avgpopulation() RETURNS INTEGER AS $$
  SELECT AVG(population) FROM city;
$$ LANGUAGE SQL;
```

## Paràmetres

Els **paràmetres** són valors que passes a una funció quan la crides. Serveixen per fer que la funció sigui reutilitzable amb diferents valors. 

Per exemple, si tens una funció que calcula l'edat d'una persona a partir de l'any de naixement, l'any hauria de ser un paràmetre. 

Imaginem que tenim la següent funció: 

```sql
CREATE FUNCTION doble(x integer) RETURNS integer AS $$
  SELECT x * 2;
$$ LANGUAGE SQL;
```

> [!IMPORTANT]  
> Per **cridar a una funció** que té un paràmetre, necessitarem passar-li un valor.
> ```sql
> SELECT doble(4);
> ```

## Crida de funcions

Podem cridar les nostres funcions utilitzant un `SELECT` i indicant el nom de la funció. 

> [!IMPORTANT] 
> A diferència de Java, primer s'escriu el nom del paràmetre i després el tipus.

```sql
SELECT helloworld();
SELECT avgpopulation();
SELECT doble(13);
```

## Esborrat de funcions

Per esborrar una funció utilitzarem `DROP FUNCTION`:

```sql
DROP FUNCTION helloworld();
DROP FUNCTION avgpopulation();
DROP FUNCTION doble(integer);
```

## Sobreescriptura

En ocasions, podem necessitar definir funcions que realitzin tasques similars però treballin amb **tipus de dades diferents** o **quantitats diferents de paràmetres**.

PostgreSQL admet la **sobreescriptura de funcions** (function overloading). Això vol dir que podem crear diverses funcions amb **el mateix nom**, sempre que **el nombre o el tipus d’arguments sigui diferent**.

Gràcies a aquesta característica, PostgreSQL pot distingir quina versió de la funció ha de cridar segons els paràmetres que li passem.

Exemple: Sobreescriptura d'una funció `saluda`:

```sql
-- Funció que rep un text (nom) i retorna un missatge personalitzat
CREATE FUNCTION saluda(nom TEXT) RETURNS TEXT AS $$
  SELECT CONCAT('Hola, ', nom, '!');
$$ LANGUAGE SQL;

-- Funció amb el mateix nom però sense paràmetres
CREATE FUNCTION saluda() RETURNS TEXT AS $$
  SELECT 'Hola món!';
$$ LANGUAGE SQL;
```

Cada cop que cridem la funció `saluda` s'executarà una funció o una altre depenent de si li passem un paràmetre o no. 

## Triar un valor de retorn

En algunes ocasions, utilitzem sentències SQL que **no retornen cap valor** directament, com `INSERT`, `UPDATE` o `DELETE`.

En aquests casos, podem fer ús de la clàusula `RETURNING` per **indicar quin valor volem obtenir com a resultat de l’operació** i, per tant, com a **valor de retorn** de la nostra funció.

Aquesta clàusula és especialment útil quan volem saber quin valor ha resultat després de modificar una fila.

Suposem que volem incrementar la població (`population`) d’un país en un determinat valor, i retornar el nou valor de població:

```sql
CREATE FUNCTION incrementa_poblacio(pais TEXT, increment INTEGER) RETURNS INTEGER AS $$
  UPDATE country
  SET population = population + increment
  WHERE name = pais 
  RETURNING population;
$$ LANGUAGE SQL;
```

## Crear un operador personalitzat

En PostgreSQL, podem crear **operadors nous** que ens permeten fer operacions personalitzades entre tipus de dades, de la mateixa manera que fem servir els operadors tradicionals com `+`, `-`, `=`, etc.

Per fer-ho, necessitem **dues coses**:

1. **Una funció** que defineixi el comportament de l’operador.
2. **L’operador** en si, que farà servir aquesta funció.

Suposem que volem definir un operador `##` que concateni dos textos amb un espai. Primer hem de crear una funció que rebi dos noms de poblacions (valors `TEXT`) i les uneixi:

```sql
CREATE FUNCTION concat_amb_espai(t1 TEXT, t2 TEXT) RETURNS TEXT AS $$
  SELECT CONCAT(t1, ' ', t2);
$$ LANGUAGE SQL;
```

Ara creem un operador personalitzat que utilitzi aquesta funció:

```sql
CREATE OPERATOR ## (
  LEFTARG = TEXT,
  RIGHTARG = TEXT,
  PROCEDURE = concat_amb_espai
);
```

> [!IMPORTANT]
> Si volem eliminar una funció que hem utilitzat per crear un operador, necessitarem primer eleminar els objectes que depenen d'aquesta. Per eliminar un operador, s'ha d'especificar els arguments d'esquerra i dreta:
> ```sql
> DROP OPERATOR ##(text, text);
> ```

## Crear una funció d'agregació personalitzada

PostgreSQL permet crear **funcions d’agregació personalitzades**, és a dir, funcions que processen múltiples files i retornen un **valor agregat**, com fan les funcions estàndard `SUM`, `AVG`, `MIN`, etc.

Aquesta funcionalitat és molt útil quan volem definir el nostre propi criteri d’agregació.

Per crear una agregació, necessitem:

1. **Una funció de transició**: que s’aplica fila a fila i acumula el resultat.
2. **Una definició de l’agregació** (`CREATE AGGREGATE`) que les uneix.

Volem crear una agregació que uneixi textos separats per comes, semblant a `string_agg`, però feta per nosaltres.

Imaginem que volem unir tots els països que formen part d'un continent en una llista separada per comes. 

1. Primer hem de definir la **funció de transició**:

```sql
CREATE FUNCTION list_country(element TEXT, country TEXT) RETURNS TEXT AS $$
  SELECT CASE WHEN element IS NULL THEN country
    ELSE CONCAT(element, ', ', country)
    END;
$$ LANGUAGE SQL;
```

2. Definim la **funció agregada**:

```sql
CREATE AGGREGATE agrupa_country(TEXT) (
  SFUNC = list_country,
  STYPE = TEXT
);
```

Podriem utilitzar aquesta funció per veure tots els països que hi ha a Europa: 

```sql
SELECT agrupa_country(name) FROM country WHERE continent = 'Europe';
```
