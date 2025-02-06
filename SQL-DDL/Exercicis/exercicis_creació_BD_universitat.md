## Universitats d'Europa

**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

<ins>**Model relacional**</ins>

**Countries**(<ins>name</ins>, population)

**Universities**(<ins>code_university</ins>, name, country)
  on *country* referencia *Countries*.
  
**Students**(<ins>code_student</ins>, firstName, lastName, Phone, Country, university_code)
  on *country* referencia *Countries*.
  on *university_code* referencia *Universities*.

**Degrees**(<ins>name</ins>)

**DegreeOffer**(<ins>university_code</ins>, <ins>degree_name</ins>, score, capacity)
  on *university_code* referencia *Universities*.
  on *degree_name* referencia *Degrees*.

<br>

<ins>**Diagrama E/R**</ins>

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/EER-universitatEuropa.png" alt="EER-universitatEuropa" width="1303" height="auto"/>
  </div>
