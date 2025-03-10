# Com importar una base de dades a PostgreSQL 

## Importar un fitxer `.sql`
Si tens un fitxer SQL amb les instruccions per crear i omplir la base de dades, utilitza la següent comanda:

### **Sintaxi:**
```sh
psql -U <usuari> -d <nom_base_de_dades> -f <fitxer.sql>
```

### **Exemple:**
```sh
psql -U postgres -d empresa -f backup.sql
```
*Això executarà el contingut del fitxer `backup.sql` dins la base de dades `empresa`.*
