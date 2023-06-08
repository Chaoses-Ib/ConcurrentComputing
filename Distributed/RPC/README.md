# Remote Procedure Calls
[Wikipedia](https://en.wikipedia.org/wiki/Remote_procedure_call)

A **remote procedure call (RPC)** is when a computer program causes a procedure (subroutine) to execute in a different address space (commonly on another computer on a shared network), which is written as if it were a normal (local) procedure call, without the programmer explicitly writing the details for the remote interaction.

RPCs are a form of inter-process communication (IPC), in that different processes have different address spaces.

## Protocols
- [gRPC](gRPC.md)

  [How Netflix increased developer productivity and defeated the thundering herd with gRPC](https://www.cncf.io/case-studies/netflix/)
- [Apache Thrift](https://thrift.apache.org/)
- [Cap'n Proto](https://capnproto.org/)
- [Apache Avro](https://avro.apache.org/)
- [zerorpc](https://www.zerorpc.io/)
- [rpclib](http://rpclib.net/)
- [JSON-RPC](https://www.jsonrpc.org/)
- [XML-RPC](http://xmlrpc.com/)
  - Simple Object Access Protocol
- RPC URI-Tunneling

Benchmarks:
- [RPC Benchmark](https://github.com/hank-whu/rpc-benchmark)
- [rpclib benchmarks](https://github.com/rpclib/benchmarks)
- [RPC benchmark (and Inverted Json) | by Oleg Nechaev | ITNEXT](https://itnext.io/rpc-benchmark-and-inverted-json-b5ce0bf587be)

[Leveling Up Reddit's Core - The Transition from Thrift to gRPC : RedditEng](https://www.reddit.com/r/RedditEng/comments/xivl8d/leveling_up_reddits_core_the_transition_from/)