FROM postgres:17.3

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  postgresql-postgis

ADD https://github.com/VADOSWARE/pg_idkit/releases/download/v0.2.4/pg_idkit-0.2.4-pg17-gnu.tar.gz ./
RUN set -eux; \
  tar xf pg_idkit-0.2.4-pg17-gnu.tar.gz; \
  mv pg_idkit-0.2.4/lib/postgresql/* /usr/lib/postgresql/17/lib; \
  mv pg_idkit-0.2.4/share/postgresql/extension/* /usr/share/postgresql/17/extension;

RUN sed -i "s/#shared_preload_libraries = ''/shared_preload_libraries = '\/usr\/lib\/postgresql\/17\/lib\/pg_idkit.so'/" /usr/share/postgresql/postgresql.conf.sample
