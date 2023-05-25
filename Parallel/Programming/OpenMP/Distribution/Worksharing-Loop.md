# Worksharing-Loop Constructs
## `for` Construct
```c++
#pragma omp parallel for
for (int j = 0; j < omp_get_num_threads(); j++) {
    printf("j=%d, thread_id=%d\n", j, omp_get_thread_num());
}
```
```c++
#pragma omp parallel
{
	#pragma omp for
    for (int j = 0; j < omp_get_num_threads(); j++) {
        printf("j=%d, thread_id=%d\n", j, omp_get_thread_num());
    }
}
```
- Condition: `>, <, >=, <=`, signed integer
- Update: `+, -`

## `schedule` Clause
`schedule(kind, chunk_size)`

### static
```c++
#pragma omp parallel for schedule(static, 2)
for (int i = 0; i < 10; i++)
    printf("tid=%d, i=%d\n", omp_get_thread_num(), i);
    // _, {0, 1}
    // _, {2, 3}
    // ...
```
If the *kind* argument is `static`, iterations are divided into chunks of size *chunk_size*, and the chunks are assigned to the threads in the team in a round-robin fashion in the order of the thread number.

If *chunk_size* is not speciﬁed, the logical iteration space is divided into chunks that are approximately equal in size, and at most one chunk is distributed to each thread.

## dynamic
If the *kind* argument is `dynamic`, each thread executes a chunk, then requests another chunk, until no chunks remain to be assigned.

If *chunk_size* is not speciﬁed, it defaults to 1.

## guided
If the *kind* argument is `guided`, each thread executes a chunk, then requests another chunk, until no chunks remain to be assigned. For a *chunk_size* of $k$, the size of each chunk is proportional to the number of unassigned iterations divided by the number of threads in the team, decreasing to $k$.

If *chunk_size* is not speciﬁed, it defaults to 1.

## runtime
