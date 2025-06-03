-- Active: 1747933096203@@127.0.0.1@5432@text_db
CREATE TABLE ranger
(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);

DROP TABLE ranger;


INSERT into ranger VALUES
(1,'Alice Green','Northern Hills'),
(2,'Bob White','River Delta'),
(3,'Carol King','Mountain Range');

SELECT * from ranger;

CREATE TABLE species
(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100),
    scientific_name VARCHAR(100),
    discovery_date DATE,
    conservation_status VARCHAR(100)
);


DROP TABLE species;

INSERT INTO species VALUES
(1,'Snow Leopard ', 'Panthera uncia','1775-01-01','Endangered'),
(2,'Bengal Tiger ', 'Panthera tigris tigris','1758-01-01','Endangered'),
(3,'Red Panda', 'Ailurus fulgens','1825-01-01','Vulnerable'),
(4,'Asiatic Elephant', 'Elephas maximus indicus','1758-01-01','Endangered');



SELECT * from species;

CREATE TABLE sightings
(
    sighting_id INT,
    species_id INT,
    ranger_id INT,
    location VARCHAR(100),
    sighting_time TIMESTAMP,
    notes VARCHAR(100)
);
SELECT * from sightings;



DROP Table sightings; 



INSERT INTO sightings VALUES
(1,1,1,'Peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),
(2,2,2,'Bankwood Area','2024-05-12 16:20:00','Juvenile seen'),
(3,3,3,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),
(4,1,2,'Snowfall Pass','2024-05-18 18:30:00', NULL)




-- 1.Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'

-- 1
INSERT INTO ranger VALUES
(4,'Derek Fox','Coastal Plains')



-- 2

SELECT count(*) as unique_species_count FROM sightings WHERE sighting_id = ranger_id AND sighting_id= ranger_id;


-- 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- 4


-- SELECT name,ranger_id as total_sightings FROM sightings
-- NATURAL JOIN ranger;


SELECT name,count(ranger_id) FROM sightings
JOIN ranger USING(ranger_id)
GROUP BY name
;

--


-- 5


SELECT common_name FROM species  as sp
LEFT JOIN sightings s ON sp.species_id=s.species_id
WHERE s.species_id IS NULL ;


SELECT * FROM rangers;

-- 6
SELECT sp.common_name, s.sighting_time, r.name
FROM species AS sp
INNER JOIN sightings AS s ON sp.species_id = s.species_id
INNER JOIN ranger AS r ON s.ranger_id = r.ranger_id
WHERE s.sighting_time >'2024-05-15'
;


-- 7

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';



-- 8

SELECT sighting_id ,
CASE
WHEN extract(HOUR from sighting_time) < 12 THEN 'Morning'
WHEN extract(HOUR from sighting_time) >= 12 AND
 extract(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
ELSE 'Evening'
END as time_of_day
FROM sightings;


-- 9

DELETE FROM ranger
WHERE ranger_id NOT IN (
SELECT DISTINCT ranger_id FROM sightings
);

