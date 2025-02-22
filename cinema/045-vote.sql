create table cinema.votes (
  film_id int not null,
  votants int default 0,
  moyenne decimal not null default 0.0
);

alter table cinema.votes
  add foreign key (film_id) references cinema.films;


create table cinema.user_votes (
  user_id int not null,
  film_id int not null,
  note decimal not null,
  timestamp timestamp with time zone not null
);

create unique index votes_pkey
  on cinema.user_votes
  using btree (film_id, user_id);

alter table cinema.user_votes
  add primary key
  using index votes_pkey;


create index vote_film_fki
  on cinema.user_votes(film_id);

alter table cinema.user_votes
  add constraint vote_film_fk
  foreign key (film_id)
  references cinema.films (film_id) match simple
  on update no action
  on delete cascade;

alter table cinema.user_votes
  add constraint note_check check (note >= 0 and note < 6) not valid;

CREATE FUNCTION cinema.vote_calcul()
  RETURNS trigger
  LANGUAGE 'plpgsql'
AS $BODY$
declare
   moyenne decimal(4,2);
   votants integer;
BEGIN
  SELECT count(*), avg(note) INTO votants, moyenne FROM cinema.votes WHERE film_id = NEW.film_id;
  UPDATE cinema.films SET vote_votants=COALESCE(votants,0), vote_moyenne=COALESCE(moyenne,0) WHERE film_id = NEW.film_id;
  RETURN NEW;
END
$BODY$;

create trigger trigger_vote_insert
  after insert
  on cinema.user_votes
  for each row
  execute function cinema.vote_calcul();

create trigger trigger_vote_update
  after update
  on cinema.user_votes
  for each row
  execute function cinema.vote_calcul();

alter function cinema.vote_calcul()
  owner to iutsd;
