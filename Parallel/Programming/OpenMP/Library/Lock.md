# Lock Routines
```c++
// Initialize a simple mutex
void omp_init_lock(omp_lock_t *lock)
// Initialize a nested mutex
void omp_init_nest_lock(omp_nested_lock_t *lock)

// Add simple mutex operation
void omp_set_lock(omp_lock_t *lock)
// Add nested mutex operations
void omp_set_nest_lock(omp_nested_lock_t *lock)

// Unlock a simple mutex operation, used in conjunction with omp_set_lock()
void omp_unset_lock(omp_lock_t *lock)
// Unlock a simple mutex operation, used in conjunction with omp_set_lock()
void omp_unset_nest_lock(omp_nested_lock_t *lock)

// The omp_init_lock() function is paired to close a simple mutex
void omp_destroy_lock(omp_lock_t *lock)
// The omp_init_lock() function is paired to close a nested mutex
void omp_destroy_nest_lock(omp_nested_lock_t *lock)

// Attempt to acquire a simple mutex, failed range 0
int omp_test_lock(omp_lock_t *lock)
// Attempt to acquire a nested mutex, failed range 0
int omp_test_nest_lock(omp_nested_lock_t *lock)
```