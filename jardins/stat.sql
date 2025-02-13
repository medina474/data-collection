create view stat_adherents  with (security_invoker=on) as
select j.jardin_id, j.jardin,
    count(a.*) as nb_adherents
  from jardins j
    left join adherents a on a.jardin_id = j.jardin_id
  group by j.jardin_id;

comment on view stat_adherents is 'Nombre total d''adhérents par jardins.';

create view stat_adherents_profils  with (security_invoker=on) as
select j.jardin_id, j.jardin, p.profil,
    count(a.*) as nb_adherents
  from jardins j
    left join adherents a on a.jardin_id = j.jardin_id
    left join profils p on p.profil_id = a.profil_id
  group by j.jardin_id, p.profil;

comment on view stat_adherents_profils is 'Nombre total d''adhérents par jardins et par profils.';

create view stat_abonnements  with (security_invoker=on) as
select saison_id, count(*)
  from abonnements
  group by saison_id;

comment on view stat_adherents_profils is 'Nombre total d''abonnements par saisons.';

create view stat_abonnements_paniers  with (security_invoker=on) as
select saison_id, p.panier, count(quantite)
  from abonnements a
    join paniers p on p.panier_id = a.panier_id
  group by a.saison_id, p.panier;

comment on view stat_adherents_profils is 'Nombre total d''abonnements par saisons et par paniers.';

create view stat_depots  with (security_invoker=on) as
select j.jardin_id, j.jardin,
  count(d.*) as nb_depots
  from jardins j
    left join depots d on d.jardin_id = j.jardin_id
  group by j.jardin_id;

comment on view stat_depots is 'Nombre de dépôts par jardins.';

create view stat_livraisons  with (security_invoker=on) as
select count(*)
  from livraisons l;

comment on view stat_livraisons is 'Nombre de livraisons.';

create view stat_livraisons_produits  with (security_invoker=on) as
select produit, sum(qte)
  from detail_livraisons l
group by (produit);

comment on view stat_livraisons_produits is 'Nombre de produits livrés.';

create view stat_livraisons_semaines  with (security_invoker=on) as
select semaine, count(*), sum(qte)
  from detail_livraisons l
  group by semaine;

comment on view stat_livraisons_produits is 'Nombre de livraisons par semaines.';

create view stat_livraisons_semaines_tournees  with (security_invoker=on) as
select semaine,
  tournee_id, tournee,
  count(*), sum(qte)
  from detail_livraisons l
  group by semaine, tournee_id, tournee;

comment on view stat_livraisons_produits is 'Nombre de livraisons par semaines et par tournées.';

create view stat_livraisons_semaines_tournees_depots  with (security_invoker=on) as
select semaine,
  tournee_id, tournee, depot,
  count(*), sum(qte)
  from detail_livraisons l
  group by semaine, tournee_id, tournee, depot;

comment on view stat_livraisons_produits is 'Nombre de livraisons par semaines par tournées et par dépôts.';

create view stat_livraisons_depots  with (security_invoker=on) as
select depot, sum(qte)
  from detail_livraisons l
group by (depot);

create view stat_depots_adherents  with (security_invoker=on) as
select depot, count(distinct adherent_id)
  from detail_livraisons l
group by depot;

create view stat_calendriers  with (security_invoker=on) as
select c.calendrier_id,
    c.calendrier,
    s.saison,
    count(p.*) as dates
  from calendriers c
    left join plannings p on p.calendrier_id = c.calendrier_id
    join saisons s on s.jardin_id = c.jardin_id and p.jour >= s.date_debut and p.jour <= s.date_fin
  group by c.calendrier_id, s.saison_id, s.saison;

comment on view stat_livraisons_produits is 'Nombre de jours dans le planning par calendrier.';

create view livraisons_preparations
with (security_invoker=on)
  as
select l.semaine, p.jour, l.preparation_id, l.preparation,
  l.produit, sum(qte)
  from detail_livraisons l
    inner join preparations p on p.preparation_id = l.preparation_id
  group by l.semaine, p.jour, l.preparation_id, l.preparation, l.produit;

create view gpao_preparations
  with (security_invoker=on)
  as
select l.semaine, p.jour, l.preparation_id, l.preparation,
  l.produit, sum(l.qte)
  from detail_livraisons l
    inner join preparations p on p.preparation_id = l.preparation_id
    where livre = 'à livrer'
  group by l.semaine, p.jour, l.preparation_id, l.preparation, l.produit;

create view gpao_tournees
  with (security_invoker=on)
  as
select l.semaine, l.preparation_id, l.tournee_id, l.tournee, l.jour,
  l.produit, sum(l.qte)
  from detail_livraisons l
where livre = 'à livrer'
and semaine = date_part('week',now())
group by l.semaine, l.preparation_id, tournee_id, tournee, jour, produit
order by tournee_id;

create view gpao_depots
  with (security_invoker=on)
  as
select l.semaine, l.tournee_id, l.tournee, l.jour, l.depot,
  l.produit, sum(l.qte)
  from detail_livraisons l
where livre = 'à livrer'
group by l.semaine, l.tournee_id, tournee, jour, depot, produit
order by l.tournee_id;

create view gpao_adherents
  with (security_invoker=on)
  as
select l.semaine, l.tournee_id, l.tournee, l.depot, l.adherent_id, l.adherent,
  l.produit, sum(l.qte)
  from detail_livraisons l
where livre = 'à livrer'
group by l.semaine, tournee_id, tournee, jour, depot, l.adherent_id, l.adherent, produit
order by l.tournee_id;

create view gpao_livrer
  with (security_invoker=on)
  as
select semaine, preparation_id, preparation,
  tournee_id, tournee, produit, sum(qte)
from detail_livraisons l
group by semaine, preparation_id, preparation, tournee_id, tournee, produit;

-- Adhérents profil salariés sont ceux qui sont livrés lors de la tournée 6
update adherents a set profil_id = 3
where exists (select 1 from detail_livraisons dl where dl.adherent_id = a.adherent_id and dl.tournee_id = 6);
