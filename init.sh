#!/bin/bash

PGPASSWORD=1234
export PGPASSWORD

PGHOST=localhost
PGPORT=5432
PGUSER=postgres
DB_NAME=jardins

./migrations.sh jardins/migrations $PGHOST $PGPORT $PGUSER $DB_NAME

#psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f seed.sql
#psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f materialized.sql
#psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f stat.sql
#psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f orphan.sql

#psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f data_import.sql
#psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f data_copy.sql
