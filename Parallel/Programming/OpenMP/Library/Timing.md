# Timing Routines
```c++
// Returns elapsed wall clock time in seconds.
double omp_get_wtime();

// Returns the precision of the timer used by `omp_get_wtime`.
double omp_get_wtick();
```
The routines’ return values are not guaranteed to be consistent across any set of threads.  