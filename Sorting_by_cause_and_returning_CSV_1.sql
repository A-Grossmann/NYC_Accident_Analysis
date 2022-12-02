
USE accidents_NYC;
-- Create a Table to use to determine all unique instances of the contributing factors in the data.  The five contributing factors columns were joined to determine all unique instances 
	CREATE TABLE CONTRIBUTING_FACTORS AS SELECT * FROM
    (SELECT 
        Contributing_Factor_Vehicle_1 AS ALL_FACTORS
    FROM
        all_accidents UNION SELECT 
        Contributing_Factor_Vehicle_2 AS ALL_FACTORS
    FROM
        all_accidents UNION SELECT 
        Contributing_Factor_Vehicle_3 AS ALL_FACTORS
    FROM
        all_accidents UNION SELECT 
        Contributing_Factor_Vehicle_4 AS ALL_FACTORS
    FROM
        all_accidents UNION SELECT 
        Contributing_Factor_Vehicle_5 AS ALL_FACTORS
    FROM
        all_accidents) TBL
WHERE
    ALL_FACTORS IS NOT NULL
GROUP BY ALL_FACTORS;
        
-- Add on a primary key to make the two tables relatable to one another
ALTER TABLE contributing_factors
ADD id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT;

-- ADD A ROW WITH VALUES TO TABLE
DROP TABLE Classification;

-- Create a table that is more general classifications for the discriptions in the tables

CREATE TABLE Class_key (id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
class VARCHAR(255), discription_of_class VARCHAR(255));

INSERT INTO Class_Key
VALUES
(1, 'A', 'unknown'),
(2, 'B', 'distraction'),
(3,'C','persons_condition_illness'),
(4,'D', 'Bar_road_conditions'),
(5,'E','mannurisms'),
(6,'F', 'malfunctions');

-- Create a table that is only the contributing factors and a key 
-- for the classificatins for contributing factors in the contributing factors table

CREATE TABLE Classification (
    id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    classification VARCHAR(255)
);
INSERT INTO classification (classification)
VALUES 
('A'), ('B'), ('E'), ('E'), ('E'), ('B'), ('A'), ('E'),
('E'), ('C'), ('E'), ('E'), ('E'), ('F'), ('F'), ('B'), ('E'), ('C'),
('C'), ('C'), ('C'), ('D'), ('E'),
('D'), ('B'), ('F'), ('C'), ('F'), ('D'), ('D'), ('D'),
('E'), ('E'), ('D'), ('C'), ('D'), ('B'),
('D'), ('D'), ('F'), ('F'), ('F'), ('B'), ('B'), ('C'), ('D'), ('F'), 
('F'), ('B'), ('C'), ('B'), ('B'), ('F'), ('B'), ('D');

-- join tables to add classification

CREATE TABLE contributing_factors_class AS SELECT * FROM (
	SELECT c.id, cf.ALL_FACTORS, c.classification
	FROM contributing_factors cf
	JOIN classification c
	ON cf.id = c.id) TEMP_TABLE;
    
-- Drop the tables for contributing_factors and use the contributing_factors_class

DROP TABLE contributing_factors;
DROP TABLE classification;

-- MAKE A TABLE WITH THE VALUES FOR THE NEW CLASSIFICATION PARED WITH LONGITUDE LADITUDE CLASSIFICATION

	CREATE TABLE lon_lat_class AS SELECT * FROM
    (SELECT aa.longitude, aa.latitude, cf.classification
		FROM contributing_factors_class cf
		JOIN all_accidents aa
		ON aa.CONTRIBUTING_FACTOR_VEHICLE_1 = cf.ALL_FACTORS
		WHERE aa.longitude OR aa.latitude IS NOT NULL
		UNION 
	SELECT aa.longitude, aa.latitude, cf.classification
		FROM contributing_factors_class cf
		JOIN all_accidents aa
		ON aa.CONTRIBUTING_FACTOR_VEHICLE_2 = cf.ALL_FACTORS
		WHERE aa.longitude OR aa.latitude IS NOT NULL
        UNION
	SELECT aa.longitude, aa.latitude, cf.classification
		FROM contributing_factors_class cf
		JOIN all_accidents aa
		ON aa.CONTRIBUTING_FACTOR_VEHICLE_3 = cf.ALL_FACTORS
		WHERE aa.longitude OR aa.latitude IS NOT NULL
        UNION
	SELECT aa.longitude, aa.latitude, cf.classification
		FROM contributing_factors_class cf
		JOIN all_accidents aa
		ON aa.CONTRIBUTING_FACTOR_VEHICLE_4 = cf.ALL_FACTORS
		WHERE aa.longitude OR aa.latitude IS NOT NULL
        UNION
	SELECT aa.longitude, aa.latitude, cf.classification
		FROM contributing_factors_class cf
		JOIN all_accidents aa
		ON aa.CONTRIBUTING_FACTOR_VEHICLE_5 = cf.ALL_FACTORS
		WHERE aa.longitude OR aa.latitude IS NOT NULL)
