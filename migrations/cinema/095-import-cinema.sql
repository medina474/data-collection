\connect iutsd;

CREATE MATERIALIZED VIEW cinema.acteur AS
  SELECT p.id,
  CASE
    WHEN (p.artiste IS NOT NULL) THEN (p.artiste)::text
    ELSE (((p.prenom)::text || ' '::text) || (p.nom)::text)
  END AS nom,
  p.naissance,
  CASE
    WHEN (p.deces IS NULL) THEN date_part('year'::text, age((p.naissance)::timestamp with time zone))
    ELSE NULL::double precision
  END AS age,
  p.deces,
  p.nationalite,
  p.photo,
  count(c.*) AS nb_film
  FROM (cinema.equipe c
    JOIN cinema.personne p ON (c.personne = p.id))
  WHERE ((c.role)::text = 'acteur'::text)
  GROUP BY p.id
WITH NO DATA;

REFRESH MATERIALIZED VIEW cinema.acteur WITH DATA;

do $$
begin
   for counter in 1..1000 loop
	INSERT INTO cinema.seance (film, salle, seance)
  	VALUES ((SELECT id FROM cinema.film WHERE random() > 0.9 ORDER BY random() LIMIT 1)
    , (FLOOR(random()*77)+1)
    , (date(now() + trunc(random()  * 14) * '1 day'::interval)+ '21hour'::interval));
   end loop;
end; $$

-- https://stackoverflow.com/questions/12618232/copy-a-few-of-the-columns-of-a-csv-file-into-a-table
