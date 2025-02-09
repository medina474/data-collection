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
