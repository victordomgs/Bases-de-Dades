## Activitat Gestió de Cinema

1. Utilitza l'usuari `postgres` per crear una nova base de dades anomenada `cinema_management`.

2. Crea l'usuari `cinemaadmin` amb la contrasenya `cinema123` i fes que sigui el propietari de `cinema_management`.

3. Amb l'usuari `cinemaadmin`, crea els següents esquemes a `cinema_management`:
   - `movies` : informació sobre pel·lícules i gèneres.
   - `sessions` : informació sobre projeccions i horaris.
   - `staff` : informació sobre treballadors del cinema.

4. Crea els següents rols amb els privilegis indicats sobre els esquemes anteriors:

| **Rol**      | **movies**       | **sessions**      | **staff**       |
|-------------|----------------|----------------|---------------|
| **Projectionist** | No             | Ús, Creació      | No             |
| **TicketSeller**  | Ús             | Ús              | No             |
| **Manager**       | Ús, Creació    | Ús, Creació      | Ús, Creació    |

5. Crea els següents usuaris i assigna'ls els rols adequats:

| **Nom**    | **Contrasenya** | **Rols assignats** |
|-----------|--------------|----------------|
| `laura`  | `laurapass` | Projectionist  |
| `marc`   | `marcpass`  | TicketSeller   |
| `ana`    | `anapass`   | Manager        |

