-- pays

create table pays (
  code2 character(2) not null,
  code3 character(3) not null,
  code_num character(3) not null,
  pays text not null,
  nom_eng text,
  nom_spa text,
  drapeau_unicode character(2),
  forme_longue text
);

create index pays_nom
  on pays using btree (pays asc nulls last);

alter table pays
  add check (code2 ~ '^[A-Z]{2}$');

alter table pays
  add check (code3 ~ '^[A-Z]{3}$');

alter table pays
  add check (code_num ~ '^[0-9]{3}$');

\copy pays (code2, code3, code_num, pays, drapeau_unicode, forme_longue) from './pays.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

-- Noms des pays en anglais et espagnol

create temporary table pays_tmp (
  nom text,
  code_num text,
  code3 text
);

\copy pays_tmp FROM './pays-es.txt' (FORMAT CSV, delimiter E'\t', ENCODING 'UTF8');

update pays set nom_spa = (select t.nom from pays_tmp t where pays.code3 = t.code3);

truncate table pays_tmp;

\copy pays_tmp FROM './pays-en.txt' (FORMAT CSV, delimiter E'\t', ENCODING 'UTF8');

update pays set nom_eng = (select t.nom from pays_tmp t where pays.code3 = t.code3);
update pays set nom_eng = 'Taiwan' where code2 = 'TW';

drop table pays_tmp;

-- langues

create table langues (
  code3 char(3) not null,
  langue text default null,
  francais text default null
);

comment on table langues is 'ISO 639-3';

create table pays_langues (
  pays_code char(2) not null,
  langue_code char(3) not null,
  officiel boolean default false,
  pourcentage decimal(4,1) not null DEFAULT '0.0'
);

\copy langues from './langues.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy pays_langues from './pays_langues.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

-- devises

create table devises (
  devise_code character(3) not null,
  num4217 integer default null,
  symbole character varying(5) default null,
  nom text default null,
  format text default null,
  division integer default 0,
  minor text default null,
  minors text default null
);

create table pays_devises (
  pays_code character(2) not null,
  devise_code character(3) not null,
  valide daterange default null
);

\copy devises from './devises.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy pays_devises from './pays_devises.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

select '=============== FIN IMPORTATION DATA GEO' as msg;


