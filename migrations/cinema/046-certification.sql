\connect iutsd;

drop table if exists cinema.certification;

create table if not exists cinema.certification
(
  id integer,
  pays text,
  ordre smallint,
  certification text,
  description text
);

copy cinema.certification (pays,ordre,certification,description)
  from '/tmp/46-certification.csv' delimiter ','
  csv header quote '"' escape ''''
  encoding 'utf8';

drop table if exists cinema.film_certification;

create table if not exists cinema.film_certification
(
  id integer,
  pays text,
  ordre smallint,
  certification text,
  description text
);
