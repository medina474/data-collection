drop table if exists cinema.equipe;

create table if not exists cinema.equipe (
  film uuid not null,
  personne uuid not null,
  role text,
  alias text,
  constraint equipe_film_fk foreign key (film) references cinema.film(id)
    on update no action on delete no action not valid,
  constraint equipe_personne_fk foreign key (personne) references cinema.personne(id)
    on update no action on delete no action not valid
);

create index equipe_film_fki
  on cinema.equipe(film);

create index equipe_personne_fki
  on cinema.equipe(personne);

comment on table cinema.equipe is
  e'@foreignkey (personne) references cinema.acteur(id)|@fieldname rolebyacteur';

