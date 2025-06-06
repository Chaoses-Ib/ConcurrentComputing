# [gRPC](https://grpc.io/)
[GitHub](https://github.com/grpc/grpc)

[Core concepts, architecture and lifecycle | gRPC](https://grpc.io/docs/what-is-grpc/core-concepts/)

Supported channels:
- HTTP/2
- HTTP: [gRPC-Web](https://chromium.googlesource.com/external/github.com/grpc/grpc/+/v1.12.0/doc/PROTOCOL-WEB.md)
- Unix domain sockets

  [Using gRPC for (local) inter-process communication | F. Werner’s Research Page](https://www.mpi-hd.mpg.de/personalhomes/fwerner/research/2021/09/grpc-for-ipc/)
- Named pipes: [I could use a Windows named pipe transport. · Issue #13447 · grpc/grpc](https://github.com/grpc/grpc/issues/13447)
- Shared memory: [Is there a way to use shared memory instead of socket on a local machine for rpc? · Issue #19959 · grpc/grpc](https://github.com/grpc/grpc/issues/19959)

[Awesome gRPC: A curated list of useful resources for gRPC](https://github.com/grpc-ecosystem/awesome-grpc)

[Showcase | gRPC](https://grpc.io/showcase/)

## Channels
[Custom Name Resolution | gRPC](https://grpc.io/docs/guides/custom-name-resolution/)

## Ordering
> gRPC guarantees message ordering within an individual RPC call.

[How does grpc guarantee the request (and response) order?](https://groups.google.com/g/grpc-io/c/AsfrHhsMZJA)
- > As far as I understand, we give no guarantees about the order in which messages will be delivered for separate calls, even on the same channel. Even if it did, the calls could be handled by different threads on the server, which could arbitrarily interleave and execute their handling code in any order.
- > If you need ordering you could use a grpc stream, which guarantees in order delivery of each message sent on the stream.

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

虽然用这种方法实现反向调用有些 hacky，但这样做也有一个好处：方便追踪调用链。

gRPC-Web 目前尚不支持 bidirectional streaming。

[protocol buffers - Protobuf RPC callbacks - Stack Overflow](https://stackoverflow.com/questions/35648518/protobuf-rpc-callbacks)

## [Reflection](https://grpc.io/docs/guides/reflection/)

## [Auth](https://grpc.io/docs/guides/auth/)
- Metadata
  - `authorization`

  Rust: [tonic/examples/src/authentication/server.rs at master - hyperium/tonic](https://github.com/hyperium/tonic/blob/master/examples/src/authentication/server.rs)
  ```rust
  #[derive(Clone)]
  pub struct AuthInterceptor {
      pub auth: Option<Arc<tonic::metadata::MetadataValue<tonic::metadata::Ascii>>>,
  }

  impl AuthInterceptor {
      pub fn new(auth: Option<&str>) -> Self {
          Self {
              auth: auth.map(|auth| auth.parse().unwrap()).map(Arc::new),
          }
      }
  }

  impl tonic::service::Interceptor for AuthInterceptor {
      fn call(&mut self, mut req: tonic::Request<()>) -> tonic::Result<tonic::Request<()>> {
          if let Some(auth) = &self.auth {
              req.metadata_mut()
                  .insert("authorization", auth.as_ref().clone());
          }
          Ok(req)
      }
  }

  client: MyServiceClient<
      tonic::service::interceptor::InterceptedService<
          tonic::transport::channel::Channel,
          AuthInterceptor,
      >,
  >,
  ```

## Implementations
[Supported languages | gRPC](https://grpc.io/docs/languages/)
- C++
- Rust (unofficial)
- Go
- .NET
- JVM
  - Java
  - Kotlin
- Python
- Ruby
- Web
  - JavaScript (gRPC-Web)
  - Node.js
- PHP
- Objective-C
- Dart

[Various gRPC benchmarks](https://github.com/LesnyRumcajs/grpc_bench)

### .NET
- [gRPC for .NET](https://github.com/grpc/grpc-dotnet) ([Grpc.Net.Client](https://www.nuget.org/packages/Grpc.Net.Client))

  [Use gRPC client with .NET Standard 2.0 | Microsoft Learn](https://learn.microsoft.com/en-us/aspnet/core/grpc/netstandard)
  - .NET Framework: HTTP/2 support is only available on Windows 11+ and must be over TLS.

    [Grpc.Net.Client does not support HTTP/2 on Windows 10 with NET Framework (There is no replacement for Grpc.Core.) - Issue #8094 - dotnet/core](https://github.com/dotnet/core/issues/8094)

  Running a server requires ASP.NET Core Runtime:
  - [Implementing a grpc server in .net standard class library · Issue #1419 · grpc/grpc-dotnet](https://github.com/grpc/grpc-dotnet/issues/1419)
  - [Replacement of Server functionality for .NET Framework (4.8) · Issue #1368 · grpc/grpc-dotnet](https://github.com/grpc/grpc-dotnet/issues/1368)
  - [Support for MAUI runtimes in ASP.NET Core? · Issue #35077 · dotnet/aspnetcore](https://github.com/dotnet/aspnetcore/issues/35077)

- [gRPC C#](https://github.com/grpc/grpc/tree/master/src/csharp) ([Grpc.Core](https://www.nuget.org/packages/Grpc.Core)) (discontinued)

  [Please continue to support grpc.core because there is no alternative for Windows 10 using the NET Framework - Issue #32719 - grpc/grpc](https://github.com/grpc/grpc/issues/32719)

  尽管 [Grpc.Core.Xamarin](https://www.nuget.org/packages/Grpc.Core.Xamarin) 支持 Android 和 iOS，但它只支持 Xamarin，不支持 MAUI，并且 Android 每个 ABI 下的 lib 体积都在 100 MiB 左右，远超桌面端的 10 MiB。由于包体积过大，从 v2.45 开始的包无法再上传到 NuGet 上，只能手动下载：
  - [Grpc.Core.Xamarin NuGet packages missing starting from v2.45.x · Issue #30071 · grpc/grpc](https://github.com/grpc/grpc/issues/30071)

  可以通过以下方式手动支持 .NET Android：
  ```xml
  <PropertyGroup>
    <RuntimeIdentifiers Condition="$(TargetFramework.Contains('-android'))">android-arm64;android-arm;android-x86</RuntimeIdentifiers>
  </PropertyGroup>

  <ItemGroup Condition="$(TargetFramework.Contains('-android'))">
    <AndroidNativeLibrary Include="$(NuGetPackageRoot)grpc.core.xamarin\2.44.0\native\android\arm64-v8a\libgrpc_csharp_ext.so">
      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
      <Abi>arm64-v8a</Abi>
    </AndroidNativeLibrary>
  </ItemGroup>

  <ItemGroup Condition="$(TargetFramework.Contains('-android'))">
    <AndroidNativeLibrary Include="$(NuGetPackageRoot)grpc.core.xamarin\2.44.0\native\android\armeabi-v7a\libgrpc_csharp_ext.so">
      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
      <Abi>armeabi-v7a</Abi>
    </AndroidNativeLibrary>
  </ItemGroup>

  <ItemGroup Condition="$(TargetFramework.Contains('-android'))">
    <AndroidNativeLibrary Include="$(NuGetPackageRoot)grpc.core.xamarin\2.44.0\native\android\x86\libgrpc_csharp_ext.so">
      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
      <Abi>x86</Abi>
    </AndroidNativeLibrary>
  </ItemGroup>
  ```

- [Grpc.Tools](https://www.nuget.org/packages/Grpc.Tools/)

  [Google.Protobuf](https://www.nuget.org/packages/Google.Protobuf/) is also required.

  Known issues:
  - [WPF projects unable to generate gRPC C# assets from `.proto` files](https://learn.microsoft.com/en-us/aspnet/core/grpc/troubleshoot?view=aspnetcore-7.0#wpf-projects-unable-to-generate-grpc-c-assets-from-proto-files)

### Rust
- [tonic: A native gRPC client & server implementation with async/await support.](https://github.com/hyperium/tonic)
  - [tonic-web: grpc-web protocol translation for tonic services.](https://docs.rs/crate/tonic-web/latest)

  - Unix domain sockets: [examples/src/uds](https://github.com/hyperium/tonic/tree/master/examples/src/uds)

    [Unix Domain Socket on Windows for gRPC connection - help - The Rust Programming Language Forum](https://users.rust-lang.org/t/unix-domain-socket-on-windows-for-grpc-connection/112077)

  - Named pipe: [How to implement an async read/write incoming stream with tokio named pipe? - Issue #1518 - hyperium/tonic](https://github.com/hyperium/tonic/issues/1518)
    - async-stream: [catalinsh/tonic-named-pipe-example: Basic Tonic (gRPC) example using Windows Named Pipes for communication](https://github.com/catalinsh/tonic-named-pipe-example)

    [Helper struct/wrapper for a stream of named pipe connections - Issue #6591 - tokio-rs/tokio](https://github.com/tokio-rs/tokio/issues/6591)

  - [concurrent use of client - Issue #285 - hyperium/tonic](https://github.com/hyperium/tonic/issues/285)

    `client.clone()`
  
  - [tonic-rpc: Build RPCs on top of the tonic gRPC library by defining your types in Rust instead of proto.](https://github.com/adamrk/tonic-rpc) (inactive)

    > This means that you can get all the benefits of tonic while using regular Rust types and without needing to use proto files or build scripts. Of course, this comes at the sacrifice of interoperability.

- [grpc-rs: The gRPC library for Rust built on C Core library and futures](https://github.com/tikv/grpc-rs)
- [grpc-rust: Rust implementation of gRPC](https://github.com/stepancheg/grpc-rust)

Notes:
- `Client::connect()` is async and fallible.

  Workaround:
  ```rust
  Client::new(tonic::transport::Endpoint::from_static("http://[::1]:50051").connect_lazy())
  ```

- Interceptor: [tonic/examples/src/interceptor/client.rs at master - hyperium/tonic](https://github.com/hyperium/tonic/blob/master/examples/src/interceptor/client.rs)

  [Storing `with_interceptor` clients is substantially more challenging in 0.5 - Issue #730 - hyperium/tonic](https://github.com/hyperium/tonic/issues/730)

Build:
- One crate

  ```toml
  [package]
  name = "plugin"
  version = "0.1.0"
  edition = "2021"

  [[bin]]
  name = "plugin-server"
  path = "src/server.rs"

  [[bin]]
  name = "plugin-client"
  path = "src/client.rs"

  [dependencies]
  prost = "0.12"
  tokio = { version = "1.0", features = ["macros", "rt-multi-thread"] }
  tonic = "0.11"
  ...server_deps
  ...client_deps

  [build-dependencies]
  tonic-build = "0.11"
  ```

- Three crates

  `plugin`:
  ```toml
  [package]
  name = "plugin"
  version = "0.1.0"
  edition = "2021"

  [dependencies]
  prost = "0.12"
  tonic = "0.11"

  [build-dependencies]
  tonic-build = "0.11"
  ```

  `plugin-server`:
  ```toml
  [package]
  name = "plugin-server"
  version = "0.1.0"
  edition = "2021"

  [dependencies]
  plugin = { path = "../plugin" }
  tokio = { version = "1.0", features = ["macros", "rt-multi-thread"] }
  tonic = "0.11"
  ...server_deps
  ```

  `plugin-client`:
  ```toml
  [package]
  name = "plugin-client"
  version = "0.1.0"
  edition = "2021"

  [dependencies]
  plugin = { path = "../plugin" }
  tokio = { version = "1.0", features = ["macros", "rt-multi-thread"] }
  tonic = "0.11"
  ...client_deps
  ```

## Tools
GUI:
- [Postman](https://www.postman.com/)
- [gRPC UI: An interactive web UI for gRPC, along the lines of postman](https://github.com/fullstorydev/grpcui)
- [gRPCox: Like Postman, but for gRPC](https://github.com/gusaul/grpcox)
- [BllomRPC](https://github.com/bloomrpc/bloomrpc) (discontinued)

CLI:
- [gRPCurl: Like cURL, but for gRPC](https://github.com/fullstorydev/grpcurl)