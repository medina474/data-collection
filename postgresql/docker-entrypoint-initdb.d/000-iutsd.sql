create role iutsd with
  login
  nosuperuser
  nocreatedb
  nocreaterole
  noinherit
  noreplication
  connection limit -1
  password '5678';

create database iutsd owner iutsd;

\connect iutsd;

-- extensions

create schema extensions;

create extension postgis schema extensions;
create extension ltree schema extensions;
create extension fuzzystrmatch schema extensions;

-- Role public
create role role_web nologin;

-- PostgREST
create role postgrest noinherit login password '9012';
grant role_web to postgrest;

-- Chronologie
create table chronologie as
  with recursive calendrier as (
    select
      '2023-01-01 00:00:00'::timestamp as jour
    union all
    select
      jour + interval '1 day'
    from calendrier
      where jour + interval '1 day' <= '2026-12-31'
  )
  select
    extract(epoch from jour) / 86400::int as jj,
    jour,
    extract (year from jour) as annee,
    extract (month from jour) as mois,
    extract (day from jour) as jmois,
    extract (week from jour) as semaine,
    extract (dow from jour) as jsemaine,
    extract (doy from jour) as jannee,
    (extract(month from jour) - 1) / 6 + 1 as semestre,
    (extract(month from jour) - 1) / 4 + 1 as quadrimestre,
    extract(quarter from jour)::int as trimestre,
    (extract(month from jour) - 1) / 2 + 1 as bimestre
  from calendrier;
