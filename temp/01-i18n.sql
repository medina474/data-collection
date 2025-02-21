create schema if not exists i18n
  authorization iutsd;

create extension if not exists postgis with schema public;
comment on extension postgis is 'postgis geometry and geography spatial types and functions';

-- pays

create table if not exists i18n.pays (
  "code-2" character varying(2) not null primary key,
  "code-3" character varying(3) not null,
  "code-num" integer not null,
  nom text not null,
  "drapeau-unicode" character(2),
  "drapeau-svg" text
);



copy i18n.pays
  from '/tmp/pays.csv'
  delimiter ',' csv header quote '"' encoding 'utf8';

alter table if exists i18n.pays owner to iutsd;


-- langue

create table if not exists i18n.langue
(
  "code-3" character(3) not null primary key,
  "langue" text,
  "français" text
);

copy i18n.langue
  from '/tmp/langue.csv'
  delimiter ',' csv header quote '"' encoding 'utf8';

alter table if exists i18n.langue owner to iutsd;
