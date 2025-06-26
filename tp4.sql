-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT * FROM ARTICLE
ORDER BY DESIGNATION;
-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT * FROM ARTICLE
ORDER BY PRIX DESC;
-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * FROM ARTICLE
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX ASC;
-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM ARTICLE
WHERE DESIGNATION LIKE '%sachet%';
-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT * FROM ARTICLE
WHERE LOWER(DESIGNATION) LIKE '%sachet%';
-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT A.*, F.NOM AS NOM_FOURNISSEUR
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
ORDER BY F.NOM, A.PRIX DESC;
-- g. Listez les articles de la société « Dubois & Fils »
SELECT * FROM ARTICLE
WHERE ID_FOU = (SELECT ID FROM FOURNISSEUR WHERE NOM = 'Dubois & Fils');
-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(PRIX) AS MOYENNE_PRIX
FROM ARTICLE
WHERE ID_FOU = (SELECT ID FROM FOURNISSEUR WHERE NOM = 'Dubois & Fils');
-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT F.NOM AS NOM_FOURNISSEUR, AVG(A.PRIX) AS MOYENNE_PRIX
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
GROUP BY F.NOM;
-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT * FROM BON
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';
-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT B.*
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
WHERE A.DESIGNATION LIKE '%boulon%';
-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT B.*, F.NOM AS NOM_FOURNISSEUR
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
JOIN FOURNISSEUR F ON B.ID_FOU = F.ID
WHERE A.DESIGNATION LIKE '%boulon%';
-- m. Calculez le prix total de chaque bon de commande
SELECT B.ID, SUM(A.PRIX * C.QTE) AS PRIX_TOTAL
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
GROUP BY B.ID;
-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT B.ID, COUNT(C.ID_ART) AS NOMBRE_ARTICLES
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
GROUP BY B.ID;
-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
SELECT B.NUMERO, COUNT(C.ID_ART) AS NOMBRE_ARTICLES
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
GROUP BY B.NUMERO
HAVING COUNT(C.ID_ART) > 25;
-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT SUM(A.PRIX * C.QTE) AS COUT_TOTAL
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
WHERE B.DATE_CMDE LIKE '____-04-%';


-- q. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents (indice : réaliser une auto-jointure i.e. de la table avec elle-même)
SELECT A1.DESIGNATION, A1.ID_FOU AS ID_FOU_1, A2.ID_FOU AS ID_FOU_2
FROM ARTICLE A1
JOIN ARTICLE A2 ON A1.DESIGNATION = A2.DESIGNATION AND A1.ID_FOU <> A2.ID_FOU
GROUP BY A1.DESIGNATION, A1.ID_FOU, A2.ID_FOU
ORDER BY A1.DESIGNATION, A1.ID_FOU, A2.ID_FOU;


-- r. Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions MONTH et YEAR)
SELECT YEAR(B.DATE_CMDE) AS ANNEE, MONTH(B.DATE_CMDE) AS MOIS, SUM(A.PRIX * C.QTE) AS DEPENSES
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
GROUP BY YEAR(B.DATE_CMDE), MONTH(B.DATE_CMDE)
ORDER BY ANNEE, MOIS;
-- s. Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)
SELECT B.*
FROM BON B
WHERE NOT EXISTS (
    SELECT 1
    FROM COMPO C
    WHERE C.ID_BON = B.ID
);
-- t. Calculez le prix moyen des bons de commande par fournisseur.
SELECT F.NOM AS NOM_FOURNISSEUR, AVG(A.PRIX * C.QTE) AS PRIX_MOYEN_BON 
FROM BON B 
JOIN COMPO C ON B.ID = C.ID_BON 
JOIN ARTICLE A ON C.ID_ART = A.ID 
JOIN FOURNISSEUR F ON B.ID_FOU = F.ID 
GROUP BY F.NOM;
