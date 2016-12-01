/* Area shapefile importiert */
/* Collegues and universitys shapefile importiert */
/* parkinglot shapefile imporitert */
/* public schoolpoints importiert */

/* Complaint Data */
CREATE TABLE complaint_data_temp
(
	Complaintnr INTEGER,
    Description VARCHAR,
    TypeOfComplaint VARCHAR,
    Latitude DOUBLE PRECISION,
    Longitude DOUBLE PRECISION
);

COPY complaint_data_temp FROM 'D:\Spatial\Data\CSV\Complaint_Data\Comlaint_Data.txt' DELIMITER '	' CSV;

SELECT * FROM complaint_data_temp;

CREATE TABLE complaint_data AS
(SELECT cdt.Complaintnr, cdt.Description, cdt.TypeOfComplaint, cdt.Latitude, cdt.Longitude, ST_MAKEPOINT(cdt.Longitude, cdt.Latitude) as coords
 FROM complaint_data_temp cdt);
 
SELECT * FROM complaint_data;

/* Population Data View Done */
drop table population_data;

CREATE TABLE population_data
(
    borough	VARCHAR,
    countycode INTEGER,
    ntacode VARCHAR,
    ntaname VARCHAR,
    Population INTEGER
);

COPY population_data FROM 'D:\Spatial\Data\CSV\Population_Data\Population_Data.txt' DELIMITER '	' CSV;

SELECT * FROM population_data;

CREATE VIEW populationarea AS
(SELECT a.*, (p.population / 1000000.0) AS populationfactor, p.population
 FROM areas a, population_data p
 WHERE a.ntacode=p.ntacode);
 
drop view populationarea;
select * from populationarea;

SELECT * FROM populationarea WHERE population = (SELECT MAX(population) FROM populationarea);
SELECT * FROM populationarea WHERE population = (SELECT MIN(population) FROM populationarea WHERE population > 0);
DROP VIEW populationarea;

/* Rental Data Mapbox */

CREATE TABLE rental_data_manhatten_mapbox_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    long DECIMAL,
    lat DECIMAL
);

CREATE TABLE rental_data_Bronx_mapbox_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    long DECIMAL,
    lat DECIMAL
);

CREATE TABLE rental_data_Brooklyn_mapbox_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    long DECIMAL,
    lat DECIMAL
);

CREATE TABLE rental_data_Queens_mapbox_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    long DECIMAL,
    lat DECIMAL
);

CREATE TABLE rental_data_StatenIsland_mapbox_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    long DECIMAL,
    lat DECIMAL
);

COPY rental_data_manhatten_mapbox_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_mapbox\b1_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_bronx_mapbox_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_mapbox\b2_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_brooklyn_mapbox_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_mapbox\b3_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_queens_mapbox_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_mapbox\b4_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_statenisland_mapbox_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_mapbox\b5_reworked.txt' DELIMITER '	' CSV;


CREATE TABLE rental_data_manhatten_mapbox AS
(SELECT man.address, man.neighborhood, man.value_per_sqft, man.long, man.lat, ST_MakePoint(man.long, man.lat) as coords 
 FROM rental_data_manhatten_mapbox_temp man);
 
 CREATE TABLE rental_data_bronx_mapbox AS
(SELECT bro.address, bro.neighborhood, bro.value_per_sqft, bro.long, bro.lat, ST_MakePoint(bro.long, bro.lat) as coords 
 FROM rental_data_bronx_mapbox_temp bro);
 
 CREATE TABLE rental_data_brooklyn_mapbox AS
(SELECT bro.address, bro.neighborhood, bro.value_per_sqft, bro.long, bro.lat, ST_MakePoint(bro.long, bro.lat) as coords 
 FROM rental_data_brooklyn_mapbox_temp bro);
 
 CREATE TABLE rental_data_queens_mapbox AS
(SELECT que.address, que.neighborhood, que.value_per_sqft, que.long, que.lat, ST_MakePoint(que.long, que.lat) as coords 
 FROM rental_data_queens_mapbox_temp que);
 
 CREATE TABLE rental_data_statenisland_mapbox AS
(SELECT sti.address, sti.neighborhood, sti.value_per_sqft, sti.long, sti.lat, ST_MakePoint(sti.long, sti.lat) as coords 
 FROM rental_data_statenisland_mapbox_temp sti);
 
 /* Find Failures Mapbox */

CREATE TABLE mapbox_fails AS
(
    SELECT *
	FROM rental_data_bronx_mapbox bron
	WHERE bron.lat > 41 or bron.lat < 40.5 OR
	bron.long < -74.25 or bron.long > -73.65
);

INSERT INTO mapbox_fails
(
    SELECT *
	FROM rental_data_brooklyn_mapbox broo
	WHERE broo.lat > 41 or broo.lat < 40.5 OR
	broo.long < -74.25 or broo.long > -73.65
);

