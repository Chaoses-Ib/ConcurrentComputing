#import "@local/ib:0.1.0": *
#title[Observability]
#a-badge[https://en.wikipedia.org/wiki/Observability_(software)]

= Implementations
- LGTM: Loki (Logs), Grafana (Visualization), Tempo (Traces), Mimir or Prometheus (Metrics)
  - #a[`grafana/docker-otel-lgtm`: An OpenTelemetry backend in a Docker container image][https://github.com/grafana/docker-otel-lgtm]

- ELK: Elasticsearch, Logstash, Kibana

- SigNoz

- OpenObserve

#q[Half these answers are pointing you at LGTM or kube-prometheus, which is exactly the multi-component, kubernetes-shaped thing you said you do not want.
For one VM, no k8s, logs+metrics+traces+alerting in one place, both of the tools you actually named fit better since they are ClickHouse-backed all-in-ones.
Between them, OpenObserve is lighter to stand up and cheaper on storage, SigNoz has the stronger tracing/APM side, so pick based on whether traces or log volume is your bigger pain.]
#footnote[#a[OpenObserver or Signoz? : r/devops][https://www.reddit.com/r/devops/comments/1ukirj0/openobserver_or_signoz/]]

#q[SigNoz is doing some cool stuff, but I feel like going with LGTM is the safer bet.
There's going to be invested time to set it up regardless of the solution you choose here, might as well go with the Grafana suite which has much better documentation + community.]
#footnote[#a[Open Source Monitoring tools : SigNoz Vs Grafana Vs The Elastic Stack : r/devops][https://www.reddit.com/r/devops/comments/1b0e745/open_source_monitoring_tools_signoz_vs_grafana_vs/]]

#q[I absolutely hate that basically all observability solutions beside grafana have sso behind a premium tax]
#footnote[#a[Open source observability - what is your take? : r/devops][https://www.reddit.com/r/devops/comments/1q2u17c/open_source_observability_what_is_your_take/]]

= Rust
- GreptimeDB
- OpenObserve
- #a[Parseable: An open source, unified infrastructure observability platform built in Rust on a data lake architecture. It tracks logs, metrics, traces, and events across apps, agents, and systems, reducing storage costs by up to 90% through columnar telemetry compression.][https://github.com/parseablehq/parseable]

#a[Are we observable yet? An introduction to Rust telemetry | Luca Palmieri][https://lpalmieri.com/posts/2020-09-27-zero-to-production-4-are-we-observable-yet/]

#a[Can any one suggest me resource to learn about observability in rust : r/rust][https://www.reddit.com/r/rust/comments/1kkim4t/can_any_one_suggest_me_resource_to_learn_about/]
