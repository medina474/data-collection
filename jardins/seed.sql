\COPY adherents(adherent_id,jardin_id,adherent,depot_id) FROM 'adherents.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY abonnements(abonnement_id,adherent_id,panier_id) FROM 'abonnements-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY livraisons_import FROM 'livraisons-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
