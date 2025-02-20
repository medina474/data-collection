create table cinema.certifications (
  pays_code text not null,
  ordre smallint,
  certification text not null,
  description text
);

create index certifications_pays_idx
  on cinema.certifications
  using btree (pays_code, ordre);

create unique index certifications_pk
  on cinema.certifications
  using btree (pays_code, certification);

alter table cinema.certifications
  add primary key using index certifications_pk;

alter table cinema.certifications
  add foreign key (pays_code)
    references pays (code2);

\copy cinema.certifications (pays_code,ordre,certification,description) from './046-certifications.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

create table if not exists cinema.films_certifications (
  film_id integer,
  pays text,
  ordre smallint,
  certification text,
  description text
);
