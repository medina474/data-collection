drop schema biblio cascade;
create schema biblio;

create table biblio.auteurs (
  auteur_id integer not null,
  nom text not null
);

create table biblio.editeurs (
  editeur_id integer not null,
  editeur_nom text not null,
  ville text
);

create table biblio.oeuvres (
  oeuvre_id integer not null,
  titre text not null,
  langue_code text, -- references langues (langue_code),
  genre_id integer,
  infos json
  --constraint fk_oeuvre_genre   foreign key (genre_id) references genres (genre_id)
);

create table biblio.participe (
  oeuvre_id integer not null,
  auteur_id integer not null,
  fonction text,
  alias text
  --constraint pk_oeuvreauteur primary key (oeuvre_id, auteur_id)
);

create table biblio.editions (
  edition_id integer not null,
  titre text,
  infos json
);

create table biblio.incorpore (
  oeuvre_id integer not null,
  edition_id integer not null,
  infos json
);

create table biblio.exemplaires (
  exemplaire_id integer not null,
  edition_id integer not null,
  date_achat date,
  prix_achat numeric,
  etat text
);


create index auteur_nom
  on biblio.auteurs using btree (nom asc nulls last);

alter table biblio.auteurs
  add primary key (auteur_id);

alter table biblio.oeuvres
  add primary key (oeuvre_id);

alter table biblio.editeurs
  add primary key (editeur_id);

alter table biblio.editions
  add primary key (edition_id);

alter table biblio.exemplaires
  add primary key (exemplaire_id);

-- participe -> auteurs
create index on biblio.participe
  using btree (auteur_id);

alter table biblio.participe
  add foreign key (auteur_id)
  references biblio.auteurs
  on delete cascade;

-- participe -> oeuvres
create index on biblio.participe
  using btree (oeuvre_id);

alter table biblio.participe
  add foreign key (oeuvre_id)
  references biblio.oeuvres
  on delete cascade;


-- incorpore -> oeuvres
create index on biblio.incorpore
  using btree (oeuvre_id);

alter table biblio.incorpore
  add foreign key (oeuvre_id)
  references biblio.oeuvres
  on delete cascade;

-- incorpore -> editions
create index on biblio.incorpore
  using btree (edition_id);

alter table biblio.incorpore
  add foreign key (edition_id)
  references biblio.editions;


-- exemplaires -> editions
create index on biblio.exemplaires
  using btree (edition_id);

alter table biblio.exemplaires
  add foreign key (edition_id)
  references biblio.editions;


-- editions -> editeurs
--create index on biblio.editions
--  using btree (editeur_id);

--alter table biblio.editions
--  add foreign key (editeur_id)
--  references biblio.editeurs;