INSERT INTO mapbox_fails
(
    SELECT *
	FROM rental_data_manhatten_mapbox manh
	WHERE manh.lat > 41 or manh.lat < 40.5 OR
	manh.long < -74.25 or manh.long > -73.65
);

INSERT INTO mapbox_fails
(
    SELECT *
	FROM rental_data_queens_mapbox manh
	WHERE manh.lat > 41 or manh.lat < 40.5 OR
	manh.long < -74.25 or manh.long > -73.65
);

INSERT INTO mapbox_fails
(
    SELECT *
	FROM rental_data_statenisland_mapbox manh
	WHERE manh.lat > 41 or manh.lat < 40.5 OR
	manh.long < -74.25 or manh.long > -73.65
);

SELECT * FROM mapbox_fails;

/* Rental Data Google */

CREATE TABLE rental_data_manhatten_google_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    lat DECIMAL,
    long DECIMAL
);

CREATE TABLE rental_data_Bronx_google_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    lat DECIMAL,
    long DECIMAL
);

CREATE TABLE rental_data_Brooklyn_google_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    lat DECIMAL,
    long DECIMAL
);

CREATE TABLE rental_data_Queens_google_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    lat DECIMAL,
    long DECIMAL
);

CREATE TABLE rental_data_StatenIsland_google_temp
(
    Address VARCHAR,
    Neighborhood VARCHAR,
    Value_per_SqFt DECIMAL,
    lat DECIMAL,
    long DECIMAL
);

COPY rental_data_manhatten_google_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_google\b1_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_bronx_google_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_google\b2_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_brooklyn_google_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_google\b3_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_queens_google_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_google\b4_reworked.txt' DELIMITER '	' CSV;
COPY rental_data_statenisland_google_temp FROM 'D:\Spatial\Data\CSV\Rental_Data\CSV\reworked_google\b5_reworked.txt' DELIMITER '	' CSV;


CREATE TABLE rental_data_manhatten_google AS
(SELECT man.address, man.neighborhood, man.value_per_sqft, man.long, man.lat, ST_MakePoint(man.long, man.lat) as coords 
 FROM rental_data_manhatten_google_temp man);
 
 CREATE TABLE rental_data_bronx_google AS
(SELECT bro.address, bro.neighborhood, bro.value_per_sqft, bro.long, bro.lat, ST_MakePoint(bro.long, bro.lat) as coords 
 FROM rental_data_bronx_google_temp bro);
 
 CREATE TABLE rental_data_brooklyn_google AS
(SELECT bro.address, bro.neighborhood, bro.value_per_sqft, bro.long, bro.lat, ST_MakePoint(bro.long, bro.lat) as coords 
 FROM rental_data_brooklyn_google_temp bro);
 
 CREATE TABLE rental_data_queens_google AS
(SELECT que.address, que.neighborhood, que.value_per_sqft, que.long, que.lat, ST_MakePoint(que.long, que.lat) as coords 
 FROM rental_data_queens_google_temp que);
 
 CREATE TABLE rental_data_statenisland_google AS
(SELECT sti.address, sti.neighborhood, sti.value_per_sqft, sti.long, sti.lat, ST_MakePoint(sti.long, sti.lat) as coords 
 FROM rental_data_statenisland_google_temp sti);


/* Find Failures Google */

CREATE TABLE google_fails AS
(
    SELECT *
	FROM rental_data_bronx_google bron
	WHERE bron.lat > 41 or bron.lat < 40.5 OR
	bron.long < -74.25 or bron.long > -73.65
);

INSERT INTO google_fails
(
    SELECT *
	FROM rental_data_brooklyn_google broo
	WHERE broo.lat > 41 or broo.lat < 40.5 OR
	broo.long < -74.25 or broo.long > -73.65
);

INSERT INTO google_fails
(
    SELECT *
	FROM rental_data_manhatten_google manh
	WHERE manh.lat > 41 or manh.lat < 40.5 OR
	manh.long < -74.25 or manh.long > -73.65
);

INSERT INTO google_fails
(
    SELECT *
	FROM rental_data_queens_google manh
	WHERE manh.lat > 41 or manh.lat < 40.5 OR
	manh.long < -74.25 or manh.long > -73.65
);

INSERT INTO google_fails
(
    SELECT *
	FROM rental_data_statenisland_google manh
	WHERE manh.lat > 41 or manh.lat < 40.5 OR
	manh.long < -74.25 or manh.long > -73.65
);


select * from google_fails;

drop table google_fail;


select * 
from areas
where lower(ntaname) like lower('%sunny%');

Create view Brooklyn as
select *
from areas
where boro_name = 'Brooklyn';

