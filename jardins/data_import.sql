create table livraisons_import (
  id_livraison bigint,
  semaine smallint,
  livre smallint,
  qte numeric,
  depot_id int,
  annee int,
  jour date,
  produit text,
  produit_id int,
  depot_text text,
  abonnement_id bigint
);

alter table livraisons_import enable row level security;

create policy "Lecture publique"
on livraisons_import
as permissive
for select
to public
using (true);

\COPY livraisons_import(id_livraison,semaine,livre,qte,depot_text,annee,jour,produit,abonnement_id) FROM 'livraisons-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
