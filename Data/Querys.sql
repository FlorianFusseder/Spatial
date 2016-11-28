/* Area shapefile importiert */
/* Collegues and universitys shapefile importiert */
/* parkinglot shapefile imporitert */
/* public schoolpoints importiert */

/* Complaint Data */
CREATE TABLE complaint_data
(
	CMPLNT_NUM INTEGER,
    OFNS_DESC VARCHAR,
    LAW_CAT_CD VARCHAR,
    BORO_NM VARCHAR,
    ADDR_PCT_CD	INTEGER,
    X_COORD_CD INTEGER,
    Y_COORD_CD INTEGER,
    Latitude DOUBLE PRECISION,
    Longitude DOUBLE PRECISION,
    Lat_Lon VARCHAR
);

COPY complaint_data FROM 'D:\Spatial\Data\CSV\Complaint_Data\Comlaint_Data.txt' DELIMITER '	' CSV;

select * from complaint_data;

/* Population Data */

CREATE TABLE population_data
(
    Borough	VARCHAR,
    FIPS_County_Code INTEGER,
    NTA_Code VARCHAR,
    NTA_Name VARCHAR,
    Population INTEGER
);

COPY population_data FROM 'D:\Spatial\Data\CSV\Population_Data\Population_Data.txt' DELIMITER '	' CSV;

select * from population_data;

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


/* Find Failures */


select *
from rental_data_bronx sti
where sti.lat > 41 or sti.lat < 40.5 OR
sti.long < -74.25 or sti.long > -73.65;

select * 
from areas
where lower(ntaname) like lower('%sunny%');

Create view Brooklyn as
select *
from areas
where boro_name = 'Brooklyn';

