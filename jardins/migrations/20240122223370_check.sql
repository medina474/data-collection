create view check_adherent_jardin
 with (security_invoker=on)
 as
 select a.adherent_id,
    a.adherent
  from adherents a
    join adhesions d on a.adherent_id = d.adherent_id
  where a.jardin_id <> d.jardin_id;

comment on view check_adherent_jardin is 'Vérifie qu''adhérent cotise bien au jardin dont il fait partie';

create view check_plannings_feries
  with (security_invoker=on)
  as
  select p.jour
  from (plannings p
    join feries f on ((f.jour = p.jour)));

comment on view check_plannings_feries is 'Vérifie qu''un jour n''est pas planifié un jour férié.';

create view check_plannings_semaine
  with (security_invoker=on)
  as
  select p.planning_id, p.jour, s.saison from plannings p
  join saisons s on p.jour between s.date_debut and s.date_fin
  where
    date_part ('week', p.jour) in (
      select semaine from fermetures where fermetures.saison_id = s.saison_id
    );

comment on view check_plannings_semaine is 'Vérifie qu''un jour n''est pas planifié pendant une semaine de fermeture.';

create view check_abonnements_qte
  with (security_invoker=on)
  as
select a.abonnement_id, a.panier_id,
  a.nombre as prévu, sum(qte) as plannifié
from abonnements a
left join livraisons l on l.abonnement_id = a.abonnement_id
group by a.abonnement_id, a.panier_id
having a.nombre <> sum(qte);

comment on view check_plannings_semaine is 'Vérifie le nombre de livraisons planifiées par rapport au nombre prévu par l''abonnement.';
