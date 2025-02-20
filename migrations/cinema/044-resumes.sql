create table if not exists cinema.resumes (
  film_id int not null,
  langue text not null,
  resume text not null
);

alter table cinema.resumes
  add column ts tsvector
  generated always as (to_tsvector('french', resume)) stored;

CREATE INDEX resume_texte_idx
ON cinema.resumes USING GIN (ts);

alter table cinema.resumes
add FOREIGN KEY (film_id) REFERENCES cinema.films;

create index resume_film_fki
  on cinema.resumes(film_id);

alter table cinema.resumes
add  CONSTRAINT resume_langue_fk FOREIGN KEY (langue)
        REFERENCES i18n.langue ("code-3") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;

\copy cinema.resumes (film, langue, texte) from './44-resumes.csv' delimiter ',' csv header quote '"' escape '''' encoding 'utf8';

-- SELECT * from cinema.resume WHERE ts @@ to_tsquery('french', 'romancier');
