create table cinema.personnes (
  personne_id int not null,
  nom text,
  prenom text,
  naissance date,
  deces date,
  nationalite text,
  artiste text,
  photo text,
  popularite decimal default 0,
  constraint personne_pkey primary key (personne_id)
);

alter table cinema.personnes
  add constraint personne_naissance
  check (naissance > '1730-01-01') not valid;

alter table cinema.personnes
  add constraint personne_deces
  check (deces > naissance) not valid;

alter table cinema.personnes
  add constraint personne_nationalite
  check (char_length(nationalite) = 2) not valid;

create unique index personnes_unique
  on cinema.personnes using btree (nom, prenom);

alter table cinema.personnes
  add constraint personnes_unique unique
  using index personnes_unique;

alter table if exists cinema.personnes owner to iutsd;

alter table cinema.personnes
  add column created_at timestamp with time zone default now(),
  add column updated_at timestamp with time zone;

\copy cinema.personnes (personne_id, nom, prenom, naissance, deces, nationalite, artiste, photo) from '010-personnes.csv' delimiter ',' csv header quote '"' encoding 'utf8';
