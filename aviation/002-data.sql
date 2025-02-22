-- Derivative work from Our Airports
-- https://github.com/davidmegginson/ourairports-data

set search_path to public, aviation, extensions;

create temporary table aeroports_tmp (
  AirportID integer,
  name text,
  City text,
  Country text,
  IATA text,
  ICAO text,
  latitude decimal(18, 15),
  longitude decimal(18, 15),
  altitude int,
  Timezone text,
  DST text,
  TZ text,
  Type text,
  Source text
);

\copy aeroports_tmp from './aeroports.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

-- Corriger les noms des pays
update aeroports_tmp set Country = 'United States of America' WHERE Country = 'United States';
update aeroports_tmp set Country = 'Republic of Korea' WHERE Country = 'South Korea';
update aeroports_tmp set Country = 'Myanmar' WHERE Country = 'Burma';
update aeroports_tmp set Country = 'United Kingdom of Great Britain and Northern Ireland' WHERE Country = 'United Kingdom';
update aeroports_tmp set Country = 'Iran (Islamic Republic of)' WHERE Country = 'Iran';
update aeroports_tmp set Country = 'Venezuela (Bolivarian Republic of)' WHERE Country = 'Venezuela';
update aeroports_tmp set Country = 'Bolivia (Plurinational State of)' WHERE Country = 'Bolivia';
update aeroports_tmp set Country = 'Viet Nam' WHERE Country = 'Vietnam';
update aeroports_tmp set Country = 'Côte d''Ivoire' WHERE Country = 'Cote d''Ivoire';
update aeroports_tmp set Country = 'Czechia' WHERE Country = 'Czech Republic';
update aeroports_tmp set Country = 'Congo' WHERE Country = 'Congo (Kinshasa)';
update aeroports_tmp set Country = 'United Republic of Tanzania' WHERE Country = 'Tanzania';

-- Supprimer les enregistrements sans code IATA
update aeroports_tmp set IATA = null where iata = '\N';
-- \copy (select * from aeroports_tmp where IATA is null) to '/data/aviation/aeroports-iata-null.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
delete from aeroports_tmp where IATA is null;

-- Copier les données dans la table aviation.aeroports
insert into aviation.aeroports (aeroport_code_icao, aeroport_code_iata, nom, ville, pays, altitude, tz, coordonnees)
  select ICAO, IATA, name, City, pays.code2, altitude, TZ, st_makepoint(longitude, latitude)
  from aeroports_tmp
  left join pays on (pays.nom_eng = aeroports_tmp.Country)
  where IATA is not null
  order by AirportID;

drop table aeroports_tmp;


-- https://www.kaggle.com/datasets/usdot/flight-delays

set timezone = 'UTC';

create table aviation.vols_tmp (
  YEAR int,                 -- 2015 (jour)
  MONTH int,                -- 1    (jour)
  DAY int,                  -- 1    (jour)
  DAY_OF_WEEK int,          -- 4    (jour)
  AIRLINE text,             -- AA   (operateur_code_iata)
  FLIGHT_NUMBER int,        -- 1057 (vol_numero)
  TAIL_NUMBER text,         -- N3ASAA (appareil_code)
  ORIGIN_AIRPORT text,      -- DFW  (origine)
  DESTINATION_AIRPORT text, -- MIA  (destination)
  SCHEDULED_DEPARTURE text, -- 0515 (heure_prevue_depart)
  DEPARTURE_TIME text,      -- 0703 (heure_depart),
  DEPARTURE_DELAY int,      -- 108  (delais_depart)
  TAXI_OUT int,             -- 15,  (roulage_depart)
  WHEELS_OFF TEXT,          -- 0718 (decollage)
  SCHEDULED_TIME int,       -- 161,   (temps_prevu)
  ELAPSED_TIME int,         -- 155,   (temps)
  AIR_TIME int,             -- 133,   (temps_en_vol)
  DISTANCE int,             -- 1121,  (distance)
  WHEELS_ON text,           -- 1031   (atterrissage)
  TAXI_IN int,              -- 7      (roulage_arrivee)
  SCHEDULED_ARRIVAL text,   -- 0856   (heure_prevue_arrivee)
  ARRIVAL_TIME text,        -- 1038,  (heure_arrivee)
  ARRIVAL_DELAY int,        -- 102,   (delais_arrivee)
  DIVERTED int,             -- 0,
  CANCELLED int,            -- 0,
  CANCELLATION_REASON text, -- ,
  AIR_SYSTEM_DELAY int,     -- 0,
  SECURITY_DELAY int,       -- 0,
  AIRLINE_DELAY int,        -- 0,
  LATE_AIRCRAFT_DELAY int,  -- 0
  WEATHER_DELAY int         -- ,102
  );

