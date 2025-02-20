create table cinema.equipe (
  film_id int not null,
  personne_id int not null,
  role cinema.role,
  alias text,
  ordre int2 null default 99
);

comment on table cinema.equipes is
  e'@foreignkey (personne) references cinema.acteur(id)|@fieldname rolebyacteur';


/*
constraint equipe_film_fk foreign key (film) references cinema.films(id)
    on update no action on delete no action not valid,
  constraint equipe_personne_fk foreign key (personne) references cinema.personnes(id)
    on update no action on delete no action not valid
*/

create index equipe_film_fki
  on cinema.equipe(film);

create index equipe_personne_fki
  on cinema.equipe(personne);

comment on table cinema.equipe is
  e'@foreignkey (personne) references cinema.acteur(id)|@fieldname rolebyacteur';
