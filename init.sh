#!/bin/bash

PGPASSWORD==$(kwallet-query -f "Secret Service" -r "PGPASSWORD" kdewallet)
export PGPASSWORD

PGHOST=localhost
PGPORT=5432
PGUSER=iutsd
DB_NAME=iutsd

psql -h $2 -p $3 -U postgres -d $5 -f "000-iutsd.sql"

PGPASSWORD==$(kwallet-query -f "Secret Service" -r "IUTSD" kdewallet)
export PGPASSWORD

./migrations.sh migrations/cinema $PGHOST $PGPORT $PGUSER $DB_NAME
