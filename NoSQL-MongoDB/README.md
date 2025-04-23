# MongoDB

## 1. Introducció a MongoDB

Una base de dades **NoSQL** (sovint interpretat com a Not only SQL i significa 'No només SQL') proporciona un mecanisme per emmagatzemar i recuperar dades que es modelen mitjançant relacions tabulars diferents a les utilitzades en les bases de dades relacionals. Aquest canvi de model està motivat per la simplicitat de disseny, l'escalabilitat horitzontal i un major control de la disponibilitat. 

Existeixen diferents models i tipologies segons la forma en la que emmagatzemen aquestes dades: 

- **Columna:** emmagatzemen la informació utilitzant un model orientat a columnes en comptes d'un model orientat a files. Això permet que l'accés a les dades, al moment de fer una consulta, sigui més eficient, ja que per a fer-ho únicament serà necessari accedir a la clau de la fila que guardi la informació desitjada.
- **Clau-valor:** una base de dades de clau-valor, o magatzem de clau-valor, és un paradigma d'emmagatzematge de dades dissenyat per emmagatzemar, recuperar i administrar arranjaments associatius, una estructura de dades més comunament coneguada avui en dia com un diccionari o taula hash.
- **Documental:** una base de dades documental està constituïda per un conjunt de programes que emmagatzemen, recuperen i gestionen dades de documents o dades estructurades d'alguna manera.

Nosaltres farem servir el programari **MongoDB**. 

**MongoDB** és un programari de codi obert, per a la creació i gestió de base de dades orientada a documents, escalable, d'alt rendiment i lliure d'esquema programada en C++.

- Els documents tenen una representació directa en molts llenguatges de programació. Això significa que la traducció entre les dades d’una BD i els objectes a memòria és molt més senzilla que en una base de dades relacional.
- En el cas del format JSON, el Javascript pot interpretar els documents com si fossin objectes directament. Altres llenguatges tenen estructures que faciliten el tractament de parelles camp-valor, com els diccionaris.

- Els documents permeten emmagatzemar les dades en estructures que són
impossibles en una BD relacional. Per exemple, un camp pot contenir un
array com a valor (i ésser per tant una propietat multivaluada, concepte que
no es pot implementar en el model relacional). O un document en format d’arbre
pot contenir molta informació niuada, cosa que evita l’ús extensiu de **joins**.

- Contràriament al sistema relacional, els documents permeten una gran
variabilitat en les dades. Per exemple, podem tenir documents on apareguin
camps que en d’altres documents no hi siguin, i documents amb estructures
molt diferents entre ells emmagatzemats a la mateixa col·lecció. Fins i tot,
els documents es poden modificar i afegir o treure camps dinàmicament.

### 1.1. Instal·lació

1. En primer lloc, actualitzem el sistema e instal·lem els paquets necessaris:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl gnupg -y
```
2. Importem la clave pública oficial de MongoDB per tal de validar l'autenticació del repositori:
   
```bash
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
```
3. Actualitzem e instal·lem mongodb:

```bash
sudo apt update
sudo apt install -y mongodb-org
```

4. Iniciem i habilitem mongodb:

```bash
sudo systemctl start mongod
sudo systemctl enable mongod
```

5. Executem el SHELL de mongodb:

```bash
mongosh
```

### 1.2. Format JSON

MongoDB treballa amb documents en format JSON. Totes les entrades al sistema, tant pel que fa als documents com a les consultes s’han d’escriure en aquest format.

Per treballar amb MongoDB és molt important entendre el format de documents JSON.


L’acrònim JSON ve de JavaScript Object Notation i, de fet, els objectes en JavaScript es poden exportar i importar en JSON directament. Però el JSON, igual que l’XML, s’ha convertit en un format estàndard d’intercanvi de dades entre aplicacions. De fet, és molt similar a l’XML, encara que més compacte.

Un document, o un objecte, que en aquest context són sinònims, és simplement un conjunt de parelles camp:valor. El document es delimita pels símbols {}, i el símbol : separa un camp del seu valor. La , s’utilitza per separar les parelles. Els camps i, si són text, els valors, es delimiten amb ".

```javascript
{
  "camp1": "valor1",
  "camp2": "valor2",
  "camp3": 3,
  "camp4": 4.5,
  "camp5": true,
  "camp6": false,
  "camp7": null
}
```

Els valors poden ser també arrays: 

```javascript
{
  "camp1": ["valor1", "valor2", 3, 4.5]
}
```

### 1.3. Primers passos

Una vegada estem dins de la consola, anem a veure algunes comandes bàsiques: 

1. Mostrar les bases de dades disponibles:

```javascript
show dbs
```

2. Crear o canviar de base de dades:

```javascript
use escola
```

3. Inserir documents:

```javascript
db.alumnes.insertOne({ nom: "Júlia", edat: 17 })
```

Rebrem un missatge tal qual: 

```javascript
escola> db.alumnes.insertOne({nom: "Júlia", edat: 17})
{
  acknowledged: true,
  insertedId: ObjectId('68090b1cd7c0eaa0ead861e0')
}
```

> [!IMPORTANT]
> L'`ObjectId` que veus a la sortida de la comanda `insertOne` és un identificador únic que MongoDB assigna automàticament a cada document inserit, si no li proporciones tu un camp `_id`.

Podem inserir un nou document utilitzant el camp `_id`.

```javascript
db.aules.insertOne({_id: 1, codi: 1.7, grup: ASIX})
```

Rebrem un missatge tal qual on ens especifica que s'ha inserit un identificador.

```javascript
db.aules.insertOne({_id: 1, codi: '1.7', grup: 'ASIX'})
{ acknowledged: true, insertedId: 1 }
```

4. Consultar documents:

```javascript
db.alumnes.find()
```

o per veure els resultats ben formats: 

```javascript
db.alumnes.find().pretty()
```

5. Consultar documents amb criteris:

```javascript
db.alumnes.find({ edat: 17 })
```

6. Actualitzar documents:

```javascript
db.alumnes.updateOne(
  { nom: "Júlia" },
  { $set: { edat: 18 } }
)
```

7. Eliminar documents:

```javascript
db.alumnes.deleteOne({ nom: "Júlia" })
```

8. ELiminar una col·lecció:

```javascript
db.nom_colleccio.drop()
```

9. Eliminar una base de dades:

```javascript
db.dropDatabase()
```
