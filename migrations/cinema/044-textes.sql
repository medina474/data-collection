\connect iutsd;

drop table if exists cinema.synopsis;

create table if not exists cinema.resume (
  film uuid not null,
  langue text not null,
  texte text not null
);

ALTER TABLE cinema.resume ADD COLUMN ts tsvector
  GENERATED ALWAYS AS (to_tsvector('french', texte)) STORED;

CREATE INDEX resume_texte_idx ON cinema.resume USING GIN (ts);

alter table cinema.resume
add  CONSTRAINT resume_film_fk FOREIGN KEY (film)
        REFERENCES cinema.film (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;

create index resume_film_fki
  on cinema.resume(film);

alter table cinema.resume
add  CONSTRAINT resume_langue_fk FOREIGN KEY (langue)
        REFERENCES i18n.langue ("code-3") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;



copy cinema.resume (film, langue, texte)
  from '/tmp/44-resume.csv' delimiter ','
  csv header quote '"' escape ''''
  encoding 'utf8';

-- SELECT * from cinema.resume WHERE ts @@ to_tsquery('french', 'romancier');
