## Festival de Música

**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

**Recintes**(<ins>nom_recinte</ins>, aforament, m2escena, m2public, lavabosS/N, cobertS/N)

**Carrers**(<ins>codi_carrer</ins>, nom_carrer)

**Parcel·les**(<ins>num_parc</ins>, m2, preu_hora, <ins>codi_carrer</ins>, usuari)<br>
    on *codi_carrer* referencia *Carrers*.<br>
    on *usuari* referencia *Persones*.

**Grups**(<ins>nom_grup</ins>, país, nombre_music)

**Webs**(<ins>nom_web</ins>, URL, NIF)

**Persones**(<ins>usuari</ins>, password, <ins>DNI/passaport, mail, nom, cognom1, cognom2, adreça, ciutat, codipostal, telefon)

**Actuacions**(<ins>nom_recinte</ins>, nom_grup, dataHora_actuacio, catxè)<br>
    on *nom_recinte* referencia *Recintes*.<br>
    on *nom_grup* referencia *Grups*.
    
**Compres**(<ins>nom_web</ins>, usuari, numentrades, dataHora_compra)<br>
    on *nom_web* referencia *Webs*.<br>
    on *usuari* referencia *Persones*.

**Substitucions**(<ins>nom_grup1</ins>, <ins>nom_grup2</ins>)<br>
    on *nom_grup1* referencia *Grups*.<br>
    on *nom_grup2* referencia *Grups*.

<br>
## Diagrama E/R

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/EER-festivalM%C3%BAsica.png" alt="EER-festivalMúsica" width="885" height="auto"/>
  </div>

---
*Exercici creat per Isabel De Andrés*
