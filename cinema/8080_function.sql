set search_path to public, cinema, extensions;

create function cinema.films_with_texte(mot text)
returns table (film_id cinema.films.film_id%TYPE
  , titre cinema.films.titre%TYPE)
language sql
as $function$
	select f.film_id, f.titre from cinema.films f
    inner join cinema.resumes r on f.film_id = r.film_id
  where ts @@ to_tsquery('french', mot);
$function$;

create function cinema.reco()
  returns table (id cinema.films.film_id%TYPE
  ,titre cinema.films.titre%type
  ,votants cinema.votes.votants%type
  ,moyenne cinema.votes.moyenne%type
  ,score float)
  language 'plpgsql'
as $body$
declare
  C float;
  m int;
begin
  select avg(f.vote_moyenne) into C
    from cinema.votes f;
  select percentile_disc(0.9) into m
    within group (order by cinema.votes.votants)
    from cinema.films;
  return query select f.film_id, f.titre, f.votants
  	,f.vote_moyenne
  	,(f.votants::numeric /(f.votants::numeric + m) * f.vote_moyenne) + (m /(f.votants::numeric + m) * C) as score
    from cinema.votes f
    where f.votants >= m
    order by score desc
    limit 10;
end
$body$;

create function cinema.films_par_acteur (id varchar)
RETURNS TABLE(film_id uuid, titre text, titre_original text,
annee int, sortie date, duree int, votants int, vote_moyenne numeric(4,2), franchise text, alias text[], genres text[], motscles text[], resume text) AS
$$
BEGIN
  return query select f.film_id, f.titre, f.titre_original,
      f.annee, f.sortie, f.duree, f.vote_votants, f.vote_moyenne,
      f2.franchise
      , array_agg(distinct e.alias) as alias
      , array_agg(distinct g.genre) as genres
      , array_agg(distinct mc.motcle) as motscles
      , r.resume
    from cinema.films f
    inner join cinema.equipes e on e.film_id = f.film_id and e.alias is not null
    left join cinema.films_genres fg on fg.film_id = f.film_id
    left join cinema.genres g on g.genre_id = fg.genre_id
    left join cinema.franchises f2 on f2.franchise_id = f.franchise_id
    left join lateral (SELECT r2.resume FROM cinema.resumes r2 WHERE r2.film_id  = f.film_id
      order by array_position(array['deu','fra','eng'], r2.langue_code)
      fetch first 1 row only ) r on true
    left join cinema.films_motscles fmc on fmc.film_id = f.film_id
    left join cinema.motscles mc on mc.motcle_id = fmc.motcle_id
    where e.personne_id = id::uuid
    group by f.film_id, f.titre, f.titre_original, f2.franchise, f.vote_votants, e.ordre, r.resume
    order by e.ordre, vote_votants desc;
END;
$$
language plpgsql volatile;

create function cinema.etablissements_in_view(min_lat float, min_long float, max_lat float, max_long float)
returns table (etablissement_id cinema.etablissements.etablissement_id%TYPE
  , nom cinema.etablissements.nom%TYPE
	, ville cinema.etablissements.ville%TYPE
	, voie cinema.etablissements.voie%TYPE
	, codepostal cinema.etablissements.codepostal%TYPE
	, lat float, long float)
language sql
as $function$
	select etablissement_id
		, nom
		, ville
		, voie
		, codepostal
		, st_y(coordonnees::geometry) as lat, st_x(coordonnees::geometry) as long
	from cinema.etablissements
	where coordonnees OPERATOR(&&) ST_SetSRID(ST_MakeBox2D(ST_Point(min_long, min_lat), ST_Point(max_long, max_lat)), 4326)
$function$;
