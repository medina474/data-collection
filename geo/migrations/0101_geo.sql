\connect ventdest

create extension ltree schema extensions;

create schema geo;

-- pays

create table geo.pays (
  code2 text not null,
  code3 text not null,
  code_num text not null,
  pays text not null,
  forme_longue text,
  nom_eng text,
  nom_spa text,
  drapeau_unicode character(2)
);

comment on column pays.code2
  is 'code ISO 3166-1 alpha 2';

comment on column pays.code3
  is 'code ISO 3166-1 alpha 3';

comment on column pays.code_num
  is 'code ISO 3166-1 numérique. Identique à la division statistique des Nations Unies UN M.49';

-- regions

create table geo.regions (
  region_code text,
  hierarchie ltree,
  region text not null,
  francais text,
  administration text,
  capitale text
);

comment on column geo.regions.region_code
  is 'code ISO 3166-2. Codes pour la représentation des noms de pays et de leurs subdivisions – Partie 2';


-- langues

create table geo.langues (
  code3 char(3) not null,
  langue character varying(20) default null,
  francais character varying(20) default null
);

create table geo.pays_langues (
  pays_code text not null,
  langue_code char(3) not null,
  officiel boolean default false,
  pourcentage decimal(4,1) not null DEFAULT '0.0'
);

-- devises

create table geo.devises (
  devise_code text not null,
  num4217 integer default null,
  symbole character varying(5) default null,
  nom text default null,
  format character varying(20) default null,
  division integer default 0,
  minor character varying(20) default null,
  minors character varying(20) default null
);

create table pays_devises (
  pays_code text not null,
  devise_code text not null,
  valide daterange default null
);

create table geo.villes(
  nom text not null,
  pays_code text,
  admin_name text,
  capital text,
  population integer,
  coordonnees postgis.geometry(Point, 4326) default null::postgis.geometry
);

create table adresses (
  adresse_id integer,
  voie text,
  ville text,
  region text,
  codepostal text,
  pays_code text
);

select '=============== FIN STRUCTURE Geo' as msg;
