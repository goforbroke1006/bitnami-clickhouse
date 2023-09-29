# bitnami-clickhouse

Patched version of popular image:

* Add healthcheck
* Add ability to apply *.sql files on container starting

```yaml
  my_data_mart:
    network_mode: host
    image: goforbroke1006/bitnami-clickhouse:22.3.20-debian-11-r16
    environment:
      ALLOW_EMPTY_PASSWORD: yes
      CLICKHOUSE_HTTP_PORT: 19123
      CLICKHOUSE_TCP_PORT: 19100
      CLICKHOUSE_ADMIN_USER: afc_ro
      CLICKHOUSE_ADMIN_PASSWORD: ""
    volumes:
      - ./.docker-compose/my_data_mart/migrations/001-schema.sql:/docker-entrypoint-initdb.d/001-schema.sql
      - ./.docker-compose/my_data_mart/migrations/002-fixture.sql:/docker-entrypoint-initdb.d/002-fixture.sql
    depends_on:
      zookeeper: { condition: service_healthy }

  zookeeper:
    network_mode: host
    image: confluentinc/cp-zookeeper:latest
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000
    healthcheck: { test: "nc -z localhost 2181", start_period: 5s, interval: 10s, retries: 3, timeout: 5s }
```