\copy aviation.vols_tmp from './flights2.csv' (format csv, header, encoding 'utf8');

ALTER TABLE aviation.vols_tmp
  ADD COLUMN TS_SCHEDULED_DEPARTURE timestamp WITH TIME ZONE NULL,
  ADD COLUMN TS_DEPARTURE_TIME timestamp WITH TIME ZONE NULL,
  ADD COLUMN TS_WHEELS_OFF timestamp WITH TIME ZONE NULL,
  ADD COLUMN TS_WHEELS_ON timestamp WITH TIME ZONE NULL,
  ADD COLUMN TS_SCHEDULED_ARRIVAL timestamp WITH TIME ZONE NULL,
  ADD COLUMN TS_ARRIVAL_TIME timestamp WITH TIME ZONE NULL,
  ADD COLUMN TZ_ORIGIN text NULL,
  ADD COLUMN TZ_DESTINATION text NULL;

-- Recopier le fuseau horaire
UPDATE aviation.vols_tmp SET
TZ_ORIGIN = a.TZ FROM aviation.aeroports a WHERE a.aeroport_code_iata = vols_tmp.origin_airport;

UPDATE aviation.vols_tmp SET
TZ_DESTINATION = a.TZ FROM aviation.aeroports a WHERE a.aeroport_code_iata = vols_tmp.destination_airport;

UPDATE aviation.vols_tmp SET TS_SCHEDULED_DEPARTURE = TO_TIMESTAMP(
    LPAD(YEAR::text, 4, '0') || '-' ||
    LPAD(MONTH::text, 2, '0') || '-' ||
    LPAD(DAY::text, 2, '0') || ' ' ||
    LPAD(SUBSTRING(SCHEDULED_DEPARTURE, 1, 2), 2, '0') || ':' ||
    LPAD(SUBSTRING(SCHEDULED_DEPARTURE, 3, 2), 2, '0'),
    'YYYY-MM-DD HH24:MI'
  )::timestamp at time zone TZ_ORIGIN;

UPDATE aviation.vols_tmp
  SET TS_DEPARTURE_TIME = (TS_SCHEDULED_DEPARTURE at time zone TZ_ORIGIN + (DEPARTURE_DELAY * interval '1 minute'))::timestamp at time zone TZ_ORIGIN,
  TS_SCHEDULED_ARRIVAL = (TS_SCHEDULED_DEPARTURE at time zone TZ_ORIGIN + (SCHEDULED_TIME * interval '1 minute'))::timestamp at time zone TZ_ORIGIN;

UPDATE aviation.vols_tmp
  SET TS_WHEELS_OFF = (TS_DEPARTURE_TIME at time zone TZ_ORIGIN + (TAXI_OUT * interval '1 minute'))::timestamp at time zone TZ_ORIGIN,
  TS_ARRIVAL_TIME = ((TS_DEPARTURE_TIME at time zone TZ_ORIGIN + (ELAPSED_TIME * interval '1 minute'))::timestamp at time zone TZ_ORIGIN) at time zone TZ_DESTINATION;

UPDATE aviation.vols_tmp
  SET TS_WHEELS_ON = ((TS_WHEELS_OFF at time zone TZ_ORIGIN + (AIR_TIME * interval '1 minute'))::timestamp at time zone TZ_ORIGIN) at time zone TZ_DESTINATION;

