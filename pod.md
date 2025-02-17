podman build -f postgresql/Dockerfile --tag medina5/postgres:2025-02

podman run --detach --name PostgreSQL -p 5432:5432 -e POSTGRES_PASSWORD=1234 -v ./jardins/migrations/:/docker-entrypoint-initdb.d/:z medina5/postgres:2025-02

podman container rm PostgreSQL


#This will remove all volumes not used by at least one container
podman volume prune -f

podman logs PostgreSQL


podman run --detach --name PostgREST -p 3000:3000 -e PGRST_DB_URI="postgres://postgrest:motdepasse@localhost/jardins" -e PGRST_DB_SCHEMAS=public -e PGRST_DB_ANON_ROLE=role_web postgrest/postgrest:v12.2.8