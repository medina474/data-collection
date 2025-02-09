create view stat_adherents as
select j.jardin_id, j.jardin,
    count(a.*) as nb_adherents
  from jardins j
    left join adherents a on a.jardin_id = j.jardin_id
  group by j.jardin_id;

comment on view stat_adherents is 'Nombre total d''adhérents par jardins.';

create view stat_adherents_profils as
select j.jardin_id, j.jardin, p.profil, 
    count(a.*) as nb_adherents
  from jardins j
    left join adherents a on a.jardin_id = j.jardin_id
    left join profils p on p.profil_id = a.profil_id 
  group by j.jardin_id, p.profil;

comment on view stat_adherents_profils is 'Nombre total d''adhérents par jardins et par profils.';

create view stat_abonnements as
select saison_id, count(*) 
  from abonnements
  group by saison_id;

comment on view stat_adherents_profils is 'Nombre total d''abonnements par saisons.';

create view stat_abonnements_paniers as
select saison_id, p.panier, count(quantite) 
  from abonnements a
    join paniers p on p.panier_id = a.panier_id
  group by a.saison_id, p.panier;

comment on view stat_adherents_profils is 'Nombre total d''abonnements par saisons et par paniers.';

create view stat_depots as
select j.jardin_id, j.jardin,
  count(d.*) as nb_depots
  from jardins j
    left join depots d on d.jardin_id = j.jardin_id
  group by j.jardin_id;

comment on view stat_depots is 'Nombre de dépôts par jardins.';

create view stat_livraisons as 
select count(*) 
  from livraisons l;

comment on view stat_livraisons is 'Nombre de livraisons.';

create view stat_livraisons_produits as 
select p.produit, sum(qte) 
  from livraisons l
join produits p on l.produit_id = p.produit_id
group by (p.produit);

comment on view stat_livraisons_produits is 'Nombre de produits livrés.';

create view stat_livraisons_semaines as
select date_part('week',p.jour) as semaine, count(*), sum(qte)
  from livraisons l 
    join plannings p on l.planning_id = p.planning_id 
  group by semaine;

comment on view stat_livraisons_produits is 'Nombre de livraisons par semaines.';

create view stat_livraisons_semaines_tournees as
select date_part('week',p.jour) as semaine, 
  d.tournee_id, t.tournee,
  count(*), sum(qte)
  from livraisons l 
    join plannings p on l.planning_id = p.planning_id 
    join distributions d on l.distribution_id = d.distribution_id 
    join tournees t on t.tournee_id = d.tournee_id
  group by semaine,d.tournee_id,t.tournee;

comment on view stat_livraisons_produits is 'Nombre de livraisons par semaines et par tournées.';

create view stat_livraisons_semaines_tournees_depots as
select date_part('week',p.jour) as semaine, 
  d.tournee_id, t.tournee, d2.depot,
  count(*), sum(qte)
  from livraisons l 
  join plannings p on l.planning_id = p.planning_id 
  join distributions d on l.distribution_id = d.distribution_id
  join depots d2 on d2.depot_id = d.depot_id
  join tournees t on t.tournee_id = d.tournee_id
  where date_part('week',p.jour) = 16
  group by semaine,d.tournee_id,t.tournee,d2.depot;

comment on view stat_livraisons_produits is 'Nombre de livraisons par semaines par tournées et par dépôts.';
