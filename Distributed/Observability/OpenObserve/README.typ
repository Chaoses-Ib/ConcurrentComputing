#import "@local/ib:0.1.0": *
#title[#a[OpenObserve (O2)][https://openobserve.ai]]
#a-badge[https://github.com/openobserve/openobserve]

#q[🚀 10x easier, 🚀 140x lower storage cost, 🚀 high performance, 🚀 petabyte scale - Elasticsearch/Splunk/Datadog alternative for 🚀 (logs, metrics, traces, RUM, Error tracking, Session replay).]

- Apache Arrow, Parquet, DataFusion; Tantivy
- Query: SQL, PromQL
- Pipelines: Vector Remap Language (VRL)
- Logs, traces, metrics
  - Pipelines
- #a[Frontend monitoring (RUM)][https://openobserve.ai/docs/features/frontend/]
- Alerts
  - Email, Slack, Teams, Discord...
- SeaORM
- HTTP: Axum, gRPC: Tonic
- `rquickjs`
  #footnote[#a[feat: add js for claim parser by oasisk - Pull Request \#9873 - openobserve/openobserve][https://github.com/openobserve/openobserve/pull/9873]]
- License: AGPL-3.0
- Chinese, India, AI

Formerly named ZincObserve.

#q[I've been happy with OpenObserve for personal use.
It's a minimal deployment, so I'm not sure how well it scales, but I really like that it's self-contained, easy to deploy and manage.
Not having to think about integrating a half-dozen different tools is great.
I just setup `otel-collector` on each node, and point them to the OpenObserve host.
Easy.

I've been doing monitoring since before it was called observability with good old Nagios, and the modern observability stack is insane.
I'm glad that tools like OpenObserve and SigNoz exist.]
#footnote[#a[I can't recommend Grafana anymore | Hacker News][https://news.ycombinator.com/item?id=45934940]]

#q[
Yes I run it at a pretty good scale. I've also run the grafana stack

Openobserve is a lot easier to scale. They have a whole doc page on how to scale it. The read is also a lot cheaper then Loki is for needle in the haystack searches.

The other benefit is the members of the team are extremely active on their slack to answer questions. Grafana you are lucky to get a response.

How they allow you to use VRL to modify logs on ingestion is great.

Their UI is bad in my opinion. They tried to mirror kibana but it's hard to use at first. You can front a lot of it with grafana, I havent really dove into most of it though.
- visually its just all over the place and your eyes dont go right to where you'd need to search. Its just very busy
]
#q[#a[Did anyone try openobserve? : r/devops][https://www.reddit.com/r/devops/comments/1lez029/did_anyone_try_openobserve/]]

#q[
RBAC, SSO, fine-grained access — all locked behind “Enterprise.”
The OSS version is fine for demos, but useless for real production use.
If I can’t run it securely in production, what’s even the point of calling it open source?
]
#footnote[#a[So OpenObserve is 'open-source'... until you actually try using it : r/opensource][https://www.reddit.com/r/opensource/comments/1ohmsso/so_openobserve_is_opensource_until_you_actually/]]
#footnote[#a[OpenObserve? Is it good? : r/selfhosted][https://www.reddit.com/r/selfhosted/comments/1f3vyw6/openobserve_is_it_good/]]

= #a[Installation][https://openobserve.ai/docs/getting-started/]
- Download
  - https://raw.githubusercontent.com/openobserve/openobserve/main/downloadO2.sh
  - #a[More clarity on hardware requirements - openobserve/openobserve - Discussion \#7954][https://github.com/openobserve/openobserve/discussions/7954]

- Authentication
  - `ZO_ROOT_USER_PASSWORD is too weak: Password must be 8-128 characters and contain at least one lowercase letter, one uppercase letter, one digit, and one special character.`
  - OAuth 2.0: #a[Old-Camel/openobserve][https://github.com/Old-Camel/openobserve]
  - OIDC: #a[ExposedObserve][https://github.com/ExposedObserve/ExposedObserve]

- Listens on `0.0.0.0:5080`/HTTP and `0.0.0.0:5081`/gRPC by default.

= Data ingestion
- Data retention
  - 3650 days by default.

- Pipelines

  #a[Filter logs at source in otel collector][https://openobserve.ai/blog/filter-logs-at-source-in-otel-collector/]

- #a[Linux server][https://openobserve.ai/docs/integration/system/linux/]:
  ```sh https://raw.githubusercontent.com/openobserve/agents/main/linux/install.sh http://127.0.0.1:5080/api/default/ AUTH_KEY```

= Query
- #a[SQL][https://openobserve.ai/docs/reference/sql-reference/],
  PromQL
- All queries will be cached to disk.
- API: #a[`/api/{organization}/_search`][https://openobserve.ai/docs/reference/api/search/search/]

= Web UI
- Vue

- Logs
  - Custom fields/columns

  #a[Log Searching and Filtering][https://openobserve.ai/blog/log-searching-and-filtering/]

- Tracing

  #a[Distributed Tracing - OpenObserve Documentation][https://openobserve.ai/docs/features/distributed-tracing/]

- Dashboards

#a[Filter logs at source in otel collector][https://openobserve.ai/blog/filter-logs-at-source-in-otel-collector/]

= CLI
#footnote[#a[Code search results: `"start_time" "scan_size" "hits" "query"`][https://github.com/search?q=%22start_time%22%20%22scan_size%22%20%22hits%22%20%22query%22&ref=opensearch&type=code&p=1]]

- #a[`openobserve/src/cli`][https://github.com/openobserve/openobserve/tree/main/src/cli]
