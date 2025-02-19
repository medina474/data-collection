-- pays

create table pays (
  code2 character(2) not null,
  code3 character(3) not null,
  code_num character(3) not null,
  pays text not null,
  nom_eng text,
  nom_spa text,
  drapeau_unicode character(2),
  forme_longue text
);

create index pays_nom
  on pays using btree (pays asc nulls last);

alter table pays
  add check (code2 ~ '^[A-Z]{2}$');

alter table pays
  add check (code3 ~ '^[A-Z]{3}$');

alter table pays
  add check (code_num ~ '^[0-9]{3}$');

\copy pays (code2, code3, code_num, pays, drapeau_unicode, forme_longue) from './pays.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

-- Noms des pays en anglais et espagnol

create temporary table pays_tmp (
  nom text,
  code_num text,
  code3 text
);

\copy pays_tmp FROM './pays-es.txt' (FORMAT CSV, delimiter E'\t', ENCODING 'UTF8');

update pays set nom_spa = (select t.nom from pays_tmp t where pays.code3 = t.code3);

truncate table pays_tmp;

\copy pays_tmp FROM './pays-en.txt' (FORMAT CSV, delimiter E'\t', ENCODING 'UTF8');

update pays set nom_eng = (select t.nom from pays_tmp t where pays.code3 = t.code3);
update pays set nom_eng = 'Taiwan' where code2 = 'tw';

drop table pays_tmp;

-- langues

create table langues (
  code3 char(3) not null,
  langue text default null,
  francais text default null
);

comment on table langues is 'ISO 639-3';

create table pays_langues (
  pays_code char(2) not null,
  langue_code char(3) not null,
  officiel boolean default false,
  pourcentage decimal(4,1) not null DEFAULT '0.0'
);

\copy langues from './langues.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy pays_langues from './pays_langues.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

-- devises

create table devises (
  devise_code character(3) not null,
  num4217 integer default null,
  symbole character varying(5) default null,
  nom text default null,
  format text default null,
  division integer default 0,
  minor text default null,
  minors text default null
);

create table pays_devises (
  pays_code character(2) not null,
  devise_code character(3) not null,
  valide daterange default null
);

\copy devises from './devises.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy pays_devises from './pays_devises.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

select '=============== FIN IMPORTATION DATA GEO' as msg;

-- regions

set search_path to public, extensions;

create extension ltree schema extensions;

create table regions (
  region_code character varying(8),
  hierarchie ltree,
  region text not null,
  division text,
  administration text,
  capitale text
);

comment on column regions.region_code is 'UN Standard country or area codes for statistical use (M49)';

create index path_gist_idx
  on regions using gist (hierarchie);

create index path_idx
  on regions using btree (hierarchie);

alter table regions
  add primary key (region_code);

\copy regions FROM './regions/regions.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/at.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/au.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/be.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/bl.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ca.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ch.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/de.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/dk.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/es.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/fi.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/fr.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/gb.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/gr.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/hr.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/hu.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/it.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/jp.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/lt.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/lu.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/mx.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/nl.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/pl.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/pt.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ro.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/se.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ua.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/us.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

select '=============== FIN IMPORTATION DATA REGIONS' as msg;

create temporary table villes_tmp (
  type_commune text,
  code_commune text,
  code_region text,
  code_departement text,
  code_collectivite text,
  code_arrondissement text,
  type_nom text,
  nom_majuscule text,
  nom text,
  libelle text,
  code_canton text,
  commune_parente text
);

\copy villes_tmp from './v_commune_2023.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

insert into regions (region_code, hierarchie, region, administration)
select 'FR-'||code_commune, (hierarchie::text || '.FR-'||code_commune)::ltree, nom, 15
from villes_tmp, regions
where hierarchie ~ ('*.'||'FR-'||code_departement)::lquery;

drop table villes_tmp;

select '=============== WORLDCITIES' as msg;

create table villes (
  nom text,
  pays_code text,
  admin_name text,
  capital text,
  population int,
  coordonnees geometry
);

create temporary table villes_tmp (
  city text,
  city_ascii text,
  lat decimal(18, 15),
  lng decimal(18, 15),
  country text,
  iso2 text,
  iso3 text,
  admin_name text,
  capital text,
  population int,
  id text
);

\copy villes_tmp from './worldcities.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

insert into villes (nom, pays_code, admin_name, capital, population, coordonnees)
select city, upper(iso2), admin_name, capital, population, st_makepoint(lng, lat)
from villes_tmp;

update villes
  set admin_name = r.region_code
  from  regions r
  where hierarchie ~ ('*.'||villes.pays_code||'.*')::lquery
    and region = villes.admin_name;

drop table villes_tmp;
