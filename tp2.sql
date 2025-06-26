-- CREATION DES TABLES

DROP TABLE IF EXISTS COMPO;
DROP TABLE IF EXISTS BON;
DROP TABLE IF EXISTS ARTICLE;
DROP TABLE IF EXISTS FOURNISSEUR;

CREATE TABLE ARTICLE (
    ID INT(11) PRIMARY KEY,
    REF VARCHAR(13) NOT NULL,
    DESIGNATION VARCHAR(50) NOT NULL,
    PRIX DECIMAL(7, 2) NOT NULL,
    ID_FOU INT(11) NOT NULL
);


CREATE TABLE FOURNISSEUR (
    ID INT(11) PRIMARY KEY,
    NOM VARCHAR(25) NOT NULL
);


CREATE TABLE BON (
    ID INT(11) PRIMARY KEY AUTO_INCREMENT,
    NUMERO INT(11) NOT NULL,
    DATE_CMDE DATETIME NOT NULL,
    DELAI INT(11) NOT NULL,
    ID_FOU INT(11) NOT NULL
);

;
CREATE TABLE COMPO (
    ID INT(11) PRIMARY KEY AUTO_INCREMENT,
    QTE INT(11) NOT NULL,
    ID_BON INT(11) NOT NULL,
    ID_ART INT(11) NOT NULL
);

ALTER TABLE ARTICLE
    ADD CONSTRAINT FK_ART_FOU FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID);
ALTER TABLE BON
    ADD CONSTRAINT FK_BON_FOU FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID);
ALTER TABLE COMPO
    ADD CONSTRAINT FK_COMPO_BON FOREIGN KEY (ID_BON) REFERENCES BON(ID);
ALTER TABLE COMPO
    ADD CONSTRAINT FK_COMPO_ART FOREIGN KEY (ID_ART) REFERENCES ARTICLE(ID);
-- INSERTION FOURNISSEUR
-- 1,'Française d'imports'
-- 2,'FDM SA'
-- 3,'Dubois & Fils'
INSERT INTO FOURNISSEUR (ID, NOM) VALUES
(1, 'Française d''imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

-- INSERTION ARTICLE
-- 1, 'A01', 'Perceuse P1', 74.99, 1
-- 2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2
-- 3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2
-- 4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3
-- 5, 'A02', 'Meuleuse 125mm', 37.85, 1
-- 6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3
-- 7, 'A03', 'Perceuse à colonne', 185.25, 1
-- 8, 'D04', 'Coffret mêches à bois', 12.25, 3
-- 9, 'F03', 'Coffret mêches plates', 6.25, 2
-- 10, 'F04', 'Fraises d''encastrement', 8.14, 2
INSERT INTO ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) VALUES
(1, 'A01', 'Perceuse P1', 74.99, 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
(5, 'A02', 'Meuleuse 125mm', 37.85, 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3),
(7, 'A03', 'Perceuse à colonne', 185.25, 1),
(8, 'D04', 'Coffret mêches à bois', 12.25, 3),
(9, 'F03', 'Coffret mêches plates', 6.25, 2),
(10, 'F04', 'Fraises d''encastrement', 8.14, 2);


-- INSERTION BON
-- Insertion du bon de commande auprès du fournisseur "Française d'Imports"
INSERT INTO BON (ID, NUMERO, DATE_CMDE, DELAI, ID_FOU) VALUES
(1, 001, '2025-06-26 10:00:00', 3, 1);

-- INSERTION COMPO
-- Insertion de la composition du bon de commande n°001
-- 3 Perceuses P1
-- 4 Meuleuses 125mm
-- 1 Perceuse à colonne
INSERT INTO COMPO ( QTE, ID_BON, ID_ART) VALUES
(3, 1, 1), -- 3 Perceuses P1
(4, 1, 5), -- 4 Meuleuses 125mm
(1, 1, 7); -- 1 Perceuse à colonne  

