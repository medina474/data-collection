drop table if exists cinema.synopsis;

create table if not exists cinema.synopsis (
  film uuid not null,
  langue text not null,
  texte text not null
);

alter table cinema.synopsis
  add  CONSTRAINT synopsis_film_fk FOREIGN KEY (film)
        REFERENCES cinema.film (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;

alter table cinema.synopsis
  add  CONSTRAINT synopsis_langue_fk FOREIGN KEY (langue)
        REFERENCES i18n.langue ("code-3") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;
