\connect iutsd;

create schema if not exists cinema
  authorization iutsd;

alter default privileges
  for role postgres
  in schema cinema
  grant insert, select, update, delete on tables to iutsd;
