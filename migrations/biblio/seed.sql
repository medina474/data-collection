\COPY auteurs FROM '/backup/biblio/auteur-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('auteurs', 'auteur_id'), MAX(auteur_id))
from auteurs;

\COPY oeuvres FROM '/backup/biblio/oeuvres-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('oeuvres', 'oeuvre_id'), MAX(oeuvre_id))
from oeuvres;

\COPY participe FROM '/backup/biblio/participe-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');

\COPY editions FROM '/backup/biblio/editions-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('editions', 'edition_id'), MAX(oeuvre_id))
from editions;

\COPY incorpore FROM '/backup/biblio/incorpore.csv' (FORMAT CSV, header, ENCODING 'UTF8');
