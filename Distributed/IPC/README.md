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
- Windows: [Local Inter-Process Communication](https://en.wikipedia.org/wiki/Local_Inter-Process_Communication) (LPC/ALPC)

[IPC-Bench: :racehorse: Benchmarks for Inter-Process-Communication Techniques](https://github.com/goldsborough/ipc-bench)

## Memory-mapped files
- [cloudflare/mmap-sync: Rust library for concurrent data access, using memory-mapped files, zero-copy deserialization, and wait-free synchronization.](https://github.com/cloudflare/mmap-sync)

  [Every request, every microsecond: scalable machine learning at Cloudflare](https://blog.cloudflare.com/scalable-machine-learning-at-cloudflare)
  > A read operation through the **`Synchronizer`** performs zero-copy deserialization and returns a "guarded" **`Result`** encapsulating a reference to the Rust struct using RAII design pattern. This operation also increments the atomic counter of active readers using the struct. Once the **`Result`** is out of scope, the **`Synchronizer`** decrements the number of readers.

  Linux, Windows.

## Shared memory
- [Eclipse iceoryx: True zero-copy inter-process-communication](https://github.com/eclipse-iceoryx/iceoryx)

  vcpkg

  Rust: [iceoryx-rs](https://github.com/eclipse-iceoryx/iceoryx-rs)

  - Eclipse iceoryx2

C/C++:
- [eCAL: enhanced Communication Abstraction Layer. A high performance publish-subscribe, client-server cross-plattform middleware.](https://github.com/eclipse-ecal/ecal)

  vcpkg

- [Shadesmar: Fast C++ IPC using shared memory](https://github.com/Squadrick/shadesmar) ([r/cpp](https://www.reddit.com/r/cpp/comments/qzri9j/shadesmar_fast_c_ipc_using_shared_memory/))

- [Flow-IPC: Modern C++ toolkit for high-speed inter-process communication (IPC)](https://github.com/Flow-IPC/ipc)

- [AlephZero](https://github.com/alephzero/alephzero)

- [mutouyun/cpp-ipc: C++ IPC Library: A high-performance inter-process communication using shared memory on Linux/Windows.](https://github.com/mutouyun/cpp-ipc)

  vcpkg

- [microsoft/IPC: IPC is a C++ library that provides inter-process communication using shared memory on Windows. A .NET wrapper is available which allows interaction with C++ as well.](https://github.com/microsoft/IPC) (discontinued)

Rust:
- shmem-ipc

No messages:
- [shared\_memory: A Rust wrapper around native shared memory for Linux and Windows](https://github.com/elast0ny/shared_memory)

- [boostorg/interprocess: Boost.org interprocess module](https://github.com/boostorg/interprocess)

  [Sharing memory between processes](https://www.boost.org/doc/libs/1_84_0/doc/html/interprocess/sharedmemorybetweenprocesses.html)

Applications:
- Sensor data

  很多传感器的驱动是 C++ 写的，对 C++ 的支持比较重要。

## Pipes
Rust:
- [std::process::Stdio](https://doc.rust-lang.org/std/process/struct.Stdio.html)
- [os_pipe.rs: a cross-platform library for opening OS pipes in Rust](https://github.com/oconnor663/os_pipe.rs)
- [tokio::net](https://docs.rs/tokio/latest/tokio/net/index.html)
- [Hyper-named-pipe: Exposes a HTTP interface over Tokio's Named Pipes implementation through a Hyper Connection interface.](https://github.com/fussybeaver/hyper-named-pipe)

## Unix domain sockets
[Wikipedia](https://en.wikipedia.org/wiki/Unix_domain_socket)

Windows starts to support Unix domain sockets from Windows 17063, released on 2018-04-10. See [AF_UNIX comes to Windows - Windows Command Line](https://devblogs.microsoft.com/commandline/af_unix-comes-to-windows/) for details.

## Message queues
- [ZeroMQ](https://zeromq.org/) ([GitHub](https://github.com/zeromq/libzmq))
- [nanomsg](https://nanomsg.org/) ([GitHub](https://github.com/nanomsg/nanomsg))
- [NNG](https://nng.nanomsg.org/) ([GitHub](https://github.com/nanomsg/nng))
- [Zenoh: zenoh unifies data in motion, data in-use, data at rest and computations. It carefully blends traditional pub/sub with geo-distributed storages, queries and computations, while retaining a level of time and space efficiency that is well beyond any of the mainstream stacks.](https://github.com/eclipse-zenoh/zenoh)
  - TCP/UDP/QUIC/HTTP, shared memory
  - [DORA: DORA (Dataflow-Oriented Robotic Architecture) is middleware designed to streamline and simplify the creation of AI-based robotic applications. It offers low latency, composable, and distributed dataflow capabilities. Applications are modeled as directed graphs, also referred to as pipelines.](https://github.com/dora-rs/dora)

    > Communication between nodes is handled with shared memory on a same machine and TCP on distributed machines. Our shared memory implementation tracks messages across processes and discards them when obsolete. Shared memory slots are cached to avoid new memory allocation.

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

- [Eclipse iceoryx2: True zero-copy inter-process-communication in pure Rust](https://github.com/eclipse-iceoryx/iceoryx2) ([Website](https://iceoryx.io/), [Docs.rs](https://docs.rs/iceoryx2/))

  - Shared memory
  - Cycle time
  - Languages: Rust, C/C++
    - [Can I use cpp programmer as a publisher and rust program as a subscriber? - Discussion #480](https://github.com/eclipse-iceoryx/iceoryx2/discussions/480)
      - [Apart from the memory layout, iceoryx2 also requires the type name to be the same. - Issue #481](https://github.com/eclipse-iceoryx/iceoryx2/issues/481)
  - [`is_compatible_to()`](https://github.com/eclipse-iceoryx/iceoryx2/blob/main/iceoryx2/src/service/static_config/message_type_details.rs#L128)
  - 32-bit
    - ~~[Introduce `atomic` type for iceoryx - Issue #200](https://github.com/eclipse-iceoryx/iceoryx2/issues/200)~~
    - ~~[Cannot build for target `i686-pc-windows-msvc` - Issue #235](https://github.com/eclipse-iceoryx/iceoryx2/issues/235)~~
    - [Fully support C and C++ Bindings on 32 Bit Architectures - Issue #262](https://github.com/eclipse-iceoryx/iceoryx2/issues/262)
    - Cross 32/64-bit communication?
      - [Interoperability between 32-bit and 64-bit applications. - Issue #402](https://github.com/eclipse-iceoryx/iceoryx2/issues/402)

  ```mermaid
  gantt
      title Latency (in ns) - 64b payload
      dateFormat X
      axisFormat %s

      section iceoryx2
      240 : 0, 240
      section iceoryx
      1000 : 0, 1000
      section MQueue
      700 : 0, 700
      section UDS
      1500 : 0, 1500
  ```

  ```mermaid
  gantt
      title Latency (in ns) - 64kb payload
      dateFormat X
      axisFormat %s

      section iceoryx2
      240 : 0, 240
      section iceoryx
      1000 : 0, 1000
      section MQueue
      14000 : 0, 14000
      section UDS
      23000 : 0, 23000
  ```

- [servo/ipc-channel: A multiprocess drop-in replacement for Rust channels](https://github.com/servo/ipc-channel)
  - OS
    - Unix: Unix domain sockets
    - Windows: named pipes
      - [Use ALPC on Windows - Issue #211](https://github.com/servo/ipc-channel/issues/211)

    [How about using shared-memory to implement ipc-channel. - Issue #128](https://github.com/servo/ipc-channel/issues/128)
  
  - [Channel between 64-bit and 32-bit process - Issue #304](https://github.com/servo/ipc-channel/issues/304)
    - [YaLTeR/ipc-channel at 64-to-32-bits](https://github.com/YaLTeR/ipc-channel/tree/64-to-32-bits)

  - [ipc-rpc](https://github.com/Xaeroxe/ipc-rpc)

- [Interprocess: Multifunctional cross-platform interprocess communication toolkit for Rust.](https://github.com/kotauskas/interprocess)

  - Unix: Unix domain sockets, FIFO files, unnamed pipes.
  - Windows: named pipes, unnamed pipes.
- [shmem-ipc: Untrusted IPC with maximum performance and minimum latency. On Rust, on Linux.](https://github.com/diwic/shmem-ipc)

  Linux: Shared memory
- [BUS/RT: Modern, fast, Rust-native IPC broker](https://github.com/alttch/busrt)

  Unix domain sockets, TCP sockets.
- [rs-ipc: A rust library for interprocess communication](https://github.com/Tommoa/rs-ipc) (discontinued)