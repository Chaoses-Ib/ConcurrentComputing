# [gRPC](https://grpc.io/)
[GitHub](https://github.com/grpc/grpc)

Supported channels:
- HTTP/2
- HTTP: [gRPC-Web](https://chromium.googlesource.com/external/github.com/grpc/grpc/+/v1.12.0/doc/PROTOCOL-WEB.md)
- Unix domain sockets

  [Using gRPC for (local) inter-process communication | F. Werner’s Research Page](https://www.mpi-hd.mpg.de/personalhomes/fwerner/research/2021/09/grpc-for-ipc/)
- Named pipes: [I could use a Windows named pipe transport. · Issue #13447 · grpc/grpc](https://github.com/grpc/grpc/issues/13447)
- Shared memory: [Is there a way to use shared memory instead of socket on a local machine for rpc? · Issue #19959 · grpc/grpc](https://github.com/grpc/grpc/issues/19959)

[Awesome gRPC: A curated list of useful resources for gRPC](https://github.com/grpc-ecosystem/awesome-grpc)

[Showcase | gRPC](https://grpc.io/showcase/)

## Sessions
gRPC is stateless. gRPC services are transient.
- [Does gRPC support client-server sessions? · Issue #946 · grpc/grpc-dotnet](https://github.com/grpc/grpc-dotnet/issues/946)

## Bidirectional streaming
gRPC 只支持单向调用，不过 bidirectional streaming 可以作为双向调用的一种间接实现，例如：

```proto
service FullDuplex {
    rpc WaitRequests(stream ClientResponse) returns (stream ServerRequest);
}
```

gRPC-Web 目前尚不支持 bidirectional streaming。


## Implementations
[Various gRPC benchmarks](https://github.com/LesnyRumcajs/grpc_bench)

### .NET
- [gRPC for .NET](https://github.com/grpc/grpc-dotnet) ([Grpc.Net.Client](https://www.nuget.org/packages/Grpc.Net.Client))

  [Use gRPC client with .NET Standard 2.0 | Microsoft Learn](https://learn.microsoft.com/en-us/aspnet/core/grpc/netstandard)

  Known issues:
  - [WPF projects unable to generate gRPC C# assets from `.proto` files](https://learn.microsoft.com/en-us/aspnet/core/grpc/troubleshoot?view=aspnetcore-7.0#wpf-projects-unable-to-generate-grpc-c-assets-from-proto-files)

- [gRPC C#](https://github.com/grpc/grpc/tree/master/src/csharp) ([Grpc.Core](https://www.nuget.org/packages/Grpc.Core)) (discontinued)

### Rust
- [tonic: A native gRPC client & server implementation with async/await support.](https://github.com/hyperium/tonic)
  - [tonic-web: grpc-web protocol translation for tonic services.](https://docs.rs/crate/tonic-web/latest)
- [grpc-rs: The gRPC library for Rust built on C Core library and futures](https://github.com/tikv/grpc-rs)
- [grpc-rust: Rust implementation of gRPC](https://github.com/stepancheg/grpc-rust)

## Tools
GUI:
- [Postman](https://www.postman.com/)
- [gRPC UI: An interactive web UI for gRPC, along the lines of postman](https://github.com/fullstorydev/grpcui)
- [gRPCox: Like Postman, but for gRPC](https://github.com/gusaul/grpcox)
- [BllomRPC](https://github.com/bloomrpc/bloomrpc) (discontinued)

CLI:
- [gRPCurl: Like cURL, but for gRPC](https://github.com/fullstorydev/grpcurl)