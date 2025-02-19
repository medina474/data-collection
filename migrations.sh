#!/bin/bash

# Vérifie si le répertoire existe
if [ ! -d "$1" ]; then
  echo "Le répertoire $1 n'existe pas."
  exit 1
fi

cd $1
ls
# Exécutez chaque fichier SQL dans le répertoire
for sql_file in ./*.sql;
do
  if [ -f "$sql_file" ]; then
    echo "Exécution de $sql_file..."
    psql -h $2 -p $3 -U $4 -d $5 -f "$sql_file"
    if [ $? -ne 0 ]; then
      echo "Erreur lors de l'exécution de $sql_file"
      exit 1
    fi
  else
    echo "Aucun fichier SQL trouvé dans le répertoire $1."
  fi
done
