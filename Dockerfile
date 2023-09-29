FROM bitnami/clickhouse:22.3.20-debian-11-r16

USER root

RUN apt-get update && apt-get upgrade -y
RUN apt-get install curl wget -y

USER 1001

ENV ALLOW_EMPTY_PASSWORD=yes
ENV CLICKHOUSE_HTTP_PORT=8123
ENV CLICKHOUSE_TCP_PORT=9000
ENV CLICKHOUSE_ADMIN_USER='admin'
ENV CLICKHOUSE_ADMIN_PASSWORD=''

# read all *.SQL files and execute on ClickHouse
COPY ./001-init.sh /docker-entrypoint-initdb.d/001-init.sh

HEALTHCHECK --start-period=5s --interval=5s --retries=5 --timeout=2s \
    CMD wget --spider -q "localhost:$CLICKHOUSE_HTTP_PORT/ping" || exit 1
