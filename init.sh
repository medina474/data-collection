#!/bin/bash

set -a
source .env
set +a

export PGPASSWORD

./migrations.sh migrations/cinema $PGHOST $PGPORT $PGUSER $DB_NAME
