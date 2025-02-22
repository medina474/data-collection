create table cinema.equipes (
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


-- equipes -> films
create index on cinema.equipes(film_id);

alter table cinema.equipes
add foreign key (film_id)
  references cinema.films
  on delete cascade;

-- equipes -> personnes
create index on cinema.equipes(personne_id);

alter table cinema.equipes
add foreign key (personne_id)
  references cinema.personnes
  on delete cascade;

comment on table cinema.equipes is
  e'@foreignkey (personne) references cinema.acteur(id)|@fieldname rolebyacteur';
