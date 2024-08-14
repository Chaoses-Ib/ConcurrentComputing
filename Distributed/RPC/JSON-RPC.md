# [JSON-RPC](https://www.jsonrpc.org/)
[Wikipedia](https://en.wikipedia.org/wiki/JSON-RPC)

- batch 会影响 rate limit，需要适配或者拦截 batch。

## Implementations
### C++
- [Glaze: Extremely fast, in memory, JSON and interface library for modern C++](https://github.com/stephenberry/glaze/blob/main/docs/rpc/json-rpc.md) (C++20)

### Rust
- serde-json
  ```rust
  /// A rpc call is represented by sending a Request object to a Server.
  #[derive(Deserialize)]
  struct Request {
      /// A String specifying the version of the JSON-RPC protocol. MUST be exactly "2.0".
      jsonrpc: String,
      /// A String containing the name of the method to be invoked. Method names that begin with the word rpc followed by a period character (U+002E or ASCII 46) are reserved for rpc-internal methods and extensions and MUST NOT be used for anything else.
      method: String,
      /// A Structured value that holds the parameter values to be used during the invocation of the method. This member MAY be omitted.
      params: serde_json::Value,
      /// An identifier established by the Client that MUST contain a String, Number, or NULL value if included. If it is not included it is assumed to be a notification. The value SHOULD normally not be Null and Numbers SHOULD NOT contain fractional parts.
      id: serde_json::Value,
  }
  ```
- [jsonrpc: Rust JSON-RPC implementation](https://github.com/paritytech/jsonrpc) (discontinued)
  - [jsonrpsee: Rust JSON-RPC library on top of async/await](https://github.com/paritytech/jsonrpsee)
- [rust-jsonrpc: Rust JSONRPC library](https://github.com/apoelstra/rust-jsonrpc/)
- [yerpc: An ergonomic JSON-RPC server library in Rust with autocreated TypeScript client and OpenRPC specification](https://github.com/deltachat/yerpc)
- [axum-jrpc: Json RPC extractor for axum](https://github.com/0xdeafbeef/axum-jrpc)
  - No batch support
- [json-rpc-types: Type definitions for JSON-RPC](https://github.com/DoumanAsh/json-rpc-types)
- [prople/jsonrpc: A core abstraction and implementation of JSON-RPC in Rust](https://github.com/prople/jsonrpc)
- [rust-rpc-router: JSON-RPC Routing support library](https://github.com/jeremychone/rust-rpc-router)
- [elite-rpc: Type Safe JSON RPC like client with different transport and protocol layers.](https://github.com/vincenzopalazzo/elite-rpc)

  [Introducing elite-rpc: A Type-Safe JSON RPC Client Library for Rust : r/rust](https://www.reddit.com/r/rust/comments/1dje06u/introducing_eliterpc_a_typesafe_json_rpc_client/)

- [bcndanos/json\_rpc: JSON-RPC 2.0 Implementation in Rust](https://github.com/bcndanos/json_rpc) (discontinued)
- [hlb8122/async-json-rpc](https://github.com/hlb8122/async-json-rpc) (discontinued)
- [rustdt-json\_rpc: A JSON-RPC library for Rust](https://github.com/RustDT/rustdt-json_rpc) (discontinued)