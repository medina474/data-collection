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

-- films_genres -> films
create index on cinema.films_genres(film_id);

alter table cinema.films_genres
add constraint films_genres_film_id_fkey
  foreign key (film_id)
  references cinema.films(film_id)
  on delete cascade;

-- films_genres -> genres
create index on cinema.films_genres(genre_id);

alter table cinema.films_genres
add constraint films_genres_genre_id_fkey
  foreign key (genre_id)
  references cinema.genres(genre_id)
  on delete cascade;

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

-- sites

create table cinema.sites (
  site_id smallint not null,
  site text not null,
  url text not null
);

alter table cinema.sites
  add primary key (site_id);

insert into cinema.sites values
  (1,'TMDB (The Movie Database)','https://www.themoviedb.org/movie/$id'),
  (2,'IMDb (Internet Movie Database)','https://www.imdb.com/title/$id'),
  (3,'Wikipedia','https://fr.wikipedia.org/wiki/$id'),
  (4,'YouTube','https://youtu.be/$id'),
  (5,'Sens Critique','https://www.senscritique.com/film/_/$id'),
  (6,'AlloCiné','https://www.allocine.fr/film/fichefilm_gen_cfilm=$id.html');

create table cinema.links (
  id int not null,
  site_id smallint not null,
  identifiant text not null
);

alter table cinema.links
  add constraint links_no_insert_in_parent
  check (false) no inherit;

alter table cinema.links
  add primary key (id, site_id);

create table cinema.links_films (
) inherits (cinema.links);

create table cinema.links_personnes (
) inherits (cinema.links);

alter table cinema.links_films
  add primary key (id, site_id);

alter table cinema.links_personnes
  add primary key (id, site_id);

create index links_films_id
  on cinema.links_films(id);

create index links_films_site
  on cinema.links_films(site_id);

alter table cinema.links_films
  add foreign key (id)
  references cinema.films(film_id)
  on delete cascade;

alter table cinema.links_films
add foreign key (site_id)
  references cinema.sites
  on delete cascade;

-- Links Personnes

create index links_personnes_id
  on cinema.links_personnes(id);

create index links_personnes_site
  on cinema.links_personnes(site_id);

alter table cinema.links_personnes
  add foreign key (id)
  references cinema.personnes(personne_id)
  on delete cascade;

alter table cinema.links_personnes
add foreign key (site_id)
  references cinema.sites
  on delete cascade;


\copy cinema.links_films from './links_films.csv' (format csv, header, encoding 'utf8');
\copy cinema.links_personnes from './links_personnes.csv' (format csv, header, encoding 'utf8');
