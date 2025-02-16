\connect jardins;

alter table adherents
  add foreign key (depot_id) references depots not valid;

alter table adherents validate constraint adherents_depot_id_fkey;

alter table fermetures
  add foreign key (saison_id) references saisons not valid;

alter table fermetures validate constraint fermetures_saison_id_fkey;

alter table frequences
  add foreign key (jardin_id) references jardins not valid;

alter table frequences validate constraint frequences_jardin_id_fkey;
