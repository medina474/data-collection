

alter table jardins.adherents
  add foreign key (depot_id) references jardins.depots not valid;

alter table jardins.adherents validate constraint adherents_depot_id_fkey;

alter table jardins.fermetures
  add foreign key (saison_id) references jardins.saisons not valid;

alter table jardins.fermetures validate constraint fermetures_saison_id_fkey;

alter table jardins.frequences
  add foreign key (jardin_id) references jardins.jardins not valid;

alter table jardins.frequences validate constraint frequences_jardin_id_fkey;
