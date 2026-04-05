#import "@local/ib:0.1.0": *
#title[Distributed Queues]
- Redis + ...
- #a[NATS.io -- Cloud Native, Open Source, High-performance Messaging][https://nats.io/]
  #a-badge[https://github.com/nats-io?q&type=all&language&sort=stargazers]
  - Persist: #a[JetStream][https://docs.nats.io/nats-concepts/jetstream]
    - KV DB
    - Object storage

#a[Why isn't there a simple and efficient distributed task queue crate available in Rust? : r/rust][https://www.reddit.com/r/rust/comments/1g7z0oe/why_isnt_there_a_simple_and_efficient_distributed/]

= Rust
- #a[apalis: Type-safe, extensible, and high-performance background processing library for Rust][https://github.com/apalis-dev/apalis]

= Clients
Python:
- #a[taskiq: Distributed task queue with full async support][https://github.com/taskiq-python/taskiq]
