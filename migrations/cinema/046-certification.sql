create table if not exists cinema.certification
(
  id integer,
  pays text,
  ordre smallint,
  certification text,
  description text
);

copy cinema.certification (pays,ordre,certification,description)
  from './46-certification.csv' delimiter ','
  csv header quote '"' escape ''''
  encoding 'utf8';

create table if not exists cinema.film_certification
(
  id integer,
  pays text,
  ordre smallint,
  certification text,
  description text
);
