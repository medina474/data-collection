create database jardins;
\connect jardins;

create schema extensions;

set search_path to public, extensions;
show search_path;

create extension postgis schema extensions;

-- Role public
create role role_web nologin;

grant usage on schema public to role_web;
alter default privileges in schema public grant select on tables to role_web;

-- PostgREST
create role postgrest noinherit login password 'motdepasse';
grant role_web to postgrest;
