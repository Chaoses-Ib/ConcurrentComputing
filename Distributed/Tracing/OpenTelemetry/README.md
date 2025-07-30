# [OpenTelemetry](https://opentelemetry.io/)
> OpenTelemetry is a CNCF open source project that provides comprehensive support for distributed tracing.

[What is OpenTelemetry? | OpenTelemetry](https://opentelemetry.io/docs/what-is-opentelemetry/)

[Who uses Open Telemetry? Besides price point, what are some pros/cons over DataDog? : r/devops](https://www.reddit.com/r/devops/comments/1ap9yl4/who_uses_open_telemetry_besides_price_point_what/)
> OpenTelemetry is a framework - it is not an observability product. So it is not a case of choosing one or the other. OpenTelemetry is for your instrumentation and pipelines, Datadog is a backend and observability stack. If you instrument your code with oTel you can choose to send your telemetry to any backend that supports it - which could be Datadog or a provider such as Grafana, sigNoz, Honeycomb, the Elk Stack etc

[OpenTelemetry UI - See What's Possible With OpenTelemetry data | SigNoz](https://signoz.io/blog/opentelemetry-ui/)

[Observability pipelines love the OTel Collector--- until the config hits the fan](https://www.sawmills.ai/blog/observability-pipelines-love-the-otel-collector-until-the-config-hits-the-fan)

[I got OpenTelemetry to work. But why was it so complicated? | Hacker News](https://news.ycombinator.com/item?id=42655102)
> The whole time I was learning/porting to Otel I felt like I was back in the Java world again. Every time I stepped through the code it felt like EnterpriseFizzBuzz. No discoverability. At all. And their own jargon that looks like it was made by people high on something.
>
> Just go with Prometheus. It’s not like there are other contenders out there.

> Prometheus is just metrics. The main argument for oTel is that instead of one proprietary vendor SDK or importing prometheus and jaeger and whatever you want to use for logging, just import oTel and all that will be done with a common / open data format. I still believe in that dream but it's clear that the whole project needs some time/resources to mature a bit more.

## OpenTelemetry Protocol (OTLP)
Not to be confused with OLTP.

- Transport
  - gRPC
  - HTTP (Protobuf/JSON)
    - `/v1/traces`
    - `/v1/metrics`
    - `/v1/logs`
    - `/v1development/profiles`
- Push model for traces and logs
  - Metrics can support both push and pull models
- [open-telemetry/opentelemetry-proto: OpenTelemetry protocol (OTLP) specification and Protobuf definitions](https://github.com/open-telemetry/opentelemetry-proto)
  - [logs](https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/logs/v1/logs.proto)
    ```proto
    message LogRecord {
      reserved 4;

      fixed64 time_unix_nano = 1;
      fixed64 observed_time_unix_nano = 11;

      SeverityNumber severity_number = 2;
      string severity_text = 3;

      opentelemetry.proto.common.v1.AnyValue body = 5;

      repeated opentelemetry.proto.common.v1.KeyValue attributes = 6;
      uint32 dropped_attributes_count = 7;

      fixed32 flags = 8;

      bytes trace_id = 9;

      bytes span_id = 10;

      string event_name = 12;
    }
    ```
    One log with 11 fields, well...

    - [logs_service](https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/collector/logs/v1/logs_service.proto)

## [Rust](https://opentelemetry.io/docs/languages/rust/)
- [opentelemetry\_otlp](https://docs.rs/opentelemetry-otlp/latest/opentelemetry_otlp/)
  - [opentelemetry\_http](https://docs.rs/opentelemetry-http/latest/opentelemetry_http/)
  - > For optimal performance, a batch exporting processor is recommended as the simple processor will export each span synchronously on dropping, and is only good for test/debug purposes.

- [tokio-rs/tracing-opentelemetry](https://github.com/tokio-rs/tracing-opentelemetry)

## Backends
- [Grafana Tempo: a high volume, minimal dependency distributed tracing backend.](https://github.com/grafana/tempo)
- [grafana/docker-otel-lgtm: OpenTelemetry backend in a Docker image](https://github.com/grafana/docker-otel-lgtm)
- SigNoz

  [OpenTelemetry UI - See What's Possible With OpenTelemetry data | SigNoz](https://signoz.io/blog/opentelemetry-ui/)

## [Jaeger](https://www.jaegertracing.io/)
[OpenTelemetry | Jaeger](https://www.jaegertracing.io/docs/1.21/deployment/opentelemetry/)
> The future Jaeger backend components will be based on [OpenTelemetry collector](https://opentelemetry.io/docs/collector/) . This integration will make all OpenTelemetry Collector features available in the Jaeger backend components.

[Migrating away from the Jaeger exporter in the Collector | OpenTelemetry](https://opentelemetry.io/blog/2023/jaeger-exporter-collector-migration/)

v1: [Architecture | Jaeger](https://www.jaegertracing.io/docs/1.44/architecture/)

v2: [Architecture | Jaeger](https://www.jaegertracing.io/docs/2.8/architecture/)
