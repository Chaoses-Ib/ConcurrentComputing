# Point-to-Point Communication
## Blocking Send and Receive Operations
### Blocking Send
```cpp
// buf: initial address of send buﬀer
// count: number of elements in send buﬀer
// datatype: datatype of each send buﬀer element
// dest: rank of destination
// tag: message tag
// comm: communicator
int MPI_Send(const void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm)
```

### Blocking Receive
```cpp
// source: rank of source or MPI_ANY_SOURCE
// tag: message tag or MPI_ANY_TAG
int MPI_Recv(void *buf, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm comm, MPI_Status *status)

int MPI_Recv_c(void *buf, MPI_Count count, MPI_Datatype datatype, int source, int tag, MPI_Comm comm, MPI_Status *status)
```

### Message Data

MPI datatype | C/C++ datatype
--- | ---
`MPI_C_BOOL` | `_Bool`
`MPI_CXX_BOOL` | `bool`
`MPI_SIGNED_CHAR` | `signed char`
`MPI_SHORT` | `signed short int`
`MPI_INT` | `signed int`
`MPI_LONG` | `signed long int`
`MPI_LONG_LONG_INT / MPI_LONG_LONG` | `signed long long int`
`MPI_UNSIGNED_CHAR` | `unsigned char`
`MPI_UNSIGNED_SHORT` | `unsigned short int`
`MPI_UNSIGNED` | `unsigned int`
`MPI_UNSIGNED_LONG` | `unsigned long int`
`MPI_UNSIGNED_LONG_LONG` | `unsigned long long int`
`MPI_INT8_T` | `int8_t`
`MPI_INT16_T` | `int16_t`
`MPI_INT32_T` | `int32_t`
`MPI_INT64_T` | `int64_t`
`MPI_UINT8_T` | `uint8_t`
`MPI_UINT16_T` | `uint16_t`
`MPI_UINT32_T` | `uint32_t`
`MPI_UINT64_T` | `uint64_t`
`MPI_FLOAT` | `float`
`MPI_DOUBLE` | `double`
`MPI_LONG_DOUBLE` | `long double`
`MPI_C_COMPLEX / MPI_C_FLOAT_COMPLEX` | `float _Complex`
`MPI_C_DOUBLE_COMPLEX` | `double _Complex`
`MPI_C_LONG_DOUBLE_COMPLEX` | `long double _Complex`
`MPI_CXX_FLOAT_COMPLEX` | `std::complex<float>`
`MPI_CXX_DOUBLE_COMPLEX` | `std::complex<double>`
`MPI_CXX_LONG_DOUBLE_COMPLEX` | `std::complex<long double>`
`MPI_CHAR` | `char`
`MPI_WCHAR` | `wchar_t`
`MPI_BYTE` | 
`MPI_PACKED` | 

## Semantics of Point-to-Point Communication
### Order
Messages are non-overtaking. If a sender sends two messages in succession to the same destination, and both match the same receive, then this operation cannot receive the second message if the ﬁrst one is still pending. It guarantees that message-passing code is deterministic, if processes are single-threaded and the wildcard `MPI_ANY_SOURCE` is not used in receives.


## Communication Modes
- Standard mode (`MPI_Send`)
	Directly send or buffer and send, determined by the environment.
- Buffered mode (`MPI_Bsend`)
- Synchronous mode (`MPI_Ssend`)
- Ready mode (`MPI_Rsend`)
	Send only when the receiver is ready.


## Nonblocking Communication
```cpp
// request: the handle of communication request
int MPI_Isend(const void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm, MPI_Request *request)

int MPI_Isend_c(const void *buf, MPI_Count count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm, MPI_Request *request)

int MPI_Irecv(void *buf, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm comm, MPI_Request *request)

int MPI_Irecv_c(void *buf, MPI_Count count, MPI_Datatype datatype, int source, int tag, MPI_Comm comm, MPI_Request *request)
```
- Isend 与 Bsend 的区别就是前者可以查询状态吗？

### Communication Completion
```cpp
int MPI_Wait(MPI_Request *request, MPI_Status *status)

// flag: true if operation completed
int MPI_Test(MPI_Request *request, int *flag, MPI_Status *status)
```
