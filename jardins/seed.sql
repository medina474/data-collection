\COPY plannings FROM 'data/plannings-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY tournees FROM 'data/tournees.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY distributions FROM 'data/distributions.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY adherents(adherent_id,jardin_id,adherent,profil_id,depot_id,email,date_sortie,adresse_id) FROM 'data/adherents.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY abonnements(abonnement_id,adherent_id,panier_id) FROM 'data/abonnements-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY propositions(frequence_id, planning_id) FROM 'propositions-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');

update abonnements set saison_id = 1;

\COPY livraisons_import FROM 'livraisons-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');

insert into livraisons (jardin_id, abonnement_id, distribution_id, produit_id, qte, livre, planning_id) 
select 1 as jardin_id, 
  li.id_abonnement as abonnement_id, 
  depot as distribution_id,
  li.produit_id,  
  li.qte,
  CASE
    WHEN livre = 0 THEN 'à livrer'::livraison
    WHEN livre = 1 THEN 'livré'::livraison
  END, 
  p.planning_id  as planning_id
from livraisons_import li  
join plannings p on p.jour = li.jour;
