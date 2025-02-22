create or replace view biblio.view_auteurs as
  select a.auteur_id, a.nom, count(p.oeuvre_id) from biblio.auteurs a
    left join biblio.participe p on p.auteur_id = a.auteur_id
  group by a.auteur_id, a.nom
  order by count(p.oeuvre_id);

create or replace view biblio.view_editions as
  select o.oeuvre_id, o.titre, count(i.edition_id)
  from biblio.oeuvres o
  left join biblio.incorpore i on o.oeuvre_id = i.oeuvre_id
  group by o.oeuvre_id, o.titre
  order by count(i.edition_id);
