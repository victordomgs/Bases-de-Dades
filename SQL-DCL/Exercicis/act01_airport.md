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
