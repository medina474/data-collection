create view detail_jardins
as select j.jardin_id,
    j.jardin,
    j.tva,
    a.adresse,
    a.codepostal,
    a.ville,
    a.localisation,
    c.contact,
    c.telephone,
    c.email
  from jardins j
    left join adresses a on a.adresse_id = j.adresse_id
    left join contacts c on c.contact_id = j.contact_id;

create view detail_distributions as
select d.tournee_id, d.distribution_id, d.ordre, 
  p.depot as nom, ad.adresse, ad.codepostal, ad.ville, ad.localisation
	from distributions d
	inner join depots p on p.depot_id = d.depot_id 
	inner join adresses ad on p.adresse_id = ad.adresse_id
	where d.depot_id is not null
union
select d.tournee_id, d.distribution_id, d.ordre, 
  a.adherent as nom, ad.adresse, ad.codepostal, ad.ville, ad.localisation
	from distributions d
	inner join adherents a on a.adherent_id = d.adherent_id 
	inner join adresses ad on a.adresse_id = ad.adresse_id
	where d.adherent_id is not null;

create view detail_tournees
as select t.tournee_id, t.tournee, d.ordre, d.distribution_id, d.nom, 
  d.adresse, d.codepostal, d.ville, d.localisation 
  from tournees t
    join detail_distributions d on d.tournee_id = t.tournee_id
  order by t.ordre, d.ordre;
