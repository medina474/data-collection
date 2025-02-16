create database jardins;
\connect jardins;

create schema extensions;

set search_path to public, extensions;
show search_path;

create extension postgis schema extensions;
select postgis_full_version();