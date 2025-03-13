## Activitat Hotel

1. Utilitza l'usuari `postgres` per crear una nova base de dades anomenada `hotel_management`.
2. Crea l'usuari `hoteladmin` amb la contrasenya `hotel123` i fes que sigui el propietari de `hotel_management`.
3. Amb l'usuari `hoteladmin`, crea els següents esquemes a `hotel_management`:
   - `rooms`: informació sobre habitacions.
   - `guests`: informació de clients i reserves.

4. Crea els següents rols amb els privilegis indicats sobre els esquemes anteriors:

| Rol           | rooms      | guests     | Té herència? |
|--------------|-----------|------------|--------------|
| **Reception** | Ús, Creació | Ús         | No           |
| **Manager**   | Ús         | Ús, Creació | Sí           |

5. Crea els següents usuaris i assigna'ls els rols adequats:

| Nom   | Contrasenya | Hereta? | Rols assignats |
|--------|-------------|---------|----------------|
| **carla** | carlapass   | No      | Reception      |
| **david** | davidpass   | Sí      | Manager        |

6. Amb `carla`, crea la taula `Rooms` dins de l'esquema `rooms`:

| Columna     | Tipus         | Especial       |
|------------|--------------|---------------|
| `Id`       | `serial`      | Clau primària |
| `Number`   | `varchar(10)` | Únic          |
| `Type`     | `varchar(50)` |               |
| `Price`    | `decimal(8,2)`|               |

7. Amb `david`, crea la taula `Guests` dins de l'esquema `guests`:

| Columna      | Tipus         | Especial       |
|-------------|--------------|---------------|
| `Id`        | `serial`      | Clau primària |
| `Name`      | `varchar(50)` |               |
| `RoomId`    | `integer`     | Referència `rooms.Id` |

8. Crea la vista `RoomBookings` que mostri el número d'habitació, tipus i el nom del client amb l'usuari `carla`.

