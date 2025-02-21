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

-- Role public
create role role_web nologin;

-- PostgREST
create role postgrest noinherit login password '9012';
grant role_web to postgrest;
