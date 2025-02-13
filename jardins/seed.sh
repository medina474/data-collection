#!/bin/bash

# Récupérer le mot de passe PostgreSQL depuis le wallet KDE
PGPASSWORD=$(kwallet-query -f "Secret Service" -r "Password for 'qjnieztpwnwroinqrolm' on 'Supabase CLI'" kdewallet)

# Exporter la variable d'environnement PGPASSWORD
export PGPASSWORD

PGHOST=aws-0-eu-west-3.pooler.supabase.com
PGPORT=6543
PGUSER=postgres.qjnieztpwnwroinqrolm
DB_NAME=postgres

SQL_DIR="migrations"

# Vérifie si le répertoire existe
if [ ! -d "$SQL_DIR" ]; then
  echo "Le répertoire $SQL_DIR n'existe pas."
  exit 1
fi

# Exécutez chaque fichier SQL dans le répertoire
for sql_file in "$SQL_DIR"/*.sql;
do
  if [ -f "$sql_file" ]; then
    echo "Exécution de $sql_file..."
    psql -h $PGHOST -p $PGPORT -U $PGUSER -d $DB_NAME -f "$sql_file"
    if [ $? -ne 0 ]; then
      echo "Erreur lors de l'exécution de $sql_file"
      exit 1
    fi
  else
    echo "Aucun fichier SQL trouvé dans le répertoire $SQL_DIR."
  fi
done

echo "Tous les scripts SQL ont été exécutés avec succès."


psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f seed.sql
psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f materialized.sql
psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f details.sql
psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f stat.sql
psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f orphan.sql

psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f data_import.sql
psql -h $PGHOST -p $PGPORT -d $DB_NAME -U $PGUSER -f data_copy.sql
