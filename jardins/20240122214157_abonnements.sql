

create table jardins.abonnements (
	abonnement_id int8 not null,
	created_at timestamptz not null default now(),
	adherent_id int8 null,
	panier_id int8 null,
	date_debut date null,
	nombre int2 null,
	montant numeric null,
	mode_paiement_id int8 null,
	saison_id int8 null
);

alter table jardins.abonnements
  alter column abonnement_id
  add generated by default as identity;

create unique index abonnements_pk
  on jardins.abonnements
  using btree (abonnement_id);

alter table jardins.abonnements
  add primary key using index abonnements_pk;

alter table jardins.abonnements
  add foreign key (adherent_id) references jardins.adherents on delete cascade not valid;

alter table jardins.abonnements
  add foreign key (panier_id) references jardins.paniers;
