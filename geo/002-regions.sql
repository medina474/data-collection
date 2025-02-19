set search_path to public, extensions;

create extension ltree schema extensions;

create table regions (
  region_code character varying(8),
  hierarchie ltree,
  region text not null,
  division text,
  administration text,
  capitale text
);

comment on column regions.region_code is 'UN Standard country or area codes for statistical use (M49)';

create index path_gist_idx
  on regions using gist (hierarchie);

create index path_idx
  on regions using btree (hierarchie);

alter table regions
  add primary key (region_code);

\copy regions FROM './regions/regions.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/at.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/au.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/be.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/bl.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ca.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ch.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/de.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/dk.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/es.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/fi.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/fr.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/gb.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/gr.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/hr.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/hu.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/it.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/jp.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/lt.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/lu.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/mx.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/nl.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/pl.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/pt.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ro.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/se.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/ua.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');
\copy regions FROM './regions/us.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

select '=============== FIN IMPORTATION DATA REGIONS' as msg;
