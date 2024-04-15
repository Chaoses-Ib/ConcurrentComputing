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
  - [Remote procedure calls](../RPC/README.md)
- Memory-mapped files

## Pipes
Rust:
- [std::process::Stdio](https://doc.rust-lang.org/std/process/struct.Stdio.html)
- [os_pipe.rs: a cross-platform library for opening OS pipes in Rust](https://github.com/oconnor663/os_pipe.rs)
- [tokio::net](https://docs.rs/tokio/latest/tokio/net/index.html)

## Unix domain sockets
[Wikipedia](https://en.wikipedia.org/wiki/Unix_domain_socket)

Windows starts to support Unix domain sockets from Windows 17063, released on 2018-04-10. See [AF_UNIX comes to Windows - Windows Command Line](https://devblogs.microsoft.com/commandline/af_unix-comes-to-windows/) for details.

## Message queues
- [ZeroMQ](https://zeromq.org/) ([GitHub](https://github.com/zeromq/libzmq))
- [nanomsg](https://nanomsg.org/) ([GitHub](https://github.com/nanomsg/nanomsg))
- [NNG](https://nng.nanomsg.org/) ([GitHub](https://github.com/nanomsg/nng))

[Differences between nanomsg and ZeroMQ](https://nanomsg.org/documentation-zeromq.html)

## Languages
### Rust
- [→gRPC](../RPC/gRPC.md#rust)
- ZeroMQ
  - [rust-zmq: Rust zeromq bindings.](https://github.com/erickt/rust-zmq)
  - [zmq.rs: A native implementation of ØMQ in Rust](https://github.com/zeromq/zmq.rs)
- nanomsg
  - [nng-rs](https://gitlab.com/neachdainn/nng-rs)
  - [runng](https://github.com/jeikabu/runng)
  - [nanomsg.rs: Nanomsg library for Rust](https://github.com/thehydroimpulse/nanomsg.rs) (discontinued)
- [ipc-channel: A multiprocess drop-in replacement for Rust channels](https://github.com/servo/ipc-channel)
- [Interprocess: Multifunctional cross-platform interprocess communication toolkit for Rust.](https://github.com/kotauskas/interprocess)

  - Unix: Unix domain sockets, FIFO files, unnamed pipes.
  - Windows: named pipes, unnamed pipes.
- [shmem-ipc: Untrusted IPC with maximum performance and minimum latency. On Rust, on Linux.](https://github.com/diwic/shmem-ipc)

  Shared memory.
- [BUS/RT: Modern, fast, Rust-native IPC broker](https://github.com/alttch/busrt)

  Unix domain sockets, TCP sockets.
- [rs-ipc: A rust library for interprocess communication](https://github.com/Tommoa/rs-ipc) (discontinued)