TBL;

-- Break the lon_lat class into different tables for each classification to plot latter on a map

CREATE TABLE lon_lat_class_A AS
SELECT * FROM 
(SELECT * FROM lon_lat_class
WHERE classification = 'A') 
TBL;
CREATE TABLE lon_lat_class_b AS
SELECT * FROM 
(SELECT * FROM lon_lat_class
WHERE classification = 'B') 
TBL;
CREATE TABLE lon_lat_class_C AS
SELECT * FROM 
(SELECT * FROM lon_lat_class
WHERE classification = 'C') 
TBL;
CREATE TABLE lon_lat_class_D AS
SELECT * FROM 
(SELECT * FROM lon_lat_class
WHERE classification = 'D') 
TBL;
CREATE TABLE lon_lat_class_E AS
SELECT * FROM 
(SELECT * FROM lon_lat_class
WHERE classification = 'E') 
TBL;
CREATE TABLE lon_lat_class_F AS
SELECT * FROM 
(SELECT * FROM lon_lat_class
WHERE classification = 'F') 
TBL;

-- Create a drinking while driving table to see where the alcahol involvement accidents occur

CREATE TABLE Drinking_and_Driving AS
SELECT * FROM
(SELECT longitude, latitude FROM all_accidents
WHERE CONTRIBUTING_FACTOR_VEHICLE_1 = 'Alcohol Involvement' 
OR CONTRIBUTING_FACTOR_VEHICLE_2 = 'Alcohol Involvement' 
OR CONTRIBUTING_FACTOR_VEHICLE_3 = 'Alcohol Involvement' 
OR CONTRIBUTING_FACTOR_VEHICLE_4 = 'Alcohol Involvement') TBL;


-- Calculate the serverity of an accident.  If someone was injured it was given a value of 1
-- if someone died at the accident it was given a value of 3 and the total severity value given

CREATE TABLE xyz_severity AS
SELECT * FROM
(SELECT LATITUDE, LONGITUDE,
NUMBER_OF_MOTORIST_INJURED as injured,
NUMBER_OF_PERSONS_KILLED as killed,
NUMBER_OF_PEDESTRIANS_INJURED + NUMBER_OF_PEDESTRIANS_KILLED AS pedestrians,
NUMBER_OF_CYCLIST_INJURED + NUMBER_OF_CYCLIST_KILLED AS cyclists,
NUMBER_OF_PERSONS_INJURED +
(NUMBER_OF_PERSONS_KILLED)*3 as crash_severity
 FROM all_accidents
 WHERE longitude OR latitude IS NOT NULL) tbl
 WHERE crash_severity>0;
 
 -- create a seperate longitude_latitude table for pedestrians hurt or killed
 CREATE TABLE pedestrians AS 
 SELECT * FROM
 (SELECT latitude, longitude, pedestrians
 FROM xyz_severity
 WHERE pedestrians > 0) tbl;
 
-- create a seperate longitude_latitude table for cyclists hurt or killed
  CREATE TABLE cyclists AS 
 SELECT * FROM
 (SELECT latitude, longitude, cyclists
 FROM xyz_severity
 WHERE cyclists> 0) tbl;

-- create a seperate longitude_latitude table for a factor such as "Headlights Defective"
 SELECT count('Headlights Defective') as Headlight_defective
 FROM (SELECT CONTRIBUTING_FACTOR_VEHICLE_1 FROM nyc_accidents_2020) tbl;



SELECT ROW_ID, NUMBER_OF_PERSONS_KILLED FROM all_accidents
WHERE CONTRIBUTING_FACTOR_VEHICLE_1 = 'alcohol involvement' and number_of_persons_killed > 0;

-- add a null value definition into the class_key table to later weed it out
INSERT INTO class_key
VALUES
(7,'G', NULL);

INSERT INTO contributing_factors_class
VALUES
(56, NULL, 'G');

-- create a new column in all_accidents_with_factors so that all 
-- the letters for simplified classifications on contributing factors are added.

