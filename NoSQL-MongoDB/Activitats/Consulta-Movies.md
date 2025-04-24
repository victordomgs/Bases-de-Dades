## Consulta DataBase Movies

Descarrega el següent [fitxer](https://github.com/neelabalan/mongodb-sample-dataset/blob/main/sample_mflix/movies.json) i resolt les següents preguntes. 

Importa la base de dades utilitzant la següent comanda:

```javascript
mongoimport --db mflix --collection movies --file ~/Baixades/movies.json
```

### Exercicis

1. Troba totes les dades de la pel·lícula que té com a títol "Traffic in Souls".

2. Troba el document que s’ha inserit a la posició 2421.
   
3. Sabent que hem importat 29470 documents, mostra els 5 últims.

4. Mostra totes les pel·lícules produïdes als Estats Units (countries conté "USA").
  
5. Mostra totes les pel·lícules produïdes als Estats Units amb més de 5000 vots a IMDb.

6. Troba totes les pel·lícules que són dels Estats Units o tenen una puntuació IMDb superior a 8.
   
7. Troba totes les pel·lícules el títol de les quals comença per la lletra “Z”.
   
8. Mostra totes les pel·lícules dirigides per directors dels Estats d’Oregon (OR) o Nova York (NY).
   
9. Afegeix una nova pel·lícula amb estructura similar a la resta.
    
10. Afegeix dues pel·lícules noves amb una única sentència.
