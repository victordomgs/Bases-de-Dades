## Activitat Campionat Esportiu

1. Utilitza l'usuari `postgres` per crear una nova base de dades anomenada `championship_management`.

2. Crea l'usuari `champadmin` amb la contrasenya `champ123` i fes que sigui el propietari de `championship_management`.

3. Amb l'usuari `champadmin`, crea els següents esquemes a `championship_management`:
   - `teams` : informació sobre equips i jugadors.
   - `matches` : informació sobre partits i resultats.
   - `staff` : informació sobre entrenadors i àrbitres.

4. Crea els següents rols amb els privilegis indicats sobre els esquemes anteriors:

| **Rol**      | **teams**           | **matches**         | **staff**       |
|-------------|--------------------|--------------------|---------------|
| **Coach**   | Ús                 | No                 | Ús, Creació    |
| **Referee** | No                 | Ús, Creació        | Ús             |
| **Manager** | Ús, Creació         | Ús                 | Ús, Creació    |

5. Crea els següents usuaris i assigna'ls els rols adequats:

| **Nom**    | **Contrasenya** | **Rols assignats** |
|-----------|--------------|----------------|
| `marta`  | `martapass` | Coach         |
| `jordi`  | `jordipass` | Referee       |
| `alex`   | `alexpass`  | Manager       |

