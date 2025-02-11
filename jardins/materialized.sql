create materialized view detail_depots as
select d.depot_id,
    d.jardin_id,
    d.depot,
    d.capacite,
    a.adresse,
    a.codepostal,
    a.ville,
    a.localisation,
    c.contact,
    c.telephone,
    c.email
  from depots d
    left join adresses a on a.adresse_id = d.adresse_id
    left join contacts c on c.contact_id = d.contact_id;

refresh materialized view detail_depots with data;

create materialized view detail_livraisons as
select l.livraison_id, l.jardin_id, 
    l.abonnement_id, a.adherent_id, a2.adherent, a2.adresse_id as adherent_adresse_id,
    l.distribution_id, d.depot_id, d2.depot, d2.adresse_id as depot_adresse_id,
    CASE
    WHEN d2.adresse_id is not null THEN d2.adresse_id
    WHEN a2.adresse_id is not null THEN a2.adresse_id
    else NULL
    end as adresse_id, 
    d.tournee_id, t.tournee,
    t.preparation_id, pp.preparation, pp.jour as jsemaine,
    l.produit_id, p.produit,
    qte, livre, 
    l.planning_id, p2.jour, date_part('week', p2.jour) as semaine, date_part('month', p2.jour) as mois
  from livraisons l 
    join distributions d on d.distribution_id = l.distribution_id
    join depots d2 on d2.depot_id = d.depot_id 
    join tournees t on t.tournee_id = d.tournee_id 
    join preparations pp on pp.preparation_id = t.preparation_id 
    join produits p on p.produit_id  = l.produit_id 
    join abonnements a on a.abonnement_id = l.abonnement_id 
    join adherents a2 on a2.adherent_id = a.adherent_id 
    join plannings p2 on p2.planning_id = l.planning_id;

refresh materialized view detail_livraisons with data;
