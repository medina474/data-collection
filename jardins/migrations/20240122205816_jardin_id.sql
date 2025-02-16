\connect jardins;

alter table adhesions
  add foreign key (saison_id) references saisons on delete cascade not valid;

alter table adhesions
  validate constraint adhesions_saison_id_fkey;

alter table preparations
  add foreign key (jardin_id) references jardins on delete cascade not valid;

alter table preparations
  validate constraint preparations_jardin_id_fkey;
