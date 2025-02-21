\COPY biblio.auteurs FROM './auteurs-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('biblio.auteurs', 'auteur_id'), MAX(auteur_id))
from biblio.auteurs;

\COPY biblio.oeuvres FROM './oeuvres-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('biblio.oeuvres', 'oeuvre_id'), MAX(oeuvre_id))
from biblio.oeuvres;

\COPY biblio.participe FROM './participe-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');

\COPY biblio.editions FROM './editions-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('biblio.editions', 'edition_id'), MAX(edition_id))
from biblio.editions;

\COPY biblio.incorpore FROM './incorpore.csv' (FORMAT CSV, header, ENCODING 'UTF8');
