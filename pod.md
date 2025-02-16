podman build -f postgresql/Dockerfile --tag medina5/postgres:2025-02

podman run --detach --name PostgreSQL -p 5432:5432 -e POSTGRES_PASSWORD=1234 -v ./jardins/migrations/:/docker-entrypoint-initdb.d/:z medina5/postgres:2025-02

podman container rm PostgreSQL


#This will remove all volumes not used by at least one container
podman volume prune -f

podman logs PostgreSQL