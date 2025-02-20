-- pays

create table pays (
  code2 text not null,
  code3 text not null,
  code_num text not null,
  pays text not null,
  forme_longue text,
  nom_eng text,
  nom_spa text,
  drapeau_unicode character(2)
);

comment on column pays.code2
  is 'code ISO 3166-1 alpha 2';

comment on column pays.code3
  is 'code ISO 3166-1 alpha 3';

comment on column pays.code_num
  is 'code ISO 3166-1 numérique. Identique à la division statistique des Nations Unies UN M.49';

create index pays_nom
  on pays using btree (pays asc nulls last);

alter table pays
  add check (code2 ~ '^[A-Z]{2}$');

alter table pays
  add check (code3 ~ '^[A-Z]{3}$');

alter table pays
  add check (code_num ~ '^[0-9]{3}$');

alter table pays
  add primary key (code2);

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

alter table langues
  add check (code3 ~ '^[a-z]{3}$');

alter table langues
  add primary key (code3);

create table pays_langues (
  pays_code char(2) not null,
  langue_code char(3) not null,
  officiel boolean default false,
  pourcentage decimal(4,1) not null DEFAULT '0.0'
);

alter table pays_langues
  add check (pays_code ~ '^[A-Z]{2}$');

alter table pays_langues
  add check (langue_code ~ '^[a-z]{3}$');

alter table pays_langues
  add primary key (pays_code, langue_code);

\copy langues from './langues.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy pays_langues from './pays_langues.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

-- devises

create table devises (
  devise_code text not null,
  num4217 integer default null,
  symbole character varying(5) default null,
  nom text default null,
  format text default null,
  division integer default 0,
  minor text default null,
  minors text default null
);

alter table devises
  add check (devise_code ~ '^[A-Z]{3}$');

create table pays_devises (
  pays_code text not null,
  devise_code text not null,
  valide daterange default null
);

alter table pays_devises
  add check (pays_code ~ '^[A-Z]{2}$');

alter table pays_devises
  add check (devise_code ~ '^[A-Z]{3}$');

alter table devises
  add primary key (devise_code);

\copy devises from './devises.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy pays_devises from './pays_devises.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

select '=============== GEO' as msg;

-- pays_langues -> pays
alter table only pays_langues
  add foreign key (pays_code)
  references pays (code2) match simple
  on update no action
  on delete no action;

-- pays_langues -> langues
alter table only pays_langues
  add foreign key (langue_code)
  references langues (code3) match simple
  on update no action
  on delete no action;

-- pays_devises -> pays
alter table only pays_devises
  add foreign key (pays_code)
  references pays (code2);

-- pays_devises -> devises
alter table only pays_devises
  add foreign key (devise_code)
  references devises (devise_code);

select '=============== FIN DES CLES ETRANGERES Geo' as msg;
