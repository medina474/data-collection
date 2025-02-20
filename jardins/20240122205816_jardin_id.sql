

alter table jardins.adhesions
  add foreign key (saison_id) references jardins.saisons on delete cascade not valid;

alter table jardins.adhesions
  validate constraint adhesions_saison_id_fkey;

alter table jardins.preparations
  add foreign key (jardin_id) references jardins.jardins on delete cascade not valid;

alter table jardins.preparations
  validate constraint preparations_jardin_id_fkey;
