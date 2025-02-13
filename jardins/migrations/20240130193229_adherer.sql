create or replace function reconduire()
 returns integer
 language plpgsql
as $function$
declare
  _saison_id bigint;
  _nb bigint;
begin

with insertion as (
select a.adherent_id
from adherents a
  LATERAL adherer(a.adherent_id)
  where a.date_sortie is null)
select count(*) into _nb from insertion;

return _nb;

end; $function$
;

create or replace function adherer(_adherent_id bigint)
 returns integer
 language plpgsql
as $function$
declare
  _saison_id bigint;
  _adhesion_id bigint;
begin

-- Prend la dernière saison
select saison_id into _saison_id
  from saisons s
  order by date_debut desc;

select adhesion_id into _adhesion_id
  from adhesions
  where adherent_id = _adherent_id and saison_id = _saison_id;

if found then
  return _adhesion_id;
end if;

insert into adhesions (jardin_id, adherent_id, date_adhesion, montant, saison_id)
  select a.jardin_id, adherent_id, now(), c.montant, _saison_id
  from adherents a
  join cotisations c on c.profil_id = a.profil_id and c.saison_id = _saison_id
  where adherent_id = _adherent_id returning adhesion_id into _adhesion_id;

return _adhesion_id;

end; $function$
;
