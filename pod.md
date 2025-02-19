```shell
podman pod create --name Jardins -p 3000:3000 -p 3001:3001 -p 27017:27017 -p 5432:5432
```

podman container rm PostgreSQL


#This will remove all volumes not used by at least one container
podman volume prune -f

podman logs PostgreSQL

### PostgreSQL

```shell
podman build -f postgresql/Dockerfile --tag medina5/postgres:2025-04
```

```shell
podman run --detach --pod Jardins --name PostgreSQL -e POSTGRES_PASSWORD=1234 -v ./migrations/cinema/:/docker-entrypoint-initdb.d/:z -v ./backup/:/backup/:z medina5/postgres:2025-04
```

### PostgREST

```shell
podman run --detach --pod Jardins --name PostgREST -e PGRST_DB_URI="postgres://postgrest:motdepasse@localhost/jardins" -e PGRST_DB_SCHEMAS=public -e PGRST_DB_ANON_ROLE=role_web postgrest/postgrest:v12.2.8
```

### PostGraphile

```shell
podman run --detach --pod Jardins --name PostGraphile -e PGHOST=localhost -e PGPORT=5432 -e PGUSER=postgrest -e PGPASSWORD=motdepasse -e PGDATABASE=jardins medina5/postgraphile:2025-04 --port 3001 --schema public --enhance-graphiql --cors --allow-explain --dynamic-json --append-plugins postgraphile-plugin-connection-filter,postgraphile-plugin-fulltext-filter,@graphile/postgis,postgraphile-plugin-connection-filter-postgis
```

### FerretDB

```shell
podman pull ghcr.io/ferretdb/ferretdb:2
```

```shell
podman run --detach --pod Jardins --name FerretDB -e FERRETDB_POSTGRESQL_URL=postgres://username:password@postgres:5432/postgres ferretdb:2
```
