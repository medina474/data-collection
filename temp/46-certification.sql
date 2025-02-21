drop table if exists cinema.certification;

create table if not exists cinema.certification
(
  id integer,
  pays text,
  ordre smallint,
  certification text,
  description text
);

drop table if exists cinema.film_certification;

create table if not exists cinema.film_certification
(
  id integer,
  pays text,
  ordre smallint,
  certification text,
  description text
);
