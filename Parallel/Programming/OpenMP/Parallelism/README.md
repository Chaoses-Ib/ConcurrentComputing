# Parallelism Generation and Control
## `parallel` Construct
When a thread encounters a `parallel` construct, a team of threads is created to execute the parallel region. The thread that encountered the `parallel` construct becomes the primary thread of the new team, with a thread number of zero for the duration of the new parallel region. All threads in the new team, including the primary thread, execute the region.  At the end of the parallel region, there will be a implicit sync.

The number of threads to execute a parallel region can be specified by:
- Conditional mode: `if` clause
  
  `if(cond) parallelly else serially`
- Static mode
  - `num_threads` clause
  - `omp_set_num_threads()`
  - `OMP_NUM_THREADS`
- default

- `omp_set_dynamic()`
  
  开启时会将指定的线程数作为线程数上限。默认开启。
- `omp_set_nested()`
  
  Enable or disable nested parallel operations. Disabled by default.

A thread may obtain its own thread number by a call to the `omp_get_thread_num` library routine.
