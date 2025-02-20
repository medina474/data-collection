\connect iutsd;

CREATE OR REPLACE VIEW cinema.personne_sans_role
 AS
 SELECT personne.id,
    personne.prenom,
    personne.nom,
    count(equipe.personne) AS nb
   FROM cinema.personnes
     LEFT JOIN cinema.equipes ON equipe.personne = personne.id
  GROUP BY personne.id, personne.prenom, personne.nom
 HAVING count(equipe.personne) = 0;

ALTER TABLE cinema.personne_sans_role
    OWNER TO iutsd;

CREATE OR REPLACE VIEW cinema.film_sans_role
 AS
 SELECT film.titre,
    count(equipe.film) AS nb
   FROM cinema.films
     LEFT JOIN cinema.equipes ON equipe.film = film.id
  GROUP BY film.titre
 HAVING count(equipe.film) = 0;

ALTER TABLE cinema.film_sans_role
    OWNER TO iutsd;
