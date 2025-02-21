set search_path to public, extensions;

create table villes (
  nom text not null,
  pays_code text,
  admin_name text,
  capital text,
  population int,
  coordonnees geometry(Point, 4326) default null::geometry
);

create temporary table villes_tmp (
  city text,
  city_ascii text,
  lat decimal(18, 15),
  lng decimal(18, 15),
  country text,
  iso2 text,
  iso3 text,
  admin_name text,
  capital text,
  population int,
  id text
);

\copy villes_tmp from './worldcities.csv' (FORMAT CSV, header, delimiter ',', ENCODING 'UTF8');

insert into villes (nom, pays_code, admin_name, capital, population, coordonnees)
select city, upper(iso2), admin_name, capital, population, st_makepoint(lng, lat)
from villes_tmp
join pays on pays.code2 = upper(villes_tmp.iso2);

update villes
  set admin_name = r.region_code
  from  regions r
  where hierarchie ~ ('*.'||villes.pays_code||'.*')::lquery
    and region = villes.admin_name;

drop table villes_tmp;

alter table only villes
  add foreign key (pays_code)
  references pays (code2) match simple
  on update no action
  on delete no action;

select '=============== WORLDCITIES' as msg;
