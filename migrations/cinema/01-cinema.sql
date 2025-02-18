create role iutsd with
  login
  nosuperuser
  nocreatedb
  nocreaterole
  noinherit
  noreplication
  connection limit -1
  password 'motdepasse';

alter database iutsd owner to iutsd;
grant connect on database iutsd to iutsd;

\connect iutsd;

create schema if not exists cinema
  authorization iutsd;

alter default privileges for role postgres in schema cinema
  grant insert, select, update, delete on tables to iutsd;
