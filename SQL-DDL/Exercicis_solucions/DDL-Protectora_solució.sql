DROP DATABASE IF EXISTS protectora;

CREATE DATABASE protectora;

USE protectora;

CREATE TABLE Animals (
	id INT PRIMARY KEY AUTO_INCREMENT,
	AnimalName VARCHAR(100) NOT NULL,
    Race VARCHAR(50),
    Sex ENUM("M", "F") NOT NULL,
    Size INT,
    Species VARCHAR(100),
    Birthday DATE,
    Description TEXT,
    ArrivalDate TIMESTAMP,
    Sterilized BOOL,
    Chip BOOL,
    AdopterDNI VARCHAR(50),
    AdoptionDate TIMESTAMP,
    Foster_id INT,
    FOREIGN KEY (AdopterDNI) REFERENCES Collaborators(DNI),
    FOREIGN KEY (Foster_id) REFERENCES FosterHouses(id)
);

CREATE TABLE Vaccines (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE AnimalVaccines (
	id INT PRIMARY KEY AUTO_INCREMENT,
    Animal_id INT,
    Vaccine_id INT,
    vaccination_date TIMESTAMP,
    FOREIGN KEY (Animal_id) REFERENCES Animals(id),
    FOREIGN KEY (Vaccine_id) REFERENCES Vaccines(id)
);

CREATE TABLE Interventions (
	Animal_id INT,
    intervention_date TIMESTAMP,
    description TEXT,
    type VARCHAR(255),
    PRIMARY KEY(Animal_id, intervention_date),
    FOREIGN KEY (Animal_id) REFERENCES Animals(id)
);

CREATE TABLE Collaborators (
	DNI VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50),
    IBAN VARCHAR(100) NOT NULL,
    Bank VARCHAR(50) NOT NULL,
    AccountNumber VARCHAR(100) NOT NULL,
    Address_id INT NOT NULL,
	FOREIGN KEY (Address_id) REFERENCES Addresses(id)   
);

CREATE TABLE Patronize (
	Patronize_id INT PRIMARY KEY AUTO_INCREMENT,
    DNI VARCHAR(50),
    Animal_id INT,
    StartDate TIMESTAMP,
    Quantity INT, 
    Periodicity INT,
    EndDate TIMESTAMP,
    FOREIGN KEY (DNI) REFERENCES Collaborators(DNI),
    FOREIGN KEY (Animal_id) REFERENCES Animals(id)
);

CREATE TABLE Diseases (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE AnimalDiseases (
	animalDisease_id INT PRIMARY KEY AUTO_INCREMENT,
    Animal_id INT,
    Disease_id INT,
    FOREIGN KEY (Animal_id) REFERENCES Animals(id),
    FOREIGN KEY (Disease_id) REFERENCES Diseases(id)
);

CREATE TABLE FosterHouses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(50) NOT NULL,
    ContactDNI VARCHAR(50),
    Address_id INT NOT NULL,
	FOREIGN KEY (ContactDNI) REFERENCES Collaborators(DNI),
	FOREIGN KEY (Address_id) REFERENCES Addresses(id)   
);

CREATE TABLE Addresses (
	id INT PRIMARY KEY AUTO_INCREMENT,
	AddressLine1 VARCHAR(155) NOT NULL,
    AddressLine2 VARCHAR(155),
    City VARCHAR(50) NOT NULL,
    ZipCode INT NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Province VARCHAR(50) NOT NULL
);

CREATE TABLE Donations (
	DNI VARCHAR(50),
    donation_date TIMESTAMP,
    quantity INT NOT NULL,
    recurring BOOL,
	PRIMARY KEY(DNI, donation_date),
	FOREIGN KEY (DNI) REFERENCES Collaborators(DNI)   
);

CREATE TABLE TimePeriods (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dayofweek ENUM("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
    startTime timestamp,
    endTime timestamp
);

CREATE TABLE Disponibility (
	id INT PRIMARY KEY AUTO_INCREMENT,
    timeperiod_id INT,
    collaboratorDNI VARCHAR(50),
	FOREIGN KEY (collaboratorDNI) REFERENCES Collaborators(DNI),
    FOREIGN KEY (timeperiod_id) REFERENCES TimePeriods(id)   
);
