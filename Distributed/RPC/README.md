# Remote Procedure Calls
[Wikipedia](https://en.wikipedia.org/wiki/Remote_procedure_call)

A **remote procedure call (RPC)** is when a computer program causes a procedure (subroutine) to execute in a different address space (commonly on another computer on a shared network), which is written as if it were a normal (local) procedure call, without the programmer explicitly writing the details for the remote interaction.

RPCs are a form of inter-process communication (IPC), in that different processes have different address spaces.

## Protocols
- [gRPC](gRPC.md)

  [How Netflix increased developer productivity and defeated the thundering herd with gRPC](https://www.cncf.io/case-studies/netflix/)
- [Connect](Connect.md)
- [Apache Thrift](https://thrift.apache.org/)
- [Cap'n Proto](https://capnproto.org/)
- [Apache Avro](https://avro.apache.org/)
- [zerorpc](https://www.zerorpc.io/)
- [rpclib](http://rpclib.net/)
- [JSON-RPC](JSON-RPC.md)
- [XML-RPC](http://xmlrpc.com/)
  - Simple Object Access Protocol
- RPC URI-Tunneling

Rust:
- [tarpc: An RPC framework for Rust with a focus on ease of use.](https://github.com/google/tarpc)
  - [examples/custom\_transport.rs](https://github.com/google/tarpc/blob/master/tarpc/examples/custom_transport.rs)
- [Volo: Rust RPC framework with high-performance and strong-extensibility for building micro-services.](https://github.com/cloudwego/volo) (China)
- [ESSRPC: Electron's Super Simple RPC](https://github.com/Electron100/essrpc)

Benchmarks:
- [RPC Benchmark](https://github.com/hank-whu/rpc-benchmark)
- [rpclib benchmarks](https://github.com/rpclib/benchmarks)
- [RPC benchmark (and Inverted Json) | by Oleg Nechaev | ITNEXT](https://itnext.io/rpc-benchmark-and-inverted-json-b5ce0bf587be)
- [Scaling up REST versus gRPC Benchmark Tests | by Ian Gorton | Medium](https://medium.com/@i.gorton/scaling-up-rest-versus-grpc-benchmark-tests-551f73ed88d4)
- [gRPC vs REST speed comparison](https://blog.shiftasia.com/grpc-vs-rest-speed-comparation/)
- 2023-09 [Like for Like HTTP vs gRPC Comparison : r/rust](https://www.reddit.com/r/rust/comments/169t5ce/like_for_like_http_vs_grpc_comparison/)
  - JSON vs Protobuf
  - > Where gRPC shines is long-running batches/streams of requests. With either API, you're likely to have keep-alives and streaming to avoid network-level overhead, but gRPC generally makes it relatively efficient and straightforward to do stream processing with back-pressure and optional separation of the request stream from the response stream.

[Leveling Up Reddit's Core - The Transition from Thrift to gRPC : RedditEng](https://www.reddit.com/r/RedditEng/comments/xivl8d/leveling_up_reddits_core_the_transition_from/)

[Which Rust RPC frameworks are the easiest to use? : r/rust](https://www.reddit.com/r/rust/comments/jcjngo/which_rust_rpc_frameworks_are_the_easiest_to_use/)