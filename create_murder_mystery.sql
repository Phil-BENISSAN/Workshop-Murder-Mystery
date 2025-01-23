-- Création de la base de données et des tables pour l'enquête
CREATE DATABASE MurderMystery;
USE MurderMystery;

-- Table des habitants de la ville
CREATE TABLE people (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    address VARCHAR(255),
    occupation VARCHAR(100)
);

INSERT INTO people (name, age, address, occupation) VALUES
('Alice Martin', 34, '123 Main St', 'Banquière'),
('Bob Dupont', 45, '456 Elm St', 'Chauffeur'),
('Claire Dubois', 29, '789 Oak St', 'Enseignante'),
('David Lambert', 52, '101 Maple St', 'Chômeur'),
('Emma Bernard', 40, '202 Pine St', 'Artiste'),
('François Petit', 38, '303 Cedar St', 'Médecin'),
('Sophie Laurent', 27, '404 Birch St', 'Avocate');

-- Table des rapports de scènes de crime
CREATE TABLE crime_scene_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255),
    date DATETIME,
    description TEXT,
    victim_id INT,
    FOREIGN KEY (victim_id) REFERENCES people(person_id)
);

INSERT INTO crime_scene_reports (location, date, description, victim_id) VALUES
('123 Main St', '2025-01-15 08:00:00', 'Corps retrouvé dans la cuisine. Il en manque une partie?', 1),
('789 Oak St', '2025-01-14 20:00:00', 'Traces de lutte dans le salon, la victime a été poignardée', 3),
('202 Pine St', '2025-01-13 22:00:00', 'Vitre cassée et coffre-fort vide. Etrange Monsieur Watson!', 5),
('456 Elm St', '2025-01-14 20:15:00', 'Coups de feu entendus. LE MEURTRE A EU LIEU AU 789 Oak St', 2),
('404 Birch St', '2025-01-14 20:10:00', 'Appel de détresse reçu et aucune scène de crime', 7);

-- Table des déplacements des suspects
CREATE TABLE suspect_movements (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    suspect_id INT,
    location VARCHAR(255),
    date_time DATETIME,
    FOREIGN KEY (suspect_id) REFERENCES people(person_id)
);

INSERT INTO suspect_movements (suspect_id, location, date_time) VALUES
(1, '789 Oak St', '2025-01-14 20:30:00'),
(2, '456 Elm St', '2025-01-14 20:15:00'),
(5, '202 Pine St', '2025-01-13 22:00:00'),
(3, '789 Oak St', '2025-01-14 19:45:00'),
(7, '404 Birch St', '2025-01-14 20:10:00'),
(4, '123 Main St', '2025-01-15 07:50:00'),
(6, '404 Birch St', '2025-01-14 19:55:00');

-- Table des objets trouvés sur les scènes de crime
CREATE TABLE weapons (
    weapon_id INT AUTO_INCREMENT PRIMARY KEY,
    weapon_name VARCHAR(100),
    found_at_location VARCHAR(255),
    suspect_id INT,
    FOREIGN KEY (suspect_id) REFERENCES people(person_id)
);

INSERT INTO weapons (weapon_name, found_at_location, suspect_id) VALUES
('Couteau', '123 Main St', 1),
('Pied-de-biche', '202 Pine St', 5),
('Pistolet', '789 Oak St', 3),
('Fusil', '456 Elm St', 2),
('Corde', '404 Birch St', 7);