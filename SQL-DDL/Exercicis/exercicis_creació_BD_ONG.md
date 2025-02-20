## ONG

**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

**Socis**(<ins>soci_id</ins>, nom, cognom1, cognom2, sexe)<br>

**Seus**(<ins>seu_id</ins>, nom, nif, adreça, telefon, president)<br>

**Pertinença**(<ins>pertinença_id</ins>, soci_id, seu_id)<br>
    on *soci_id* referencia *Socis*.<br>
    on *seu_Id* referencia *Seus*.

**Voluntari**(<ins>voluntari_id</ins>, nom, cognom1, cognom2, seu_id, edat, sexe, telefon, adreça)<br>


