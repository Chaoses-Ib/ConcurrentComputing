# Inter-Process Communication
[Wikipedia](https://en.wikipedia.org/wiki/Inter-process_communication)

Approaches:
- Files
- Signals
- Sockets
  - TCP/IP
- Unix domain sockets
- Message queues
- Pipes
  - Anonymous pipes
  - Named pipes
- Shared memory
- Message passing
  - Remote procedure call
- Memory-mapped files

## Pipes
Rust:
- [std::process::Stdio](https://doc.rust-lang.org/std/process/struct.Stdio.html)
- [os_pipe.rs: a cross-platform library for opening OS pipes in Rust](https://github.com/oconnor663/os_pipe.rs)
- [tokio::net](https://docs.rs/tokio/latest/tokio/net/index.html)

## Unix domain sockets
[Wikipedia](https://en.wikipedia.org/wiki/Unix_domain_socket)

Windows starts to support Unix domain sockets from Windows 17063, released on 2018-04-10. See [AF_UNIX comes to Windows - Windows Command Line](https://devblogs.microsoft.com/commandline/af_unix-comes-to-windows/) for details.

## Remote procedure call
- [→gRPC](https://github.com/Chaoses-Ib/Networks/blob/main/Application/HTTP/gRPC.md)

## Message queues
- [ZeroMQ](https://zeromq.org/) ([GitHub](https://github.com/zeromq/libzmq))
- [nanomsg](https://nanomsg.org/) ([GitHub](https://github.com/nanomsg/nanomsg))
- [NNG](https://nng.nanomsg.org/) ([GitHub](https://github.com/nanomsg/nng))

[Differences between nanomsg and ZeroMQ](https://nanomsg.org/documentation-zeromq.html)
