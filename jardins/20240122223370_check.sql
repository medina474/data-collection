

create view jardins.check_adherent_jardin
 with (security_invoker=on)
 as
 select a.adherent_id,
    a.adherent
  from jardins.adherents a
    join jardins.adhesions d on a.adherent_id = d.adherent_id
  where a.jardin_id <> d.jardin_id;

comment on view jardins.check_adherent_jardin is 'Vérifie qu''adhérent cotise bien au jardin dont il fait partie';

create view jardins.check_plannings_feries
  with (security_invoker=on)
  as
  select p.jour
  from jardins.plannings p
    join jardins.feries f on f.jour = p.jour;

comment on view jardins.check_plannings_feries is 'Vérifie qu''un jour du planning n''est pas planifié un jour férié.';

create view jardins.check_plannings_semaine
  with (security_invoker=on)
  as
  select p.planning_id, p.jour, s.saison from jardins.plannings p
  join jardins.saisons s on p.jour between s.date_debut and s.date_fin
  where
    date_part ('week', p.jour) in (
      select semaine from jardins.fermetures where fermetures.saison_id = s.saison_id
    );

comment on view jardins.check_plannings_semaine is 'Vérifie qu''un jour n''est pas planifié pendant une semaine de fermeture.';

create view jardins.check_abonnements_qte
  with (security_invoker=on)
  as
select a.abonnement_id, a.panier_id,
  a.nombre as prévu, sum(qte) as plannifié
from jardins.abonnements a
  left join jardins.livraisons l on l.abonnement_id = a.abonnement_id
group by a.abonnement_id, a.panier_id
having a.nombre <> sum(qte);

comment on view jardins.check_plannings_semaine is 'Vérifie le nombre de livraisons planifiées par rapport au nombre prévu par l''abonnement.';
