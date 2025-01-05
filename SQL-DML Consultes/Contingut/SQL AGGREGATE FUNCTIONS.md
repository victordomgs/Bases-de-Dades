# SQL AGGREGATE FUNCTIONS

Les funcions agregades són funcions que processen grups de files per retornar un únic valor. 

- `COUNT()`: Retorna el nombre de files.
- `SUM()`: Retorna la suma dels valors d'una columna.
- `AVG()`: Retorna la mitjana dels valors d'una columna.
- `MAX()`: Retorna el valor màxim d'una columna.
- `MIN()`: Retorna el valor mínim d'una columna.

> [!IMPORTANT]  
> Es necessari utilitzar `GROUP BY` en les següents situacions:
> - Comptar registres per grup.
> - Filtrar resultats agrupats amb `HAVING`.
> - Trobar màxim o mínim per grup.

**Exemples d'ús de la clàusula `GROUP BY`**

Volem comptar els productes que hi ha a la taula 
