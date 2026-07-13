#import "@local/ib:0.1.0": *
#title[PromQL]
#a[Querying basics | Prometheus][https://prometheus.io/docs/prometheus/latest/querying/basics/]

#a[PromLabs | PromQL Cheat Sheet][https://promlabs.com/promql-cheat-sheet/]

#a[Introduction to PromQL, the Prometheus query language | Grafana Labs][https://grafana.com/blog/introduction-to-promql-the-prometheus-query-language/]

= Types
- Scalar (```c float```)
  - Time duration (seconds)
- Instant vector (```c float[]```)
- Range vector (```c float[][]```)
- String

= #a[Time series selectors][https://prometheus.io/docs/prometheus/latest/querying/basics/#time-series-selectors]
- Instant vector selectors: `=`, `!=`
  - Regex (fully anchored RE2): `=~`, `!~`.
- Range vector selectors: `[duration]`

Comparison operators can be used to filter by values.
#footnote[#a[grafana - Filter prometheus results by metric value, not by label value - Stack Overflow][https://stackoverflow.com/questions/46697754/filter-prometheus-results-by-metric-value-not-by-label-value]]

= #a[Operators][https://prometheus.io/docs/prometheus/latest/querying/operators/]
- Arithmetic: `+`, `-`, `*`, `^`, `/`, `%`
- Comparison: `==`, `!=`, `>`, `<`, `>=`, `<=`
- Logical/Set: `and`, `or`, `unless`

= #a[Functions][https://prometheus.io/docs/prometheus/latest/querying/functions/]
- ```promql sort_by_label(v instant-vector, label string, ...)```
  #footnote[#a[Added `sort_by_label` function for sorting by label values. by pstibrany - Pull Request \#1533 - prometheus/prometheus][https://github.com/prometheus/prometheus/pull/1533]]
  #footnote[#a[sorting - How can I sort the legend by series name in Prometheus/Grafana - Stack Overflow][https://stackoverflow.com/questions/64395442/how-can-i-sort-the-legend-by-series-name-in-prometheus-grafana]]
  #footnote[#a[[PromQL] Support `sort_by_label` and `sort_by_label_desc` - Issue \#85570 - grafana/grafana][https://github.com/grafana/grafana/issues/85570]]

= Libraries
- #a[GreptimeTeam/`promql-parser`: PromQL Rust parser][https://github.com/GreptimeTeam/promql-parser]
