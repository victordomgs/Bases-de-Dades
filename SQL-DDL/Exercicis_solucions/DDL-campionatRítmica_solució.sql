DROP DATABASE IF EXISTS CampionatRítmica;

CREATE DATABASE CampionatRítmica;

USE CampionatRítmica;

CREATE TABLE Persones (
    numFitxa INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    cognom1 VARCHAR(50) NOT NULL,
    cognom2 VARCHAR(50)
);

CREATE TABLE Jutgesses (
    numFitxa INT PRIMARY KEY,
    adress VARCHAR(100),
    internacional BOOLEAN,
    DNI CHAR(9),
    FOREIGN KEY (numFitxa) REFERENCES Persones(numFitxa)
);

CREATE TABLE Idiomes (
    codi INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE Idiomes_jutgesses (
    numFitxa INT,
    codi_idioma INT NOT NULL,
    PRIMARY KEY (numFitxa, codi_idioma),
    FOREIGN KEY (numFitxa) REFERENCES Jutgesses(numFitxa),
    FOREIGN KEY (codi_idioma) REFERENCES Idiomes(codi)
);

CREATE TABLE Entrenadors (
    numFitxa INT PRIMARY KEY,
    adress VARCHAR(100),
    titulacio VARCHAR(50),
    DNI CHAR(9),
    FOREIGN KEY (numFitxa) REFERENCES Persones(numFitxa)
);

CREATE TABLE Clubs (
    nom VARCHAR(50) PRIMARY KEY,
    adress VARCHAR(100),
    provincia VARCHAR(50),
    nomPresident VARCHAR(50)
);

CREATE TABLE Gimnastes (
    numFitxa INT PRIMARY KEY,
    dataNaixement DATE,
    suplent BOOLEAN,
    nomClub VARCHAR(50) NOT NULL,
    numFitxa_Entrenador INT,
    FOREIGN KEY (numFitxa) REFERENCES Persones(numFitxa),
    FOREIGN KEY (nomClub) REFERENCES Clubs(nom),
    FOREIGN KEY (numFitxa_Entrenador) REFERENCES Entrenadors(numFitxa)
);

CREATE TABLE Entrenador_Club (
    numFitxa INT,
    nomClub VARCHAR(50),
    data_inici DATE,
    data_fi DATE,
    PRIMARY KEY (numFitxa, nomClub),
    FOREIGN KEY (numFitxa) REFERENCES Entrenadors(numFitxa),
    FOREIGN KEY (nomClub) REFERENCES Clubs(nom)
);

CREATE TABLE Exercicis (
    codi INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE ExercicisRealitzats (
    exerciciRealitzatId INT PRIMARY KEY,
    codi_exercici INT,
    numero_fitxaGimnasta INT,
    numero_fitxaJutgessa INT,
    qualificacio DECIMAL(5, 2),
    FOREIGN KEY (codi_exercici) REFERENCES Exercicis(codi),
    FOREIGN KEY (numero_fitxaGimnasta) REFERENCES Gimnastes(numFitxa),
    FOREIGN KEY (numero_fitxaJutgessa) REFERENCES Jutgesses(numFitxa)
);
