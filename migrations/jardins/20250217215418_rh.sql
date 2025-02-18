create schema rh;

create table rh.employes
(
  employe_id bigint,
  prenom text,
  nom text,
  naissance date
);

alter table only rh.employes
  add primary key (employe_id);