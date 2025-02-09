\COPY adherents(adherent_id,jardin_id,adherent,profil_id,depot_id,email,date_sortie,adresse_id) TO 'data/adherents.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY plannings TO 'data/plannings-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY tournees TO 'data/tournees.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY distributions TO 'data/distributions.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY abonnements(abonnement_id,adherent_id,panier_id) TO 'data/abonnements-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
