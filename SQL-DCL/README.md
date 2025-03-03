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
