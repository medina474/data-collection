\COPY tournees TO 'data/tournees.csv' (FORMAT CSV, header, ENCODING 'UTF8');
\COPY plannings FROM 'data/plannings-2025.csv' (FORMAT CSV, header, ENCODING 'UTF8');
