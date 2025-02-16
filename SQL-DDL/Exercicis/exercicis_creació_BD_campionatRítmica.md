## Campionat Rítmica

**Exercici creat per Isabel De Andrés**
<br>
---
**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

**Persones**(<ins>numFitxa</ins>, nom, cognom1, cognom2)

**Jutgesses**(<ins>numFitxa</ins>, adreça, internacional, DNI)
  on *numFitxa* referencia *Persones*. 

**Idiomes**(<ins>codi</ins>, nom)

**Idiomes_jutgesses**(<ins>numFitxa</ins>, <ins>codi_idioma</ins>)
  on *numFitxa* referencia *Jutgesses*. 
  on *numFitxa* referencia *Idiomes*. 

**Entrenadors**(<ins>numFitxa</ins>, adreça, titulacio, DNI)
  on *numFitxa* referencia *Persones*.

**Gimnastes**(<ins>numFitxa</ins>, dataNaixement, suplent, nomClub, numFitxa_Entrenador)
  on *numFitxa* referencia *Persones*.
  on *nomClub* referencia *Clubs*.
  on *numFitxa_Entrenador* referencia *Entrenadors*.

**Clubs**(<ins>nom</ins>, adreça, provincia, nomPresident)
  on *numFitxa* referencia *Gimnastes*.

**Entrenador_Club**(<ins>numFitxa</ins>, <ins>nomClub</ins>, data_inici, data_fi)
  on *numFitxa* referencia *Entrenadors*.
  on *nomClub* referencia *Clubs*.

**Exercicis**(<ins>codi</ins>, nom)

**ExercicisRealitzats**(<ins>exerciciRealitzatId</ins>, codi_exercici, numero_fitxaGimnasta, numero_fitxaJutgessa, qualificacio)
  on *numero_fitxaGimnasta* referencia *Gimnastes*.
  on *numero_fitxaJutgessa* referencia *Jutgesses*.
  on *codi_exercici* referencia *Exercicis*.
  


<ins>**Diagrama E/R**</ins>

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/EER-campionatR%C3%ADtmica.png" alt="EER-protectora" width="885" height="auto"/>
  </div>
