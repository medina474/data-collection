create view orphan_abonnements
  with (security_invoker=on)
  as
select b.*
  from abonnements b
    left join adherents a on a.adherent_id = b.adherent_id
  where a.adherent_id is null;

comment on view orphan_abonnements is 'Abonnements dont l''adhérent n''existe pas.';

create view orphan_distributions
  with (security_invoker=on)
  as
select d.*
  from distributions d
    left join depots d2 on d2.depot_id = d.depot_id
  where d2.depot_id is null;

comment on view orphan_abonnements is 'Distributions dont le dépôt n''existe pas.';

create view orphan_abonnements_distributions
  with (security_invoker=on)
  as
select a.* from abonnements a
  left join livraisons l on a.abonnement_id = l.abonnement_id
  where l.livraison_id is null;

comment on view orphan_abonnements_distributions is 'Abonnements sans livraisons associées';

create view orphan_distributions_planning
  with (security_invoker=on)
  as
  select l.*
  from livraisons l
    left join plannings p on p.planning_id = l.planning_id
  where p.planning_id is null;

create view adherents_sans_abonnement
  with (security_invoker=on)
  as
select a.*
  from adherents a
    left join abonnements b on a.adherent_id = b.adherent_id
  where b.abonnement_id is null;
