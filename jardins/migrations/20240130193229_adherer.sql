\connect jardins;

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
declare
  _adhesion_id integer;
  _saison_id bigint;
begin
  -- Récupère la dernière saison
  select saison_id
  into _saison_id
  from saisons
  order by date_debut desc
  limit 1;

  -- Vérifie si une adhésion existe déjà pour cette saison
  select adhesion_id
  into _adhesion_id
  from adhesions
  where adherent_id = _adherent_id and saison_id = _saison_id;

  -- Si une adhésion existe déjà, la retourner
  if found then
    return _adhesion_id;
  end if;

  -- Sinon, insérer une nouvelle adhésion
  insert into adhesions (jardin_id, adherent_id, date_adhesion, montant, saison_id)
  select a.jardin_id, a.adherent_id, now(), c.montant, _saison_id
  from adherents a
  join cotisations c on c.profil_id = a.profil_id and c.saison_id = _saison_id
  where a.adherent_id = _adherent_id
  returning adhesion_id into _adhesion_id;

  -- Retourner la nouvelle adhésion
  return _adhesion_id;
end;
$function$;

