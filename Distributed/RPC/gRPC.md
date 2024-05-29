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

  Running a server requires ASP.NET Core Runtime:
  - [Implementing a grpc server in .net standard class library · Issue #1419 · grpc/grpc-dotnet](https://github.com/grpc/grpc-dotnet/issues/1419)
  - [Replacement of Server functionality for .NET Framework (4.8) · Issue #1368 · grpc/grpc-dotnet](https://github.com/grpc/grpc-dotnet/issues/1368)
  - [Support for MAUI runtimes in ASP.NET Core? · Issue #35077 · dotnet/aspnetcore](https://github.com/dotnet/aspnetcore/issues/35077)

- [gRPC C#](https://github.com/grpc/grpc/tree/master/src/csharp) ([Grpc.Core](https://www.nuget.org/packages/Grpc.Core)) (discontinued)

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

  - [concurrent use of client - Issue #285 - hyperium/tonic](https://github.com/hyperium/tonic/issues/285)

    `client.clone()`

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