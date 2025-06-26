DROP DATABASE IF EXISTS banque;
CREATE DATABASE banque;
USE banque;


CREATE TABLE IF NOT EXISTS 
    Persons (
        PersonID INT,
        LastName VARCHAR(255),
        FirstName VARCHAR(255),
        Address VARCHAR(255),
        City VARCHAR(255),
        Curdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO Persons (PersonID, LastName, FirstName, Address, City) VALUES
(1, 'Doe', 'John', '123 Elm St', 'Springfield'),
(2, 'Smith', 'Jane', '456 Oak St', 'Shelbyville'),
(3, 'Brown', 'Charlie', '789 Pine St', 'Capital City');

DROP TABLE IF EXISTS Persons;

CREATE TABLE IF NOT EXISTS 
    client (
        id INT(11) PRIMARY KEY AUTO_INCREMENT, -- primary key preferable on int for performance
        date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        prenom VARCHAR(30) NOT NULL,
        nom VARCHAR(30),
        
    );

CREATE TABLE IF NOT EXISTS 
    compte (
        id INT(6) PRIMARY KEY AUTO_INCREMENT,
        type ENUM('courant', 'epargne') NOT NULL,
        solde DECIMAL(12,2) DEFAULT 0.0, -- 999_999.99 / -999_999.99
        client_id INT(11),
    );

ALTER TABLE compte
    ADD CONSTRAINT fk_compte_client FOREIGN KEY (client_id) REFERENCES client(id);

-- CREATE TABLE IF NOT EXISTS
--     asso_client_comptes (
--         clientId INT(6),
--         compteId INT(6),
--         PRIMARY KEY (clientId, compteId),
--         FOREIGN KEY (clientId) REFERENCES client(id),
--         FOREIGN KEY (compteId) REFERENCES compte(id)
--     );

