create or replace function abonner(_adherent_id bigint, _panier_id bigint, _distribution_id bigint, _date date, _quantite int default null)
 returns bigint
 language plpgsql
as $function$
declare
  _jardin_id bigint;
  _saison_id bigint;
  _frequence_id bigint;
  _calendrier_id bigint;
  _abonnement_id bigint;
  _produit_id bigint;
  _nombre int;
  _q int;
  _montant numeric;
  _date_debut date;
  _date_fin date;
begin

  -- Vérifier la cotisation de l'adhérent
  select a.jardin_id, a.saison_id, s.date_debut, s.date_fin
    into _jardin_id, _saison_id, _date_debut, _date_fin
    from adhesions a
      join saisons s on s.saison_id = a.saison_id
    where a.adherent_id = _adherent_id
      and _date between s.date_debut and s.date_fin;

  if not found then
    raise 'Pas d''adhesion pour cet adhérent.';
  end if;

  -- Récupérer le panier, sa quantité si le paramètre est null
  select coalesce(_quantite, quantite), produit_id, prix, quantite
    into _nombre, _produit_id, _montant, _q
  	from paniers
  	where panier_id = _panier_id;

  if not found then
    raise 'Ce panier n''existe pas.';
  end if;

  -- Récupérer le calendrier
  select calendrier_id into _calendrier_id
    from tournees t
      join distributions on distributions.tournee_id = t.tournee_id
    where distribution_id = _distribution_id;

  if not found then
    raise 'Pas de calendrier';
  end if;

  -- Mais d'après la date quel est le nombre de livraisons qu'il est possible de faire
  select least(count(*), _nombre) into _nombre
    from plannings p
    where calendrier_id = _calendrier_id
    and jour between _date and _date_fin;

  -- Insérer l'abonnement
  insert into abonnements
    (adherent_id, panier_id, montant, nombre, date_debut, saison_id)
  select _adherent_id, _panier_id, _montant / _q * _nombre, _nombre, _date, _saison_id
    returning abonnement_id into _abonnement_id;

-- Insérer les dates de livraisons
-- Chercher si des propositions existent pour la fréquence de ce panier
-- sinon prendre toutes les dates du planning
  with
  une_proposition as (
	  select p.planning_id
    from propositions pp
      join plannings p on p.planning_id = pp.planning_id
    where frequence_id = _frequence_id
      and calendrier_id = _calendrier_id
      and jour between _date and _date_fin
  ),
  final_selection as (
    select *
      from une_proposition
    union all
      select p.planning_id
        from plannings p
        where calendrier_id = _calendrier_id
          and jour between _date and _date_fin
          and not exists (select 1 from une_proposition)
  )
  insert into livraisons (jardin_id, abonnement_id, distribution_id, produit_id, qte, livre, planning_id)
	select _jardin_id, _abonnement_id, _distribution_id, _produit_id, 1, 'à livrer'::livraison, planning_id
    from final_selection;

  return _abonnement_id;
end; $function$;
