# Restriccions de Clau Forana

## Definició
Una clau forana (foreign key) és un camp o conjunt de camps en una taula que estableix una relació amb la clau primària d'una altra taula. Serveix per garantir la integritat referencial entre les dades de dues taules.

## Objectiu
Les claus foranes asseguren que els valors d'un camp (o camps) en una taula coincideixin amb els valors d'una clau primària en una altra taula. Això evita l'existència de registres "penjats" o referències a dades inexistents.

## Sintaxi Bàsica
```sql
CREATE TABLE comanda (
    id_comanda INT PRIMARY KEY,
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES client(id_client)
);
```

## Comportaments de Clau Forana: ON DELETE i ON UPDATE
Quan es defineix una clau forana, es poden establir accions específiques per determinar què passa quan es modifiquen o s'eliminen els valors en la taula referenciada:

### 1. ON DELETE
Defineix el comportament que s'executa quan s'elimina un registre de la taula pare que està referenciat per la clau forana de la taula filla.

### 2. ON UPDATE
Defineix el comportament que s'executa quan es modifica el valor de la clau primària en la taula pare que està referenciat per la clau forana de la taula filla.

## Opcions per ON DELETE i ON UPDATE
Les opcions són les mateixes tant per ON DELETE com per ON UPDATE. A continuació, s'expliquen detalladament:

### CASCADE
Quan s'elimina o es modifica un registre de la taula pare, automàticament s'eliminen o s'actualitzen tots els registres de la taula filla que el referencien.

#### Exemple:
```sql
CREATE TABLE comanda (
    id_comanda INT PRIMARY KEY,
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE
);
```
#### Quan s'utilitza?
- Quan vols que en eliminar o modificar un client, també s'eliminen o es modifiquin totes les comandes associades.

### SET NULL
Quan s'elimina o es modifica un registre de la taula pare, els camps de la clau forana en la taula filla es posen a NULL.

#### Exemple:
```sql
CREATE TABLE comanda (
    id_comanda INT PRIMARY KEY,
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE SET NULL ON UPDATE SET NULL
);
```
#### Quan s'utilitza?
- Quan vols mantenir els registres de la taula filla però deixar el camp de la clau forana sense valor (NULL).

### SET DEFAULT
Quan s'elimina o es modifica un registre de la taula pare, els camps de la clau forana en la taula filla es posen al valor per defecte definit.

#### Exemple:
```sql
CREATE TABLE comanda (
    id_comanda INT PRIMARY KEY,
    id_client INT DEFAULT 1,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);
```
#### Quan s'utilitza?
- Quan vols que, en eliminar o modificar la clau primària, el valor de la clau forana prengui un valor per defecte.

### RESTRICT
Impedeix l'eliminació o modificació d'un registre de la taula pare si hi ha registres en la taula filla que el referencien.

#### Exemple:
```sql
CREATE TABLE comanda (
    id_comanda INT PRIMARY KEY,
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE RESTRICT ON UPDATE RESTRICT
);
```
#### Quan s'utilitza?
- Quan vols impedir que s'elimini o es modifiqui un registre pare si encara està relacionat amb registres a la taula filla.

### NO ACTION
És similar a RESTRICT. No permet eliminar o modificar el registre pare si hi ha referències a la taula filla. Aquesta és la restricció per defecte si no s'indica cap altra opció.

#### Exemple:
```sql
CREATE TABLE comanda (
    id_comanda INT PRIMARY KEY,
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE NO ACTION ON UPDATE NO ACTION
);
```
#### Quan s'utilitza?
- Quan vols mantenir l'estricte compliment de la integritat referencial i no vols accions automàtiques.

## Resum Taula
| Opció              | Comportament (DELETE/UPDATE)                                    | Quan s'utilitza                                        |
|---------------------|-----------------------------------------------------------------|----------------------------------------------------------|
| CASCADE             | Elimina o actualitza els registres relacionats                  | Quan vols eliminar o actualitzar dades lligades automàticament   |
| SET NULL            | Assigna NULL als camps relacionats                              | Quan vols mantenir els registres però sense associació   |
| SET DEFAULT         | Assigna el valor per defecte als camps relacionats              | Quan vols posar un valor per defecte si es modifica la relació |
| RESTRICT            | Impedeix l'eliminació o modificació si hi ha referències        | Quan vols evitar eliminar o modificar dades amb relacions actives    |
| NO ACTION           | Igual que RESTRICT (comportament per defecte)                   | Quan vols integritat estricta per defecte                |

