# Distributed Computing
> Distributed computing is a field of computer science that studies distributed systems, defined as computer systems whose inter-communicating components are located on different networked computers.

与 networking 的区别是，networking 并不一定涉及显式的计算，可以分发静态内容，而 distributed computing 必然涉及到计算。
- IPC 尽管也不涉及显式的计算，但并不像 networking 一样在不同的物理位置间传输信息，更像是 OS 的一种内部计算过程。

## Program streaming
[Wikipedia](https://en.wikipedia.org/wiki/Application_streaming)

- Code streaming
  - Downloading

    In a high view, downloading a program and then running it locally implies a distributed system, where the host server and the client makes the computation together.

- Data streaming
  - [RPC](RPC/README.md)
  - UI streaming
    - CLI/TUI: SSH
    - GUI: Screen streaming

- Mixed streaming
  - [→Web](https://github.com/Chaoses-Ib/Web)