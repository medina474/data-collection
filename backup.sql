\connect jardins
set search_path to public, extensions;

\COPY adherents(adherent_id,jardin_id,adherent,profil_id,depot_id,email,date_sortie,adresse_id) TO 'backup/jardins/adherents.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY plannings TO 'backup/jardins/plannings-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY tournees TO 'backup/jardins/tournees.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY distributions TO 'backup/jardins/distributions.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY abonnements(abonnement_id,adherent_id,panier_id) TO 'backup/jardins/abonnements-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY (select adresse_id, jardin_id, adresse, codepostal, ville, ST_AsText(localisation) AS localisation FROM adresses) TO 'backup/jardins/adresses.csv' (FORMAT CSV, header, ENCODING 'UTF8');
