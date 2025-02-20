set search_path to public, extensions;

create table cinema.etablissements (
  id integer not null,
  nom text,
  voie text,
  codepostal text,
  ville text,
  coordonnees geometry(Point, 4326) default null::geometry,
  constraint cinema_pkey primary key (id)
);

create index cinema_coordonnees_idx
  on cinema.etablissements
  using GIST (coordonnees);

alter table if exists cinema.etablissements owner to iutsd;

alter table cinema.etablissements
  add column created_at timestamp with time zone default now(),
  add column updated_at timestamp with time zone;

create temporary table etablissement_tmp
(
  region smallint,
  nauto integer,
  nom text,
  région_administrative text,
  adresse text,
  code_insee text,
  commune text,
  population text,
  dep text,
  nuu text,
  unité_urbaine text,
  population_unité_urbaine text,
  situation_géographique text,
  écrans text,
  fauteuils text,
  semaines_activité text,
  séances text,
  entrées_2021 text,
  entrées_2020 text,
  évolution_entrées text,
  tranche_entrées text,
  propriétaire text,
  programmateur text,
  ae text,
  catégorie_art_et_essai text,
  label_art_et_essai text,
  genre text,
  multiplexe text,
  zone_commune text,
  nombre_films_programmés text,
  nombre_films_inédits text,
  nombre_films_en_semaine_1 text,
  pdm_films_français text,
  pdm_films_américains text,
  pdm_films_européens text,
  pdm_autres_films text,
  films_art_et_essai text,
  part_séances_films_art_et_essai text,
  pdm_films_art_et_essai text,
  latitude float,
  longitude float
);

\copy etablissement_tmp from 'cnc-données-cartographie-2023.csv' delimiter ';' csv header quote '"' encoding 'utf8';

insert into cinema.etablissements (id, nom, voie, ville, coordonnees)
select nauto, nom, adresse, commune, st_makepoint(longitude, latitude)
from etablissement_tmp;

drop table etablissement_tmp;
