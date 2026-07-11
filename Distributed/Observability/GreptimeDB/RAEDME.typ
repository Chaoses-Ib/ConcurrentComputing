#import "@local/ib:0.1.0": *
#title[#a[GreptimeDB][https://greptime.com/]]
#a-badge[https://github.com/GreptimeTeam/greptimedb]

- Apache Arrow, Parquet, DataFusion, OpenDAL
- Query: SQL, PromQL
- #a[Pipelines][https://docs.greptime.com/reference/pipeline/built-in-pipelines/]:
  YAML
- HTTP: Axum, gRPC: Tonic
- `sea-query` in tests.
- License: Apache-2.0
- Chinese

#a[Engage Prometheus in the Rust Ecosystem: A PromCon 2025 Talk Recap | Greptime][https://greptime.com/blogs/2026-01-14-promcon-engage-prometheus-in-rust]

#a[Beyond ELK: Lightweight and Scalable Cloud-Native Log Monitoring | Greptime][https://greptime.com/blogs/2025-04-24-elasticsearch-greptimedb-comparison-performance]
#a-badge[https://news.ycombinator.com/item?id=43825798]

#a[重新思考 GreptimeDB 的数据分区机制 | Wonderland][https://blog.waynest.com/2026/06/rethink-greptimedb-partition/]

#q[
GreptimeDB 做可观测性感觉挺不错的，之前只知道用 Prometheus, ELK 这些传统工具，GreptimeDB 可以用 MySQL 客户端连接、自带一个好用的 dashboard、以及单个可执行文件部署这些点我都很喜欢。

https://gemini.google.com/share/a0b6445008da
]

#q[
Someone mentioned OpenObserve here which looks impressive, although I didn’t try yet. What I tried is Greptime and it is good too. Performance wise is slightly better than ClickHouse, metrics, logs, traces. Eventually we replaced our golang based stack with it.
]
#footnote[#a[Best Observabilty platform : r/Observability][https://www.reddit.com/r/Observability/comments/1plqnec/best_observabilty_platform/]]

= Installation
- #a[GreptimeDB Standalone][https://docs.greptime.com/getting-started/installation/greptimedb-standalone/]

- Listens on `127.0.0.1:4000`/HTTP, `4001`/gRPC, `4002`/MySQL, `4003`/PostgresSQL by default.

- #a[Authentication][https://docs.greptime.com/user-guide/deployments-administration/authentication/overview/]

= Data ingestion 
- #a[OpenTelemetry Protocol (OTLP)][https://docs.greptime.com/user-guide/ingest-data/for-observability/opentelemetry/]
  - Metrics
    - The name of the Metric will be used as the name of the GreptimeDB table, and the table will be automatically created if it does not exist.
    - Only selected resource attributes are kept by default.
  - Logs
    - All attributes, including resource attributes, scope attributes, and log attributes, will be stored as a JSON column in the GreptimeDB table.
  - #a[OTel Collector][https://docs.greptime.com/user-guide/ingest-data/for-observability/otel-collector/]

- #a[Pipelines][https://docs.greptime.com/reference/pipeline/built-in-pipelines/]

- Importing log must create pipeline first, whether it's plain text or NDJSON.

= #a[Protocols][https://docs.greptime.com/user-guide/protocols/overview/]
- Postgres

  #a[How We Built Postgres Compatibility in Rust: pgwire and DataFusion | Greptime][https://greptime.com/blogs/2026-04-01-greptimedb-postgresql-compatibility]

= Integrations
- #a[Grafana][https://docs.greptime.com/user-guide/integrations/grafana/]

= Web UI
- Vue
- #a[Dashboard][https://github.com/GreptimeTeam/dashboard]
  - Perses dashboards
