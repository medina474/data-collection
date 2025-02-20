create table if not exists cinema.film_genre (
  film uuid not null,
  genre integer not null,
  constraint film_genre_pkey primary key (film, genre),
  constraint film_genre_film foreign key (film)
    references cinema.films (id) match simple
    on update no action
    on delete no action
    not valid,
  constraint film_genre_genre foreign key (genre)
    references cinema.genre (id) match simple
    on update no action
    on delete no action
    not valid
);

\copy cinema.film_genre (film, genre) from './041-film_genre.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

-- Productions

create table cinema.productions (
  film_id int not null,
  societe_id int not null
);

create index on cinema.productions
  using btree (film_id);

create index on cinema.productions
  using btree (societe_id);

alter table cinema.productions
  add primary key (film_id, societe_id);

alter table cinema.productions
add constraint productions_film_id_fkey
  foreign key (film_id) references cinema.films
  on delete cascade;

alter table cinema.productions
add constraint productions_societe_id_fkey
  foreign key (societe_id) references cinema.societes(societe_id)
  on delete cascade;

\copy cinema.production (film, societe) from '041-productions.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';
