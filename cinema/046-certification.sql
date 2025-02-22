create table cinema.certifications (
  pays_code text not null,
  ordre smallint,
  certification text not null,
  description text
);

create unique index certifications_pk
  on cinema.certifications
  using btree (pays_code, certification);

alter table cinema.certifications
  add primary key using index certifications_pk;

create index certifications_pays_idx
  on cinema.certifications
  using btree (pays_code, ordre);


alter table cinema.certifications
  add foreign key (pays_code)
    references pays (code2);

\copy cinema.certifications (pays_code,ordre,certification,description) from './046-certifications.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

create table cinema.films_certifications (
  film_id integer,
  pays_code text,
  certification text,
  description text
);

alter table cinema.films_certifications
  add foreign key (film_id)
    references cinema.films;

alter table cinema.films_certifications
  add foreign key (pays_code, certification)
    references cinema.certifications;
