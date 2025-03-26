# Com importar una base de dades a PostgreSQL 

> [!IMPORTANT]
> L'usuari postgres no té permisos per accedir als directoris del sistema. Per tant, necessitarem moure el `.sql` descarregat a la carpeta `tmp`. Per fer-ho, utilitzem la següent comanda: `sudo mv -i...`.
> 
> Necessitem executar les comandes desde l'usuari de sistema `postgres`. Recorda la comanda: `sudo -i -u postgres`.

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
