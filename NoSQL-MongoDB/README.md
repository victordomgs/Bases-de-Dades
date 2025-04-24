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

## 2. Instal·lació

1. En primer lloc, actualitzem el sistema e instal·lem els paquets necessaris:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl gnupg -y
```
2. Importem la clave pública oficial de MongoDB per tal de validar l'autenticació del repositori:
   
```bash
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
```

3. Crea el archivo .list del repositorio:

```bash
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list > /dev/null
```

4. Actualitzem e instal·lem mongodb:

```bash
sudo apt update
sudo apt install -y mongodb-org
```

5. Iniciem i habilitem mongodb:

```bash
sudo systemctl start mongod
sudo systemctl enable mongod
```

6. Executem el SHELL de mongodb:

```bash
mongosh
```

## 3. Format JSON

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

## 4. Operacions bàsiques

MongoDB ens permet realitzar operacions bàsiques de bases de dades mitjançant el seu terminal, que actua com un intèrpret complet de JavaScript.

Per defecte, el sistema ens proporciona l'objecte `db`, que representa la base de dades actual. Mitjançant aquest objecte podem accedir a les col·leccions que conté la base de dades. Cada col·lecció es tracta com una propietat de `db`.

Per exemple, si tenim una col·lecció anomenada `employees`, hi accedirem amb:

```javascript
db.employees
```

Un cop tenim accés a la col·lecció, podem aplicar-hi diferents operacions mitjançant mètodes com ara:

- `db.employees.find()` → Llegeix (Read) els documents de la col·lecció.
- `db.employees.insertOne({...})` → Crea (Create) un nou document.
- `db.employees.updateOne({...}, {...})` → Actualitza (Update) un document.
- `db.employees.deleteOne({...})` → Elimina (Delete) un document.

Aquestes operacions formen part del conjunt CRUD: **Create, Read, Update i Delete**, les accions bàsiques en qualsevol sistema de gestió de dades.

### 4.1. Inserció de documents

Per afegir dades a una col·lecció a MongoDB, utilitzem els mètodes `insertOne()` per inserir un sol document, o `insertMany()` per inserir diversos documents alhora.

📌 Exemple amb `insertOne()`

Suposem que volem afegir un nou treballador a la col·lecció `employees`. Ho faríem així:

```javascript
db.employees.insertOne({
  DNI: '12345678Z',
  name: 'Jordi',
  salary: 2000,
  age: 30
})
```

En MongoDB no hi ha un esquema fix com en els SGBD relacionals. Això vol dir que cada document pot tenir una estructura diferent, i som nosaltres qui definim les claus i els valors en cada inserció. El format utilitzat és JSON, ja que MongoDB funciona internament amb JavaScript.

✅ És recomanable escriure les insercions llargues en múltiples línies per claredat.

#### 🔁 Resposta del sistema
Després d’executar la comanda, obtindrem una resposta similar a aquesta:

```javascript
{
  "acknowledged": true,
  "insertedId": ObjectId("661f5d8b28b9e30b4e9fa93c")
}
```

Això ens indica que la inserció ha estat correcta i ens proporciona l’identificador únic (`_id`) que MongoDB ha assignat automàticament al document.

> [!NOTE]
> Si ho desitgem, podem assignar nosaltres mateixos el camp `_id`, especialment si tenim una clau natural com el DNI.

També podem afegir diversos documents d'una sola vegada. Per fer-ho, passem un **array d'objectes** com a paràmetre: 

```javascript
db.employees.insertMany([
  {DNI: '23456789X', name: 'Laia', salary: 1900, age: 28},
  {DNI: '34567890Y', name: 'Nil', salary: 1750, age: 26},
  {DNI: '45678901Z', name: 'Clara', salary: 2100, age: 32}
])
```

> [!NOTE]
> Fixeu-vos que utilitzem claudàtors [] per indicar que es tracta d’una llista de documents. Cada element dins l’array és un objecte JSON que representa un registre independent dins la col·lecció.


### 4.2. Consultes bàsiques

Per consultar documents dins d’una col·lecció utilitzem:

- `find()` per recuperar **tots els documents**.
- `findOne()` per recuperar **un sol document**.

📌 Exemple per veure tots els empleats:

```javascript
db.employees.find()
```

Això, ens mostra tots els documents de la col·lecció. Per exemple: 

```javascript
{ "_id": ObjectId("..."), "DNI": "12345678Z", "name": "Jordi", "salary": 2000, "age": 30 }
{ "_id": ObjectId("..."), "DNI": "23456789X", "name": "Laia", "salary": 1900, "age": 28 }
{ "_id": ObjectId("..."), "DNI": "34567890Y", "name": "Nil", "salary": 1750, "age": 26 }
{ "_id": ObjectId("..."), "DNI": "45678901Z", "name": "Clara", "salary": 2100, "age": 32 }
```

📌 Exemple per veure un document qualsevol:

```javascript
db.employees.findOne()
```

Retorna un sol document (normalment el primer trobat), útil per veure’n l’estructura:

```javascript
{
  "_id": ObjectId("..."),
  "DNI": "12345678Z",
  "name": "Jordi",
  "salary": 2000,
  "age": 30
}
```

> [!NOTE]
> `find()` retorna un cursor (semblant a una llista o array), mentre que `findOne()` retorna un objecte directament.

📌 Exemple per accedir al segon document (com a array):

```javascript
db.employees.find().toArray()[1]
```

> [!IMPORTANT]
> A MongoDB Shell cal convertir el cursor a array amb `toArray()` si vols accedir per índex.

També, tenim algunes funcionalitats que ens permeten obtenir els documents més llegibles.

Si volem una sortida més llegible, utilitzarem `pretty()`: 

```javascript
db.employees.find().pretty()
```

Mostra cada document amb indentació:

```javascript
{
  "_id": ObjectId("..."),
  "DNI": "12345678Z",
  "name": "Jordi",
  "salary": 2000,
  "age": 30
}
...
```

D'altra banda, podem controlar quants documents volem mostrar i des de quin punt:

```javascript
db.employees.find().skip(1).limit(2)
```

Aquest exemple **salta el primer document** i després **mostra els dos següents**.

Resultat:

```javascript
{ "_id": ObjectId("..."), "DNI": "23456789X", "name": "Laia", "salary": 1900, "age": 28 }
{ "_id": ObjectId("..."), "DNI": "34567890Y", "name": "Nil", "salary": 1750, "age": 26 }
```

> [!NOTE]
> Aquesta manera d'encadenar mètodes (`find().skip().limit()`) forma part del que s'anomena fluent interface — una tècnica molt estesa que permet aplicar diverses operacions de forma consecutiva.

Per defecte, MongoDB conserva l’ordre d’inserció amb `insertMany()`, per això els resultats de les consultes solen sortir en el mateix ordre. Tot i això, es pot desactivar aquest comportament si volem prioritzar el rendiment.

### 4.3. Consultes amb filtres

A MongoDB, podem filtrar documents passant un objecte com a **primer paràmetre del mètode** `find()`. Aquest objecte defineix els criteris de cerca.

📌 Exemple bàsic: buscar per valor concret:

```javascript
db.employees.find({ age: 30 })
```

Aquesta consulta retorna tots els empleats que tenen 30 anys.

Podem buscar per patrons de text (regex). Podem fer servir expressions regulars per cercar patrons dins de camps de text.

📌 Exemple bàsic: empleats el nom dels quals comença per 'L':

```javascript
db.employees.find({ name: /^L/ })
```

📌 Exemple bàsic: empleats el nom dels quals acaba per ‘a’:

```javascript
db.employees.find({ name: /a$/ })
```

També podem fer servir l'operador `$regex`, que és equivalent:

```javascript
db.employees.find({ name: { $regex: /^L/ } })
db.employees.find({ name: { $regex: /a$/ } })
```

> [!NOTE]
> `^` indica inici de cadena
> `$` indica final de cadena
> No calen cometes dins les regex (`/^L/`, no "`/^L/`")

#### Filtres combinats

Si afegim diversos criteris dins l'objecte, MongoDB interpreta que han de complir-se **tots**:

```javascript
db.employees.find({ age: 30, name: /^L/ })
```

Aquesta consulta retorna empleats que tinguin 30 anys i el nom comenci per 'L'.

Podem fer cerques més potents fent servir operadors com:

- `$gt` → més gran que
- `$lt` → més petit que
- `$gte` → més gran o igual
- `$lte` → més petit o igual
- `$ne` → diferent
- `$eq` → igual

📌 Exemple per cercar empleats de més de 28 anys:

```javascript
db.employees.find({ age: { $gt: 28 } })
```

Evidentment, existeix la possibilitat de fer servir operadors lògics per generar cerques més complexes: 

📌 Exemple amb `or`, qualsevol de les condicions:

```javascript
db.employees.find({
  $or: [
    { age: { $gt: 28 } },
    { name: /^L/ }
  ]
})
```

Això retorna empleats majors de 28 o amb nom que comenci per 'L'.

📌 Exemple amb `and`, totes les condicions (només cal si hi ha més complexitat):

```javascript
db.employees.find({
  $and: [
    { age: { $gte: 27 } },
    { age: { $lte: 30 } }
  ]
})
```

Aquest exemple busca empleats amb **edat entre 27 i 30 anys** (ambdós inclosos).

#### Combinació d’$or i $and

📌 Exemple complex: Empleats majors de 25 anys i que, a més, tinguin menys de 30 o el nom comenci per 'L':

```javascript
db.employees.find({
  $and: [
    { age: { $gt: 25 } },
    {
      $or: [
        { age: { $lt: 30 } },
        { name: /^L/ }
      ]
    }
  ]
})
```

### 4.4. Consultes amb projeccions

Quan només volem veure **certs camps** dels documents i no la totalitat, podem afegir un **segon paràmetre** a la funció `find()` per indicar **quins camps volem recuperar**.

Aquesta projecció és un objecte amb:

- valor `1` per **mostrar** el camp.
- valor `0` per **ocultar-lo**.

📌 Exemple per mostrar només el nom dels empleats:

```javascript
db.employees.find({}, { name: 1 })
```

MongoDB mostra sempre el camp `_id` per defecte:

```javascript
{ "_id": ObjectId("..."), "name": "Jordi" }
...
```

Si volem ocultar el camp `_id` farem:

```javascript
db.employees.find({}, { name: 1, _id: 0 })
```

```javascript
{ "name": "Jordi" }
{ "name": "Laia" }
{ "name": "Nil" }
```

📌 Exemple amb condició i projecció:

```javascript
db.employees.find(
  { age: { $gt: 28 } },
  { name: 1, age: 1, _id: 0 }
)
```

```javascript
{ "name": "Clara", "age": 32 }
```

Per ordenar els resultats d’una consulta s’utilitza la funció `sort()`. Aquesta funció rep un document com a paràmetre. Aquest document serveix per indicar per quin o quins camps s’ha de fer l’ordenació, i si l’ordenació és ascendent o descendent.

Per exemple:

- Si passem el document `{name:1}` ordenarà pel camp `name` de forma ascendent.
- Si passem el document `{name:-1}` ho farà de forma descendent.
- El document `{salary:-1,name:1}` indica que primer s’ha d’ordenar pel `salary` de forma descendent i que els documents que tenen el mateix valor al camp `salary` s’ordenaran pel camp `name` de forma ascendent.

📌 Exemple amb ordenació per noms alfabètics:

```javascript
db.employees.find({}, { name: 1, _id: 0 }).sort({ name: 1 })
```

📌 Exemple d'ordenar per sou (descendent), i en cas d'empat, per DNI (ascendent):

```javascript
db.employees.find({}, { name: 1, DNI: 1, salary: 1, _id: 0 }).sort({ salary: -1, DNI: 1 })
```

📌 Exemple majors de 25 anys, ordenats pel DNI:

```javascript
db.employees.find({ age: { $gt: 25 } }).sort({ DNI: 1 })
```

📌 Exemple de l'empleat que cobra més:

```javascript
db.employees.find({}, { name: 1, DNI: 1, salary: 1, _id: 0 }).sort({ salary: -1 }).limit(1)
```

📌 Exemple de l'empleat que cobra el segon sou més alt:

```javascript
db.employees.find({}, { name: 1, DNI: 1, salary: 1, _id: 0 }).sort({ salary: -1 }).skip(1).limit(1)
```

#### Modificació de documents

MongoDB permet actualitzar documents amb:

- `updateOne()` → actualitza el primer document trobat
- `updateMany()` → actualitza tots els documents que compleixen la condició
- `replaceOne()` → substitueix el document complet

📌 Exemple d'actualitzar el sou d'un empleat:

```javascript
db.employees.updateOne({ name: "Clara" }, { $set: { salary: 2200 } })
```

📌 Exemple d'incrementar el sou de tots els majors de 25 anys:

```javascript
db.employees.updateMany({ age: { $gt: 25 } }, { $inc: { salary: 100 } })
```

📌 Exemple en aplicar un augment percentual del 5% als menors de 26 anys:

```javascript
db.employees.updateMany({ age: { $lte: 25 } }, { $mul: { salary: 1.05 } })
```

📌 Exemple per substituir completament un document:

```javascript
db.employees.replaceOne(
  { name: "Clara" },
  { DNI: "98765432X", name: "Manel", salary: 1600, age: 24 }
)
```

#### Eliminació de documents

📌 Exemple, per esborrar documents podem fer servir: 

```javascript
db.employees.deleteOne({ name: "Manel" })
```

> [!NOTE]
> Només eliminarà el **primer document** que coincideixi amb el filtre.

📌 Exemple en cas que volem eliminar tots els documents amb aquest nom: 

Utilitzem `deleteMany()`:

```javascript
db.employees.deleteMany({ name: "Manel" })
```

> [!NOTE]
> És important destacar que, a diferència dels SGBD relacionals amb claus primàries úniques, a MongoDB pots tenir diversos documents amb el mateix valor en un camp si no el defineixes com a únic (unique). Per això, la distinció entre `deleteOne` i `deleteMany` és **essencial** per evitar errors no desitjats.
