DROP DATABASE IF EXISTS Biblioteca;

CREATE DATABASE Biblioteca;

USE Biblioteca;

CREATE TABLE Autors (
    autor_id INT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    nacionalitat VARCHAR(100)
);

CREATE TABLE Llibres (
    llibre_id INT PRIMARY KEY,
    titol VARCHAR(255) NOT NULL,
    any INT,
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES Autors(autor_id)
);

CREATE TABLE Usuaris (
    usuari_id INT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Prestecs (
    prestec_id INT PRIMARY KEY,
    usuari_id INT,
    llibre_id INT,
    data_prestec DATE NOT NULL,
    data_retorn DATE,
    FOREIGN KEY (usuari_id) REFERENCES Usuaris(usuari_id),
    FOREIGN KEY (llibre_id) REFERENCES Llibres(llibre_id)
);
