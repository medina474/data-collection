drop table if exists cinema.salle;

create table if not exists cinema.salle (
  id integer not null primary key generated by default as identity,
  etablissement integer not null,
  salle text not null,
  sieges integer not null,
  CONSTRAINT salle_etablissement_fk FOREIGN KEY (etablissement)
        REFERENCES cinema.etablissement (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

copy cinema.salle (etablissement, salle, sieges)
  from '/tmp/43-salle.csv' delimiter ','
  csv header quote '"' escape ''''
  encoding 'utf8';


drop table if exists cinema.seance;

create table if not exists cinema.seance (
 id integer not null primary key generated by default as identity,
  film uuid not null,
  salle integer not null,
  seance date not null,
  CONSTRAINT seance_salle_fk FOREIGN KEY (salle)
        REFERENCES cinema.salle (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT seance_film_fk FOREIGN KEY (film)
        REFERENCES cinema.film (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
