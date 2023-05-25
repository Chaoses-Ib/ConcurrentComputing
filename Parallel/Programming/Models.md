# Parallel Programming Models
A **parallel programming model** is an invisible abstraction between parallel algorithm design and its implementation based on *hardware architecture model*.

## Implicit parallel
Automated parallelism is an ideal goal.
- Parallelizing compiler
- Runtime support system

## Explicit parallel
### Data parallelism
- Divide data into blocks, map them to different processors and simultaneously execute the same instruction or program segmen.
- Suitable for SIMD and SPMD.

### Shared variables
- Natural model of symmetric multiprocessor.
- Single address space.

The de facto standard is [OpenMP](OpenMP/README.md).

### Messaging passing
- Natural model of clustering
- Separate/distributed address space
- Suitable for MPMD and SPMD

The de facto standard is [Message Passing Interface](MPI/README.md).

## Programming
Three extensions:
- New language constructs
  - HPF
- Library function method
  - [Message Passing Interface](MPI/README.md)
- Compilation guidance method
  - [OpenMP](OpenMP/README.md)