create temporary table villes_tmp (
  type_commune text,
  code_commune text,
  code_region text,
  code_departement text,
  code_collectivite text,
  code_arrondissement text,
  type_nom text,
  nom_majuscule text,
  nom text,
  libelle text,
  code_canton text,
  commune_parente text
);

\copy villes_tmp from './v_commune_2023.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

insert into regions (region_code, hierarchie, region, administration)
select 'FR-'||code_commune, (hierarchie::text || '.FR-'||code_commune)::ltree, nom, 15
from villes_tmp, regions
where hierarchie ~ ('*.'||'FR-'||code_departement)::lquery;

drop table villes_tmp;
