# Funcions SQL

PostgreSQL accepta la creació de funcions en diferents llenguatges de programació. Nosaltres, utilitzarem el llenguatge propi SQL. 

Aquestes funcions estan formades per un conjunt d'instruccions en llenguatge SQL i retornen el resultat de l'última sentència executada. 

## Sintaxi bàsica

Anem a comentar el següent exemple: 

```sql
CREATE FUNCTION helloworld() RETURNS INTEGER AS $$
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
