## ONG

**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

**Socis**(<ins>soci_id</ins>, nom, cognom1, cognom2, sexe)<br>

**Seus**(<ins>seu_id</ins>, nom, nif, adreça, telefon, president)<br>

**Pertinença**(<ins>pertinença_id</ins>, soci_id, seu_id)<br>
    on *soci_id* referencia *Socis*.<br>
    on *seu_Id* referencia *Seus*.

**Voluntaris**(<ins>voluntari_id</ins>, nom, cognom1, cognom2, seu_id, edat, sexe, telefon, adreça)<br>

**Administratius**(<ins>voluntari_id</ins>, carrec, estudis)
    on *voluntari_id* referencia *Voluntaris*.<br>

**Sanitaris**(<ins>voluntari_id</ins>, especialitat, experiencia)
    on *voluntari_id* referencia *Voluntaris*.<br>

**e_humanitari**(<ins>e_humanitari_id</ins>, voluntari_id, envio_id, destinacio, data_ini, data_fi)
    on *voluntari_id* referencia *Voluntaris*.<br>
    on *envio_id* referencia *Enviament*.<br>

**e_material**(<ins>e_material_id</ins>, envio_id, destinacio, quantitat)
    on *envio_id* referencia *Enviament*.<br>

**e_aliment**(<ins>e_aliment_id</ins>, codi_material, caducitat, tipus, liquidS/N)
    on *codi_material* referencia *e_material*.<br>

**e_medicament**(<ins>e_medicament_id</ins>, codi_material, caducitat, alergens, oralS/N, perillS/N)
    on *codi_material* referencia *e_material*.<br>

**Enviaments**(<ins>enviament_id</ins>, seu_id, data, prioritat)
    on *seu_id* referencia *Seus*.<br>

## Diagrama E/R

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/ERR-protectora.png" alt="EER-protectora" width="885" height="auto"/>
  </div>
