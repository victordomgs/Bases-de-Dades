## Protectora d'animals

**Exercici creat per Joan Queralt: enllaç[https://gitlab.com/joanq/DAM-M2-BasesDeDades/-/blob/master/UF2/2-DDL/activitats/creacio_taules.adoc?ref_type=heads]**
**A partir del model relacional i del diagrama ER que trobareu a continuació, construeix les sentències CREATE TABLE necessàries per implantar la base de dades corresponent.**

**Animals**(<ins>AnimalName</ins>, Race, Sex, Size, Species, Birthday, Description, ArrivalDate, Sterilized, Chip, AdopterDNI, AdoptionDate, FosterName)  
  on *AdopterDNI* referencia *Collaborators*.  
  on *FosterName* referencia *FosterHouses*.

**Vaccines**(<ins>Name</ins>)

**AnimalVaccines**(<ins>AnimalName</ins>, VaccineName, Date)  
  on *AnimalName* referencia *Animals*.  
  on *VaccineName* referencia *Vaccines*.

**Interventions**(<ins>AnimalName</ins>, Date, Description, Type)  
  on *AnimalName* referencia *Animals*.

**Collaborators**(<ins>DNI</ins>, FirstName, LastName, Email, PhoneNumber, AddressId)  
  on *AddressId* referencia *Addresses*.

**Patrons**(<ins>DNI</ins>, IBAN, Owner, Bank, AccountNumber)  
  on *DNI* referencia *Collaborators*.

**Patronize**(<ins>DNI</ins>, AnimalName, StartDate, Quantity, Periodicity, EndDate)  
  on *DNI* referencia *Patrons*.  
  on *AnimalName* referencia *Animals*.

**Diseases**(<ins>Name</ins>)

**AnimalDisease**(<ins>AnimalName</ins>, DiseaseName)  
  on *AnimalName* referencia *Animals*.  
  on *DiseaseName* referencia *Diseases*.

**FosterHouses**(<ins>Name</ins>, Type, ContactDNI, AddressId)  
  on *ContactDNI* referencia *Collaborators*.  
  on *AddressId* referencia *Addresses*.

**Addresses**(<ins>AddressId</ins>, AddressLine1, AddressLine2, City, ZipCode, Country, Province)

**Donations**(<ins>DNI</ins>, DateTime, Quantity, Recurring)  
  on *DNI* referencia *Collaborators*.

**TimePeriods**(<ins>TimePeriodId</ins>, DayOfWeek, StartTime, EndTime)

**Disponibility**(<ins>TimePeriodId</ins>, CollaboratorDNI)  
  on *TimePeriodId* referencia *TimePeriods*.  
  on *CollaboratorDNI* referencia *Collaborators*.

<ins>**Diagrama E/R**</ins>

  <div style="text-align: center;">
    <img src="https://github.com/victordomgs/Bases-de-Dades/blob/main/SQL-DDL/EER/ERR-protectora.png" alt="EER-protectora" width="885" height="auto"/>
  </div>
