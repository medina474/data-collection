#!/bin/bash

set -a
source .env
set +a

export PGPASSWORD

psql -h $PGHOST -p $PGPORT -U $PGUSER -d $DB_NAME -c "drop schema cinema cascade;"

# Vérifie si le répertoire existe
if [ ! -d "$1" ]; then
  echo "Le répertoire $1 n'existe pas."
  exit 1
fi

cd $1

# Exécutez chaque fichier SQL dans le répertoire
for sql_file in ./*.sql;
do
  if [ -f "$sql_file" ]; then
    echo "Exécution de $sql_file..."
    psql -h $PGHOST -p $PGPORT -U $PGUSER -d $DB_NAME -f "$sql_file"
    if [ $? -ne 0 ]; then
      echo "Erreur lors de l'exécution de $sql_file"
      exit 1
    fi
  else
    echo "Aucun fichier SQL trouvé dans le répertoire."
  fi
done
