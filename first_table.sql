CREATE TABLE client (
    id INT(6) PRIMARY KEY AUTO_INCREMENT, -- primary key preferable on int for performance
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    prenom VARCHAR(30) NOT NULL,
    nom VARCHAR(30),
    email VARCHAR(100) UNIQUE,
    solde DECIMAL(8,2) DEFAULT 0.0 -- 999_999.99 / -999_999.99
            -- (total , number of digits after the coma) 
    --FOREIGN KEY 
    -- CONSTRAINT pk_client PRIMARY KEY (prenom, nom)   
)
