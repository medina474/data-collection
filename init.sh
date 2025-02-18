#!/bin/bash

PGPASSWORD=1234
export PGPASSWORD

PGHOST=localhost
PGPORT=5432
PGUSER=postgres
DB_NAME=jardins

./migrations.sh migrations/biblio $PGHOST $PGPORT $PGUSER $DB_NAME
