drop table if exists cinema.personne;

create table cinema.personne
(
  id uuid default gen_random_uuid() not null,
  nom text,
  prenom text,
  naissance date,
  deces date,
  nationalite text,
  artiste text,
  photo text,
  constraint personne_pkey primary key (id)
);

alter table cinema.personne
  add constraint personne_naissance check (naissance > '1900-01-01') NOT VALID;

alter table cinema.personne
  add constraint personne_deces check (deces > naissance) NOT VALID;

alter table cinema.personne
  add constraint personne_nationalite check (char_length(nationalite) = 2) NOT VALID;

alter table if exists cinema.personne owner to iutsd;

alter table cinema.personne
  add column created_at timestamp with time zone default now(),
  add column updated_at timestamp with time zone;

copy cinema.personne (id, nom, prenom, naissance, deces, nationalite, artiste, photo)
  from '/tmp/10-personne.csv'
  delimiter ',' csv header quote '"' encoding 'utf8';
