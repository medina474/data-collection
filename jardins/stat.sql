create view stat_adherents as
select j.jardin_id, j.jardin,
    count(a.*) as nb_adherents
  from jardins j
    left join adherents a on a.jardin_id = j.jardin_id
  group by j.jardin_id;

create view stat_abonnements as
select saison_id, count(*) 
  from abonnements
  group by saison_id;

create view stat_abonnements_paniers as
select saison_id, p.panier, count(quantite) 
  from abonnements a
    join paniers p on p.panier_id = a.panier_id
  group by a.saison_id, p.panier;
