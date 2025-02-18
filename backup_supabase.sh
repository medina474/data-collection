# Récupérer le mot de passe PostgreSQL depuis le wallet KDE
PGPASSWORD=$(kwallet-query -f "Secret Service" -r "Password for 'qjnieztpwnwroinqrolm' on 'Supabase CLI'" kdewallet)

# Exporter la variable d'environnement PGPASSWORD
export PGPASSWORD

PGHOST=aws-0-eu-west-3.pooler.supabase.com
PGPORT=6543
PGUSER=postgres.qjnieztpwnwroinqrolm

psql -h $PGHOST -p $PGPORT -d postgres -U $PGUSER -f backup.sql
