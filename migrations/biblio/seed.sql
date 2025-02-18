\COPY biblio.auteurs FROM 'backup/biblio/auteurs-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('biblio.auteurs', 'auteur_id'), MAX(auteur_id))
from biblio.auteurs;

\COPY biblio.oeuvres FROM 'backup/biblio/oeuvres-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('biblio.oeuvres', 'oeuvre_id'), MAX(oeuvre_id))
from biblio.oeuvres;

\COPY biblio.participe FROM 'backup/biblio/participe-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');

\COPY biblio.editions FROM 'backup/biblio/editions-timpowers.csv' (FORMAT CSV, header, ENCODING 'UTF8');
select setval(pg_get_serial_sequence('biblio.editions', 'edition_id'), MAX(edition_id))
from biblio.editions;

\COPY biblio.incorpore FROM 'backup/biblio/incorpore.csv' (FORMAT CSV, header, ENCODING 'UTF8');