CREATE TABLE all_accidents_with_factors AS
SELECT COLLISION_ID, CONTRIBUTING_FACTOR_VEHICLE_1,
 CONTRIBUTING_FACTOR_VEHICLE_2, CONTRIBUTING_FACTOR_VEHICLE_3,
 CONTRIBUTING_FACTOR_VEHICLE_4, CONTRIBUTING_FACTOR_VEHICLE_5,
 class_1, class_2, class_3, class_4, class_5  FROM 
	(SELECT aa.*, cfc_1.all_factors as factors_1, cfc_1.classification as class_1,  
	cfc_2.all_factors as factor_2, cfc_2.classification as class_2,
	cfc_3.all_factors as factor_3, cfc_3.classification as class_3,
	cfc_4.all_factors as factor_4, cfc_4.classification as class_4,
	cfc_5.all_factors as factor_5, cfc_5.classification as class_5
	 FROM all_accidents aa
	JOIN contributing_factors_class cfc_1
	on cfc_1.all_factors = aa.contributing_factor_vehicle_1
	LEFT JOIN contributing_factors_class cfc_2
	on cfc_2.all_factors = aa.contributing_factor_vehicle_2
	LEFT JOIN contributing_factors_class cfc_3
	on cfc_3.all_factors = aa.contributing_factor_vehicle_3
	LEFT JOIN contributing_factors_class cfc_5
	on cfc_5.all_factors = aa.contributing_factor_vehicle_5
	LEFT JOIN contributing_factors_class cfc_4
	on cfc_4.all_factors = aa.contributing_factor_vehicle_4
	) tbl;

-- Create the totals for each generalized catagory and calculate the percentage of each as
-- percent of all contributing factors given for vehicles envolved in accidents
CREATE TABLE factor_totals
AS SELECT * FROM(
	SELECT tbl.class, tbl.total, TBL.total * 100.0 / sum(TBL.total) over() as percent_total, ck.discription_of_class 
	FROM 
		(SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
		WHERE
		class_1 = 'B' or class_2 = 'B' or class_3 = 'B' OR class_4 = 'B' OR class_4 = 'B'
		UNION
		SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
		WHERE
		class_1 = 'C' or class_2 = 'C' or class_3 = 'C' OR class_4 = 'C' OR class_4 = 'C'
		UNION
		SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
		WHERE
		class_1 = 'D' or class_2 = 'D' or class_3 = 'D' OR class_4 = 'D' OR class_4 = 'D'
		UNION
		SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
		WHERE
		class_1 = 'E' or class_2 = 'E' or class_3 = 'E' OR class_4 = 'E' OR class_4 = 'E'
		UNION
		SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
		WHERE
        
		class_1 = 'F' or class_2 = 'F' or class_3 = 'F' OR class_4 = 'F' OR class_4 = 'F'
		ORDER BY total DESC) TBL
		JOIN
		class_key ck
		ON
		ck.class = tbl.class) TBL_2;

SELECT * FROM (
SELECT a.CONTRIBUTING_FACTOR_VEHICLE_1 FROM all_accidents_with_factors a
UNION ALL
SELECT b.CONTRIBUTING_FACTOR_VEHICLE_2 FROM all_accidents_with_factors b
UNION ALL
SELECT c.CONTRIBUTING_FACTOR_VEHICLE_3 FROM all_accidents_with_factors c
UNION ALL
SELECT d.CONTRIBUTING_FACTOR_VEHICLE_4 FROM all_accidents_with_factors d
UNION ALL
SELECT e.CONTRIBUTING_FACTOR_VEHICLE_5 FROM all_accidents_with_factors e) tbl
WHERE
NOT CONTRIBUTING_FACTOR_VEHICLE_1 = 'Unspecified'
LIMIT 500000;

SELECT * FROM (
SELECT a.CONTRIBUTING_FACTOR_VEHICLE_1 FROM all_accidents_with_factors a
UNION ALL
SELECT b.CONTRIBUTING_FACTOR_VEHICLE_2 FROM all_accidents_with_factors b
UNION ALL
SELECT c.CONTRIBUTING_FACTOR_VEHICLE_3 FROM all_accidents_with_factors c
UNION ALL
SELECT d.CONTRIBUTING_FACTOR_VEHICLE_4 FROM all_accidents_with_factors d
UNION ALL
SELECT e.CONTRIBUTING_FACTOR_VEHICLE_5 FROM all_accidents_with_factors e) tbl
WHERE
NOT CONTRIBUTING_FACTOR_VEHICLE_1 = 'Unspecified'
LIMIT 500000;

SELECT * FROM (
SELECT a.class_1 FROM all_accidents_with_factors a
UNION ALL
SELECT b.class_2 FROM all_accidents_with_factors b
UNION ALL
SELECT c.class_3 FROM all_accidents_with_factors c
UNION ALL
SELECT d.class_4 FROM all_accidents_with_factors d
UNION ALL
SELECT e.class_5 FROM all_accidents_with_factors e) tbl
WHERE
NOT class_1 = 'A'
LIMIT 500000;

-- create a selection for the lon_lat of all crashes
CREATE TABLE lon_lat AS SELECT * FROM(
SELECT longitude, latitude FROM all_accidents) tbl;
all_accidents_with_factors
 