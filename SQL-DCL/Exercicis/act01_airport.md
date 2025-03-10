## Activitat airport

1. Utilitza l'usuari `postgres` per a crear una nova base de dades anomenada `airport`.
2. Crear l'usuari `airadmin`, que podrà crear altres usuaris. Fes que sigui el propietari de `airports`. Assigna `llamps_i_trons` com a contrasenya d'aquest usuari.
3. Utilitzant l'usuari `airadmin`, crea els següents esquemes a `airports`:
   - `flights`: contindrà informació sobre cadascun dels vols.
   - `aircrafts`: informació dels avions, fabricants, i línies.
   - `passengers`: informació dels passatges i les reserves.
4. Amb l'usuari `airadmin`, crea els següents rols, amb els privilegis indicats sobre els esquemes anteriors. Verifica que els privilegis s'han assignat correctament.

| Rol               | flights        | aircrafts      | passengers      | Té herència? |
|------------------|--------------|--------------|--------------|--------------|
| **GroundControl**    | Ús           | Ús           | Ús           | Sí           |
| **AirTrafficControl** | Ús, Creació  | Ús           |              | No           |
| **TicketSeller**     | Ús           | Ús           | Ús, Creació  | No           |
| **Manager**         | Ús           | Ús, Creació  |              | Sí           |

5. Segueix amb l'usuari `airadmin`. Els següents rols es corresponen als usuaris reals, així que hauran de tenir permís per connectar-se a la base de dades, a banda dels següents privilegis:

| Nom   | Contrasenya | Hereta? | Rols assignats                  |
|--------|-------------|---------|---------------------------------|
| **maria** | maria       | No      | Manager i AirTrafficControl    |
| **pere**  | pere        | Sí      | GroundControl i TicketSeller   |
| **pau**   | pau         | Sí      | AirTrafficControl              |
| **anna**  | anna        | No      | GroundControl i Manager        |

6. Utilitza l'usuari `maria` per crear les taules de l'esquema `aircrafts`:

> [!NOTE]  
> Recorda que `maria` no hereta automàticament els privilegis dels rols que té assignats.

| Columna       | Tipus         | Especial       |
|--------------|--------------|---------------|
| `Id`         | `serial`      | Clau primària |
| `ICAOCode`   | `char(3)`     | Únic          |
| `Name`       | `varchar(50)` |               |
| `Country`    | `varchar(40)` |               |
| `OtherDetails` | `text`      |               |

**Table 1.** `Airlines

| Columna       | Tipus         | Especial       |
|--------------|--------------|---------------|
| `Id`         | `serial`      | Clau primària |
| `ICAOCode`   | `varchar(50)` | Únic          |
| `Name`       | `varchar(100)`|               |
| `OtherDetails` | `text`      |               |

**Table 2.** `Manufacturers`

| Columna          | Tipus         | Especial                           |
|-----------------|--------------|-----------------------------------|
| `Id`            | `serial`      | Clau primària                    |
| `Code`          | `varchar(10)` | Únic                              |
| `ManufacturerId`| `integer`     | Referencia `Manufacturers.Id`    |
| `Name`          | `varchar(100)`|                                   |
| `Capacity`      | `smallint`    |                                   |
| `Weight`        | `int`         |                                   |
| `OtherDetails`  | `text`        |                                   |

**Table 3.** `AircraftModels

| Columna          | Tipus         | Especial                           |
|-----------------|--------------|-----------------------------------|
| `Id`            | `serial`      | Clau primària                    |
| `AirlineId`     | `integer`     | Referencia `Airlines.Id`         |
| `RegistrationId`| `varchar(10)` | Únic                              |
| `ModelId`       | `integer`     | Referencia `AircraftModels.Id`   |
| `Name`          | `varchar(100)`|                                   |
| `OtherDetails`  | `text`        |                                   |

**Table 4.** `Aircrafts`

7. També amb l’usuari `maria`, crea ara les taules de l’esquema `flights`:

