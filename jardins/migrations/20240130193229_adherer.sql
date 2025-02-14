create or replace function reconduire()
 returns integer
 language plpgsql
as $function$
begin
  return (
    with insertion as (
      select a.adherent_id
        from adherents a,
        lateral adherer(a.adherent_id)
      where a.date_sortie is null
    )
    select count(*) from insertion
  );
end;
$function$;

create or replace function adherer(_adherent_id bigint)
 returns integer
 language plpgsql
as $function$
begin
  return coalesce (
    (
      select adhesion_id
        from adhesions
        where adherent_id = _adherent_id
          and saison_id = (select saison_id from saisons order by date_debut desc limit 1)
    ),
    (
      insert into adhesions (jardin_id, adherent_id, date_adhesion, montant, saison_id)
        select a.jardin_id, adherent_id, now(), c.montant, s.saison_id
          from adherents a
            join cotisations c on c.profil_id = a.profil_id
            join (select saison_id from saisons order by date_debut desc limit 1) s
              on c.saison_id = s.saison_id
          where adherent_id = _adherent_id
          returning adhesion_id
    )
  );
end;
$function$;
