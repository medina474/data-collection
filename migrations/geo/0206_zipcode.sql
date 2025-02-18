\connect ventdest

create temporary table temp (
  col1 text,
  col2 text,
  col3 text,
  col4 text,
  col5 text,
  col6 text
);

copy temp (col1, col2, col3, col4, col5, col6) FROM '/docker-entrypoint-data.d/postal/laposte_hexasmal.csv' DELIMITER ';' CSV HEADER QUOTE '"' ESCAPE '''' ENCODING 'UTF8';

insert into codepostal (code_insee, cp, commune, libelle_acheminement, ligne_5, coordonnees)
select col1, col3, col2, col4, col5, 'POINT('||split_part(col6,',', 1)||' '||split_part(col6,',', 2)||')'
from temp;

drop table temp;

create temporary table temp (
  country_code VARCHAR(5),
  zipcode VARCHAR(10),
  place VARCHAR(100),
  state VARCHAR(100),
  state_code VARCHAR(5),
  province VARCHAR(100),
  province_code VARCHAR(100),
  community VARCHAR(30),
  community_code VARCHAR(10),
  latitude decimal(18, 15),
  longitude decimal(18, 15)
);

copy temp (country_code, zipcode, place, state, state_code, province, province_code, community, community_code, latitude, longitude) FROM '/docker-entrypoint-data.d/postal/zipcodes.us.csv' DELIMITER ',' CSV HEADER QUOTE '"' ESCAPE '''' ENCODING 'UTF8';

insert into codepostal (code_insee, cp, commune, coordonnees)
select lower(country_code)||'-'||lower(state_code), zipcode, place, postgis.st_makepoint(longitude, latitude)
from temp;
