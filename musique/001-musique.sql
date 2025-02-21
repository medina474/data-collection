create schema musique;

set search_path to public, musique, extensions;

create table musique.song (
  id uuid default idkit_uuidv7_generate()::uuid not null,
  title text not null,
  iswc text
);

alter table musique.song
  add column created_at timestamp with time zone default now(),
  add column updated_at timestamp with time zone;

create table musique.media (
  id uuid default idkit_uuidv7_generate()::uuid not null,
  release uuid not null,
  format character varying(10),
  quantity smallint default 1
);

alter table musique.media
  add column created_at timestamp with time zone default now(),
  add column updated_at timestamp with time zone;

create table musique.recording (
  isrc character(15) not null,
  song uuid not null,
  artist uuid not null,
  length bigint,
  description character varying(30)
);

CREATE TABLE musique.release (
  id uuid DEFAULT idkit_uuidv7_generate()::uuid not null,
  title character varying(50) not null,
  date character varying(12)
);


CREATE TABLE musique.track (
  media uuid DEFAULT idkit_uuidv7_generate()::uuid not null,
  recording character(15) not null,
  position integer,
  number character varying(3)
);
