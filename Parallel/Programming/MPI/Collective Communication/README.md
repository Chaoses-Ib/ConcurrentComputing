# Collective Communication
Synchronization:
- MPI_Barrier

Communication:
- MPI_Bcast: 一对多广播
- MPI_Scatter: 一对多散播不同消息
- MPI_Gather: 多对一收集
- MPI_Allgather: 全局收集
- MPI_Alltoall: 多对多交换

Reduction:
- MPI_Reduce: 多对一规约
- MPI_Reduce_scatter
- MPI_Allreduce: 多对多规划

Scan:
- MPI_Scan

## Broadcast
```cpp
// root:  rank of broadcast root
int MPI_Bcast(
  void *buffer, int count, MPI_Datatype datatype,
  int root, MPI_Comm comm)
```
If comm is an intra-communicator, `MPI_BCAST` broadcasts a message from the process with rank root to all processes of the group, itself included. It is called by all members of the group using the same arguments for comm and root. On return, the content of root’s buﬀer is copied to all other processes (`buffer`).

## Gather
```cpp
int MPI_Gather(
  const void *sendbuf, int sendcount, MPI_Datatype sendtype,
  void *recvbuf, int recvcount, MPI_Datatype recvtype,
  int root, MPI_Comm comm)
```
If comm is an intra-communicator, each process (root process included) sends the contents of its send buﬀer to the root process. The root process receives the messages and stores them in rank order. The outcome is as if each of the n processes in the group (including the root process) had executed a call to
```c
MPI_Send(sendbuf, sendcount, sendtype, root , ...)
```
and the root had executed n calls to
```c
MPI_Recv(recvbuf+i, recvcount, extent(recvtype), recvcount, recvtype, i, ...)
```
where extent(recvtype) is the type extent obtained from a call to `MPI_Type_get_extent`.

## Scatter
```cpp
int MPI_Scatter(
  const void *sendbuf, int sendcount, MPI_Datatype sendtype,
  void *recvbuf, int recvcount, MPI_Datatype recvtype,
  int root, MPI_Comm comm)
```
`MPI_SCATTER` is the inverse operation to `MPI_GATHER`.

## Barrier Synchronization
- 为什么加了 barrier 输出还是会乱序？
  
  因为有 buffer，要 flush()。

  不过收集不同节点的输出到执行节点的方式是[实现定义](https://stackoverflow.com/questions/5305061/ordering-output-in-mpi)的：
  - MSMPI 会将各个节点独立输出为一行。