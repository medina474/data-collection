#!/bin/bash

set -a
source .env
set +a

podman stop PostgreSQL
podman container rm PostgreSQL
podman volume prune -f

podman run --detach --pod Jardins --name PostgreSQL -e POSTGRES_PASSWORD=$PGPASSWORD -v ./postgresql/docker-entrypoint-initdb.d/:/docker-entrypoint-initdb.d/:z medina5/postgres:2025-05
