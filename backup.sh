# Récupérer le mot de passe PostgreSQL depuis le wallet KDE
PGPASSWORD=1234

# Exporter la variable d'environnement PGPASSWORD
export PGPASSWORD

PGHOST=localhost
PGPORT=5432
PGUSER=postgres

psql -h $PGHOST -p $PGPORT -d postgres -U $PGUSER -f backup.sql
