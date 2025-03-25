# Funcions SQL

PostgreSQL accepta la creació de **funcions** en diferents llenguatges de programació. Nosaltres, utilitzarem el llenguatge propi SQL. 

Aquestes funcions estan formades per un conjunt d'instruccions en llenguatge SQL i retornen el resultat de l'última sentència executada. 

## Sintaxi bàsica

Anem a comentar el següent exemple: 

```sql
CREATE FUNCTION helloworld() RETURNS TEXT AS $$
  SELECT ("Hello World!");
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
