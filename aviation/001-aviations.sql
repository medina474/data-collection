
create schema aviation;

set search_path to public, aviation, extensions;

-- ICAO Organisation de l'aviation civile internationale
-- IATA Association du transport aérien international

create table aviation.aeroports (
  aeroport_code_icao text,
  aeroport_code_iata text,
  nom text,
  ville text,
  pays text,
  altitude int,
  tz text,
  coordonnees geometry(Point, 4326) default null::geometry
);

create unique index aeroports_aeroport_code_iata_idx
  on aviation.aeroports (aeroport_code_iata);

alter table aviation.aeroports
  add primary key using index aeroports_aeroport_code_iata_idx;

alter table only aviation.aeroports
  add foreign key (pays)
  references pays (code2);

CREATE TABLE aviation.compagnies (
  icao_code text,
  iata_code text not null,
  nom text,
  callsign text
);


create table aviation.appareils (
  type text,
  msn text,
  immatriculation text,
  hexa text,
  livraison date,
  nom text
);

create table aviation.operateurs (
  operateur_code_icao text,
  operateur_code_iata text,
  operateur text,
  callsign text
);


create table aviation.modeles (
  code_iata text not null,
  modele text,
  constructeur character(2),
  code_icao character(4),
  code_famille character(3),
  wtc character(1),
  pax integer,
  speed integer,
  ceiling integer,
  range integer,
  mtow integer,
  mlw integer
);

-- A transformer en json

comment on column aviation.modeles.wtc IS 'Wake Turbulence Category';
comment on column aviation.modeles.pax IS 'Passengers : nombre de passager en configuration standard 3 classes';
comment on column aviation.modeles.speed IS 'kts (noeuds)';
comment on column aviation.modeles.ceiling IS 'ft (pieds)';
comment on column aviation.modeles.range IS 'nautical mile (milles nautiques)';
comment on column aviation.modeles.mtow IS 'lbs Maximum Take-Off Weight';
comment on column aviation.modeles.mlw IS 'lbs Maximum Landing Weight';


create table aviation.vols (
  jour date,
  operateur_code_iata text,
  vol_numero int,
  appareil_code text,
  origine text,
  destination text,
  distance int,
  fuseau_horaire_origine text,
  fuseau_horaire_destination text,
  heure_prevue_depart timestamp with time zone null,
  delais_depart int,
  heure_depart timestamp with time zone null,
  roulage_depart int,
  decollage timestamp with time zone null,
  duree_vol int,
  atterrissage timestamp with time zone null,
  roulage_arrivee int,
  heure_arrivee timestamp with time zone null,
  delais_arrivee int,
  heure_prevue_arrivee timestamp with time zone null,
  duree_prevue int,
  duree int,
  derouté int,
  annulé int,
  annulation_raison text,
  delais_du_control_aerien int,
  delais_du_securite int,
  delais_du_operateur int,
  delais_du_avion int,
  delais_du_meteo int
);

select '=============== FIN STRUCTURE Aviation' as msg;


create unique index operateurs_operateur_code_icao_idx
  on aviation.operateurs (operateur_code_icao);

alter table aviation.operateurs
  add primary key using index operateurs_operateur_code_icao_idx;
