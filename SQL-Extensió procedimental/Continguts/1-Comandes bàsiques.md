# Comandes bàsiques de PostgreSQL

## Connexió al client `psql`
El client `psql` permet interactuar amb PostgreSQL mitjançant línia de comandes. Algunes de les opcions bàsiques són:

- `-d`: Especifica la base de dades a utilitzar.
- `-h`: Indica el nom de host/IP on connectar-se.
- `-U`: Defineix l'usuari amb què establir la connexió.

Exemple de connexió:
```sh
psql -U usuari -d base_de_dades -h localhost
```

## Ordres essencials dins de `psql`
Un cop dins de `psql`, existeixen múltiples ordres especials que no són SQL i comencen amb el caràcter `\`.

### Comandes generals
| Ordre  | Com recordar-ho | Descripció | Equivalent en MySQL |
|--------|----------------|------------|---------------------|
| `\d`  | DESCRIBE       | Mostra les taules, vistes, etc. de la BD actual | `SHOW TABLES` |
| `\l`  | LIST           | Mostra les bases de dades disponibles | `SHOW DATABASES` |
| `\i <fitxer>` | IMPORT | Executa un script SQL des d’un fitxer | `SOURCE <fitxer>` |
| `\c <DB>` | CONNECT | Activa una base de dades | `USE <DB>` |
| `\d <taula>` | DESCRIBE | Mostra l’estructura d’una taula | `DESC <taula>` |
| `\q` | QUIT | Sortir de l’entorn `psql` | `EXIT` |
| `\x` | EXPANDED | Activa o desactiva la visualització estesa | `\G` |

### Variants de `\d` per examinar l’estructura de la BD
| Ordre  | Descripció |
|--------|------------|
| `\dt` | Mostra les taules |
| `\di` | Mostra els índexs |
| `\dv` | Mostra les vistes |
| `\ds` | Mostra les seqüències |
| `\dp` | Mostra els privilegis |
| `\df` | Mostra les funcions |
| `\du` | Mostra els rols (usuaris) |
| `\dn` | Mostra els esquemes |
| `\dn+` | Mostra els esquemes, incloent-hi els privilegis |

### Ús de comodins per filtrar informació
- `\dt nomesquema.*` → Mostra les taules de l’esquema `nomesquema`.
- `\dt *.*` → Mostra totes les taules de la base de dades.
- `\d nomesquema.nomtaula` → Mostra les columnes i tipus de la taula seleccionada.
