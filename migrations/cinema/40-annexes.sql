create table if not exists cinema.genre
(
  id integer not null primary key,
  genre text not null
);

create table if not exists cinema.societe
(
  id uuid default gen_random_uuid() not null primary key,
  nom text not null
);

alter table cinema.societe
  add column created_at timestamp with time zone default now(),
  add column updated_at timestamp with time zone;

