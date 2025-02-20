create table cinema.films_genres (
  film_id int not null,
  genre_id integer not null
);

create unique index film_genres_pkey
  on cinema.films_genres
  using btree (film_id, genre_id);

alter table cinema.films_genres
  add primary key
  using index film_genres_pkey;

\copy cinema.films_genres (film_id, genre_id) from './041-films_genres.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

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
  foreign key (film_id) references cinema.films(film_id)
  on delete cascade;

alter table cinema.productions
add constraint productions_societe_id_fkey
  foreign key (societe_id) references cinema.societes(societe_id)
  on delete cascade;

\copy cinema.productions (film_id, societe_id) from '041-productions.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';
