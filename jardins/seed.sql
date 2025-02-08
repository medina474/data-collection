\COPY tournees FROM 'tournees.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY adherents(adherent_id,jardin_id,adherent,profil_id,depot_id) FROM 'adherents.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY abonnements(abonnement_id,adherent_id,panier_id) FROM 'abonnements-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY distributions FROM 'distributions.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY plannings FROM 'plannings-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY propositions(frequence_id, planning_id) FROM 'propositions-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');

\COPY livraisons_import FROM 'livraisons-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
