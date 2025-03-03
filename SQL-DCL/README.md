# Guia d'instal·lació de PostgreSQL a Ubuntu

## Què és PostgreSQL?
PostgreSQL és un sistema de gestió de bases de dades relacional de codi obert i de conformitat amb l'estàndard SQL. Ofereix característiques avançades com transaccions ACID, suport per JSON i XML, extensions personalitzades i repliques.

## Instal·lació de PostgreSQL a Ubuntu

### 1. Actualitzar els paquets del sistema
Abans d'instal·lar PostgreSQL, assegura't que el sistema estigui actualitzat executant:

```sh
sudo apt update && sudo apt upgrade -y
```

### 2. Instal·lar PostgreSQL
Per instal·lar PostgreSQL i els seus paquets addicionals, executa:

```sh
sudo apt install postgresql postgresql-contrib -y
```

### 3. Verificar l'estat del servei
Un cop instal·lat, PostgreSQL s'executa automàticament. Pots verificar el seu estat amb:

```sh
sudo systemctl status postgresql
```

Si no està actiu, pots iniciar-lo manualment:

```sh
sudo systemctl start postgresql
```

Per assegurar-te que PostgreSQL s'iniciï automàticament en arrencar el sistema:

```sh
sudo systemctl enable postgresql
```

### 4. Accedir a PostgreSQL
PostgreSQL crea un usuari per defecte anomenat `postgres`. Pots accedir-hi amb:

```sh
sudo -i -u postgres
psql
```

Un cop dins de la consola de PostgreSQL, pots executar consultes SQL. Per sortir, usa:

```sql
\q
```

### 5. Crear un nou usuari i base de dades
Per crear un nou usuari:

```sh
sudo -u postgres createuser -P nom_usuari
```

Per crear una base de dades:

```sh
sudo -u postgres createdb nom_base_de_dades
```

Per assignar permisos:

```sql
ALTER ROLE nom_usuari WITH SUPERUSER;
```

### 6. Permetre l'accés remot (opcional)
Si necessites accedir a PostgreSQL des d'altres dispositius, edita el fitxer de configuració:

```sh
sudo nano /etc/postgresql/14/main/postgresql.conf
```

Cerca la línia:

```sh
#listen_addresses = 'localhost'
```

Descomenta-la i modifica-la a:

```sh
listen_addresses = '*'
```

Després, edita `pg_hba.conf` per permetre connexions externes:

```sh
sudo nano /etc/postgresql/14/main/pg_hba.conf
```

Afegir la següent línia al final per permetre connexions remotes:

```sh
host    all             all             0.0.0.0/0               md5
```

Reiniciar el servei per aplicar els canvis:

```sh
sudo systemctl restart postgresql
```

### 7. Desinstal·lació de PostgreSQL (opcional)
Si necessites eliminar PostgreSQL del sistema:

```sh
sudo apt remove --purge postgresql postgresql-contrib -y
sudo apt autoremove -y
```

## Conclusió
Amb aquesta guia has après a instal·lar, configurar i gestionar PostgreSQL a Ubuntu. Ara pots utilitzar-lo per desenvolupar aplicacions amb bases de dades robustes i escalables.

