## Empresa petita

**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

<ins>**Model relacional**</ins>

**Client**(<ins>id_client</ins>, saldo, limit_credit, descompte)

**Direccio_Client**(<ins>id_direccio_client</ins>, id_client, carrer, numero, ciutat)<br>
  on *id_client* referencia *Client*

**Comanda**(<ins>id_comanda</ins>, id_cliente, data)<br>
  on *id_client* referencia *Client*<br>
  on *id_direccio* referencia *Direccio_Envio*

**Direccio_Comanda**(<ins>id_direccio_comanda</ins>, id_comanda, carrer, numero, ciutat)<br>
  on *id_client* referencia *Client*
  
**Article**(<ins>id_article</ins>, id_fabrica, descripcio)<br>
  on *id_fabrica* referencia *Fabrica*
  
**Detalls_comanda**(<ins>id_detalls_comanda</ins>, id_comanda, id_article, quantitat)<br>
  on *id_comanda* referencia *Comanda*<br>
  on *id_article* referencia *Article*

**Fabrica**(<ins>id_fabrica</ins>, nom, telefon)

<ins>**Diagrama E/R**</ins>

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/EER-empresa.png" alt="EER-empresa" width="655" height="auto"/>
  </div>

