## Campionat Rítmica

**Exercici creat per Isabel De Andrés**
<br>
---
**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

**Persones**(<ins>numFitxa</ins>, nom, cognom1, cognom2)

**Jutgesses**(<ins>numFitxa</ins>, adreça, internacional, DNI)<br>
  on *numFitxa* referencia *Persones*.

**Idiomes**(<ins>codi</ins>, nom)

**Idiomes_jutgesses**(<ins>numFitxa</ins>, <ins>codi_idioma</ins>)<br>
  on *numFitxa* referencia *Jutgesses*.<br> 
  on *numFitxa* referencia *Idiomes*. 

**Entrenadors**(<ins>numFitxa</ins>, adreça, titulacio, DNI)<br>
  on *numFitxa* referencia *Persones*.<br>

**Gimnastes**(<ins>numFitxa</ins>, dataNaixement, suplent, nomClub, numFitxa_Entrenador)<br>
  on *numFitxa* referencia *Persones*.<br>
  on *nomClub* referencia *Clubs*.<br>
  on *numFitxa_Entrenador* referencia *Entrenadors*.

**Clubs**(<ins>nom</ins>, adreça, provincia, nomPresident)<br>
  on *numFitxa* referencia *Gimnastes*.

**Entrenador_Club**(<ins>numFitxa</ins>, <ins>nomClub</ins>, data_inici, data_fi)<br>
  on *numFitxa* referencia *Entrenadors*.<br>
  on *nomClub* referencia *Clubs*.

**Exercicis**(<ins>codi</ins>, nom)

**ExercicisRealitzats**(<ins>exerciciRealitzatId</ins>, codi_exercici, numero_fitxaGimnasta, numero_fitxaJutgessa, qualificacio)<br>
  on *numero_fitxaGimnasta* referencia *Gimnastes*.<br>
  on *numero_fitxaJutgessa* referencia *Jutgesses*.<br>
  on *codi_exercici* referencia *Exercicis*.
  


<ins>**Diagrama E/R**</ins>

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/EER-campionatR%C3%ADtmica.png" alt="EER-protectora" width="885" height="auto"/>
  </div>
