create table if not exists cinema.genre (
  id integer not null primary key,
  genre text not null
);

\copy cinema.genre from './40-genre.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

create table if not exists cinema.societe (
  id uuid default gen_random_uuid() not null primary key,
  nom text not null
);

\copy cinema.societe from './40-societe.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';
