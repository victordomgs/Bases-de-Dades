# Instrucció SQL SELECT

L'instrucció **SELECT** és la comanda més utilitzada en el llenguatge SQL (Structured Query Language). Serveix per accedir als registres d'una o més taules o vistes d'una base de dades. També permet recuperar dades específiques que compleixin les condicions definides.

Mitjançant aquesta comanda, també podem accedir a un registre concret d'una columna específica d'una taula. La taula que emmagatzema els registres retornats per la instrucció SELECT s'anomena **taula de resultats**.

## Sintaxi de l'instrucció SELECT en SQL

```sql
SELECT Nom_Columna_1, Nom_Columna_2, ..., Nom_Columna_N FROM Nom_Taula;
```

En aquesta sintaxi:
- **Nom_Columna_1**, **Nom_Columna_2**, ..., **Nom_Columna_N** són els noms de les columnes de la taula de les quals volem llegir les dades.
- **Nom_Taula** és el nom de la taula on es troben les dades.
Si voleu accedir a totes les files i columnes d'una taula, podeu utilitzar la següent sintaxi amb l'asterisc `*`:
