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

En el cas del format JSON, el Javascript pot interpretar els documents com si fossin objectes directament. Altres llenguatges tenen estructures que faciliten el tractament de parelles camp-valor, com els diccionaris.

- Els documents permeten emmagatzemar les dades en estructures que són
impossibles en una BD relacional. Per exemple, un camp pot contenir un
array com a valor (i ésser per tant una propietat multivaluada, concepte que
no es pot implementar en el model relacional). O un document en format d’arbre
pot contenir molta informació niuada, cosa que evita l’ús extensiu de **joins**.

Les BD relacionals han tingut (i tenen) molt èxit perquè es basen en un
model que permeten donar resposta teòricament a qualsevol consulta. Però
la fragmentació de dades en moltes taules obliga a crear consultes molt
complexes i poc eficients, en què s’han d’unir moltes taules i, per tant,
consultar molts registres, per donar resposta a consultes habituals.


En canvi, en els BD documentals, el format dels documents no es dissenya
genèricament, sinó que s’adapta a les necessitats concretes de l’aplicació
que es vol desenvolupar, de manera que les consultes més habituals es
puguin resoldre consultant únicament un document.


Això fa que el rendiment d’un sistema documental pugui ser molt alt si
els documents s’han dissenyat bé i s’han creat els índexs adequats, tot i
que algunes consultes complexes que impliquin diversos documents siguin
més lentes que en un sistema relacional.

- Contràriament al sistema relacional, els documents permeten una gran
variabilitat en les dades. Per exemple, podem tenir documents on apareguin
camps que en d’altres documents no hi siguin, i documents amb estructures
molt diferents entre ells emmagatzemats a la mateixa col·lecció. Fins i tot,
els documents es poden modificar i afegir o treure camps dinàmicament.

Això fa idoni els sistemes documentals per aquelles aplicacions en què
la diversitat de les dades a tractar complica la creació d’un bon
model relacional.

### 1.1. Instal·lació
