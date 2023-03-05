# Inter-Process Communication
[Wikipedia](https://en.wikipedia.org/wiki/Inter-process_communication)

## Remote procedure call
- [gRPC](https://grpc.io/) ([GitHub](https://github.com/grpc/grpc))

  TCP, Unix domain sockets.
  - Named pipes: [I could use a Windows named pipe transport. · Issue #13447 · grpc/grpc](https://github.com/grpc/grpc/issues/13447)
  - Shared memory: [Is there a way to use shared memory instead of socket on a local machine for rpc? · Issue #19959 · grpc/grpc](https://github.com/grpc/grpc/issues/19959)

  [Using gRPC for (local) inter-process communication | F. Werner’s Research Page](https://www.mpi-hd.mpg.de/personalhomes/fwerner/research/2021/09/grpc-for-ipc/)

  [Various gRPC benchmarks](https://github.com/LesnyRumcajs/grpc_bench)
  
## Message queues
- [ZeroMQ](https://zeromq.org/) ([GitHub](https://github.com/zeromq/libzmq))
- [nanomsg](https://nanomsg.org/) ([GitHub](https://github.com/nanomsg/nanomsg))
- [NNG](https://nng.nanomsg.org/) ([GitHub](https://github.com/nanomsg/nng))

[Differences between nanomsg and ZeroMQ](https://nanomsg.org/documentation-zeromq.html)