> [!NOTE]  
> Per crear les claus foranes, assigna els permisos mínims necessaris als rols que ho necessitin. En particular, recorda que, per fer una clau forana, es necessita el privilegi `references` sobre la taula origen i la taula destí de la clau forana.

| Columna       | Tipus         | Especial       |
|--------------|--------------|---------------|
| `Id`         | `serial`      | Clau primària |
| `AirportCode`| `char(6)`     |               |
| `Terminal`   | `varchar(2)`  |               |
| `City`       | `varchar(100)`|               |
| `CityCode`   | `char(3)`     |               |
| `Country`    | `varchar(100)`|               |
| `CountryCode`| `char(3)`     |               |

**Table 5.** `Airports`

| Columna         | Tipus                   | Especial                     |
|---------------|------------------------|-----------------------------|
| `Id`         | `serial`                | Clau primària               |
| `AircraftId` | `integer`               | Referencia `Aircrafts.Id`   |
| `DepartureTime` | `time`                 |                             |
| `ArrivalTime`   | `time`                 |                             |
| `FlightDuration` | `interval hour to minute` |                             |

**Table 6.** `ActualFlights`

| Columna         | Tipus                   | Especial                                  |
|---------------|------------------------|------------------------------------------|
| `Id`         | `serial`                | Clau primària                            |
| `FlightCode` | `char(6)`               |                                          |
| `ActualFlightId` | `integer`            | Referencia `ActualFlights.Id`, pot ser null |
| `AirlineId`  | `integer`               | Referencia `Airlines.Id`                 |
| `Date`       | `date`                   |                                          |
| `DepartureTime` | `time`                |                                          |
| `ArrivalTime`   | `time`                |                                          |
| `Origin`    | `integer`                | Referencia `Airports.Id`                 |
| `Destination` | `integer`               | Referencia `Airports.Id`                 |
| `FlightDuration` | `interval hour to minute` |                                          |

**Table 7.** `FlightSchedules`

8. Utilitza l'usuari `pere` per a crear les taules de l'esquema `passengers``. Quins permisos li hem d'atorgar a aquest usuari, com a mínim, per a poder-ho fer?

| Columna         | Tipus          | Especial       |
|---------------|--------------|---------------|
| `Id`         | `serial`      | Clau primària |
| `FirstName`  | `varchar(50)` |               |
| `LastName`   | `varchar(100)`|               |
| `CountryCode` | `char(3)`     |               |
| `DocumentNumber` | `varchar(15)` |            |
| `DocumentType` | `varchar(40)` |               |
| `Email`      | `varchar(100)`|               |
| `PhoneNumber` | `varchar(15)` |               |
| `OtherDetails` | `text`       |               |

**Table 8.** `Passengers

| Columna            | Tipus         | Especial                              |
|------------------|--------------|--------------------------------------|
| `Id`            | `serial`      | Clau primària                        |
| `Code`          | `char(6)`     | Únic                                 |
| `FlightScheduleId` | `int`       | Referencia `FlightSchedules.Id`      |

**Table 9.** `Reservations`

| Columna            | Tipus         | Especial                              |
|------------------|--------------|--------------------------------------|
| `Id`            | `serial`      | Clau primària                        |
| `PassengerId`   | `int`         | Referencia `Passengers.Id`           |
| `ReservationId` | `int`         | Referencia `Reservations.Id`         |
| `Seat`         | `varchar(5)`  |                                      |

**Table 10.** `PassengerReservations`

9. Volem crear la vista `ReservationsInfo` amb informació compactada sobre les reserves. Volem que es mostri el codi de reserva, la quantitat de passatgers, la data i codi del vol, l’origen i el destí, i l’hora de sortida i arribada. Crea aquesta vista amb l’usuari `pere`.

10. Amb l’usuari `maria`, crearem una segona vista anomenada `AircraftsView` que mostrarà les dades dels avions, incloent el model, el nom del seu fabricant i el de la companyia aèria a qui pertany.
