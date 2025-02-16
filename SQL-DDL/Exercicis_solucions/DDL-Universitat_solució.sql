DROP DATABASE IF EXISTS Universitat;

CREATE DATABASE Universitat;

USE Universitat;

CREATE TABLE Countries (
    name VARCHAR(100) PRIMARY KEY,
    population INT NOT NULL
);

CREATE TABLE Universities (
    code_university INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100),
    FOREIGN KEY (country) REFERENCES Countries(name)
);

CREATE TABLE Students (
    code_student INT PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    country VARCHAR(100),
    university_code INT,
    FOREIGN KEY (country) REFERENCES Countries(name),
    FOREIGN KEY (university_code) REFERENCES Universities(code_university)
);

CREATE TABLE Degrees (
    name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE DegreeOffer (
    university_code INT,
    degree_name VARCHAR(255),
    score DECIMAL(5,2) NOT NULL,
    capacity INT NOT NULL,
    PRIMARY KEY (university_code, degree_name),
    FOREIGN KEY (university_code) REFERENCES Universities(code_university),
    FOREIGN KEY (degree_name) REFERENCES Degrees(name)
);
