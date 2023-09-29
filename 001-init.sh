#!/usr/bin/env sh

set -e

find /docker-entrypoint-initdb.d/ -iregex '.*\.\(sql\)' \
  -exec clickhouse-client --host localhost --port "${CLICKHOUSE_TCP_PORT}" \
  --user "${CLICKHOUSE_ADMIN_USER}" --password "${CLICKHOUSE_ADMIN_PASSWORD}" \
  --queries-file {} \;
