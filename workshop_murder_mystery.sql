-- 1. Requete simple pour voir les dates des scènes de crime
SELECT 
	date
FROM
	crime_scene_reports;

-- 2. Requete simple pour voir les dates des scènes de crime, en renommant la colonne    
SELECT 
	date AS crime_date
FROM 
	crime_scene_reports;

-- 3. INDICE 1 : Utilisation du WHERE
SELECT 
	date AS crime_date
FROM
	crime_scene_reports
WHERE
	date LIKE "2025-01-14%";

-- 4. INDICE 2 : Utilisation du WHERE & *
SELECT 
	*
FROM
	crime_scene_reports
WHERE
	date > "2025-01-14 19:59:59" AND date < "2025-01-14 20:25:01";
    
-- 5. INDICE 2 : Utilisation du WHERE et de ORDER BY, pour avoir un ordre chronologique
SELECT 
	*
FROM
	crime_scene_reports
WHERE
	date > "2025-01-14 19:59:59" AND date < "2025-01-14 20:25:01"
ORDER BY date ASC;

-- 6. INDICE 3 : On va pouvoir isoler la scène de crime correspondante
SELECT 
	*
FROM
	crime_scene_reports
WHERE
	location = "789 Oak ST";
    
-- 7. INDICE 3 : On va pouvoir isoler la scène de crime correspondante et trouver la victime JOIN
SELECT 
	*
FROM
	crime_scene_reports AS csr
JOIN
	people AS p
		ON csr.victim_id = p.person_id
WHERE
	csr.location = "789 Oak ST";
    
-- 8. INDICE 3 : La victime est ? avec  JOIN & choix des colonnes
SELECT 
	p.name,
    p.age, 
    p.occupation AS profession,
    csr.location AS address,
    csr.date AS murder_date
FROM
	crime_scene_reports AS csr
JOIN
	people AS p
		ON csr.victim_id = p.person_id
WHERE
	csr.location = "789 Oak ST";

-- 9. Allons voir dans les mouvements suspects
SELECT
	*
FROM 
	suspect_movements
WHERE
	location = "789 Oak ST";
    
-- 10. Petite parenthèse pour l'instruction GROUP BY = fonction d'aggrégation
SELECT
	COUNT(*) AS nb_person
FROM 
	suspect_movements
WHERE
	location = "789 Oak ST"
GROUP BY
	location;
    
-- 9. Allons voir dans les mouvements suspects -> l'auteur du meurtre
SELECT
	*
FROM 
	suspect_movements AS sm
JOIN
	people AS p
		ON sm.suspect_id = p.person_id
WHERE
	location = "789 Oak ST";
    
-- 10. Requête complexe pour avoir toutes les informations
SELECT 
	csr.date AS date_of_murder,
    csr.location AS location_of_murder,
    p.name AS victim_name,
    csr.description,
    sm.suspect_id
    
FROM
	crime_scene_reports AS csr
JOIN
	people AS p
		ON csr.victim_id = p.person_id
JOIN
	suspect_movements AS sm
		ON csr.location = sm.location
WHERE
		csr.location = "789 Oak ST"
	AND
		sm.suspect_id <> 3;

-- 11. L'arme du crime
SELECT 
	weapon_name
FROM 
	weapons
WHERE
	weapon_id =
	(
		SELECT 
			sm.suspect_id
			
		FROM
			crime_scene_reports AS csr
		JOIN
			people AS p
				ON csr.victim_id = p.person_id
		JOIN
			suspect_movements AS sm
				ON csr.location = sm.location
		WHERE
				csr.location = "789 Oak ST"
			AND
				sm.suspect_id <> 3
)
		
    