insert into aviation.vols (jour,
  operateur_code_iata, vol_numero, appareil_code,
  origine, destination, distance,
  fuseau_horaire_origine, fuseau_horaire_destination,
  heure_prevue_depart, delais_depart, heure_depart,
  duree_prevue, duree,
  heure_prevue_arrivee, delais_arrivee, heure_arrivee,
  roulage_depart, roulage_arrivee,
  decollage, duree_vol, atterrissage,
  derouté,
  annulé,
  annulation_raison,
  delais_du_control_aerien,
  delais_du_securite,
  delais_du_operateur,
  delais_du_avion,
  delais_du_meteo
  )
select
  to_date(
    LPAD(YEAR::text, 4, '0') || '-' ||
    LPAD(MONTH::text, 2, '0') || '-' ||
    LPAD(DAY::text, 2, '0'),
    'YYYY-MM-DD'
  ),
  AIRLINE,
  FLIGHT_NUMBER,
  TAIL_NUMBER,
  ORIGIN_AIRPORT, DESTINATION_AIRPORT, DISTANCE,
  TZ_ORIGIN, TZ_DESTINATION,
  to_timestamp(
    LPAD(YEAR::text, 4, '0') || '-' ||
    LPAD(MONTH::text, 2, '0') || '-' ||
    LPAD(DAY::text, 2, '0') || ' ' ||
    LPAD(SUBSTRING(SCHEDULED_DEPARTURE, 1, 2), 2, '0') || ':' ||
    LPAD(SUBSTRING(SCHEDULED_DEPARTURE, 3, 2), 2, '0'),
    'YYYY-MM-DD HH24:MI'
  )::timestamp at time zone TZ_ORIGIN,
  DEPARTURE_DELAY,
  (TS_SCHEDULED_DEPARTURE at time zone TZ_ORIGIN + (DEPARTURE_DELAY * interval '1 minute'))::timestamp at time zone TZ_ORIGIN,
  SCHEDULED_TIME, ELAPSED_TIME,
  (TS_SCHEDULED_DEPARTURE at time zone TZ_ORIGIN + (SCHEDULED_TIME * interval '1 minute'))::timestamp at time zone TZ_ORIGIN,
  ARRIVAL_DELAY,
  (TS_DEPARTURE_TIME at time zone TZ_ORIGIN + (ELAPSED_TIME * interval '1 minute'))::timestamp at time zone TZ_ORIGIN,
  TAXI_OUT, TAXI_IN,
  (TS_DEPARTURE_TIME at time zone TZ_ORIGIN + (TAXI_OUT * interval '1 minute'))::timestamp at time zone TZ_ORIGIN,
  AIR_TIME,
  (TS_WHEELS_OFF at time zone TZ_ORIGIN + (AIR_TIME * interval '1 minute'))::timestamp at time zone TZ_ORIGIN,
  DIVERTED,
  CANCELLED,
  CANCELLATION_REASON,
  AIR_SYSTEM_DELAY,
  SECURITY_DELAY,
  AIRLINE_DELAY,
  LATE_AIRCRAFT_DELAY,
  WEATHER_DELAY
from aviation.vols_tmp;

\copy aviation.appareils from './appareils.csv' (format csv, header, encoding 'utf8');


create temporary table operateurs_tmp (
  AirlineID int,
  Name text,
  Alias text,
  IATA text,
  ICAO text,
  Callsign text,
  Country text,
  Active text
);

\copy operateurs_tmp from './operateurs.csv' (format csv, header, encoding 'utf8');

insert into aviation.operateurs (
  operateur_code_icao,
  operateur_code_iata,
  operateur,
  callsign
)
select ICAO, IATA, Name, upper(Callsign) from operateurs_tmp
  where Active = 'Y' and IATA <> '' and ICAO <> 'N/A' and ICAO <> '\N' and ICAO <> '';
