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

create schema extensions;

create extension postgis schema extensions;
