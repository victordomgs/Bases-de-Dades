# Biblioteca de l'INS Sabadell

**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

---

### Model relacional

**Llibres**(<ins>llibre_id</ins>, títol, any, autor_id)
  on *autor_id* referencia *Autors*.

**Autors**(<ins>autor_id</ins>, nom, nacionalitat)

**Usuaris**(<ins>usuari_id</ins>, nom, email)

**Préstecs**(<ins>prestec_id</ins>, usuari_id, llibre_id, data_prestec, data_retorn)
  on *usuari_id* referencia *Usuaris*.
  on *llibre_id* referencia *Llibres*.

### Diagrama E/R

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/EER-bibliotecaINSSabadell.png" alt="EER-bibliotecaINSSabadell" width="655" height="auto"/>
  </div>
