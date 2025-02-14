\COPY adherents(adherent_id,jardin_id,adherent,profil_id,depot_id,email,date_sortie,adresse_id) FROM 'data/adherents.csv' (FORMAT CSV, header, ENCODING 'UTF8');

\COPY plannings FROM 'data/plannings-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY tournees FROM 'data/tournees.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY distributions FROM 'data/distributions.csv' (FORMAT CSV, header, ENCODING 'UTF8');

\COPY propositions(frequence_id, planning_id) FROM 'propositions-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');

update abonnements set saison_id = 1;
