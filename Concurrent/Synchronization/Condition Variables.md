# Condition Variables
[Wikipedia](https://en.wikipedia.org/wiki/Monitor_(synchronization))

A **condition variable** is an explicit queue that threads can put themselves on when some state of execution (i.e., some **condition**) is not as desired (by **waiting** on the condition); some other thread, when it changes said state, can then wake one (or more) of those waiting threads and thus allow them to continue (by **signaling** on the condition).[^three]

Condition variable 只记录线程，不记录状态。如果同时记录了状态，就成为了 semaphores。

## POSIX
Example[^three]:
```c
pthread_cond_wait(pthread_cond_t *c, pthread_mutex_t *m);
pthread_cond_signal(pthread_cond_t *c);

int done = 0;
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t c = PTHREAD_COND_INITIALIZER;

void thr_exit() {
    Pthread_mutex_lock(&m);
    done = 1;
    Pthread_cond_signal(&c);
    Pthread_mutex_unlock(&m);
}

void *child(void *arg) {
    printf("child\n");
    thr_exit();
    return NULL;
}

void thr_join() {
    Pthread_mutex_lock(&m);
    while (done == 0)
        Pthread_cond_wait(&c, &m);
    Pthread_mutex_unlock(&m);
}

int main(int argc, char *argv[]) {
    printf("parent: begin\n");
    pthread_t p;
    Pthread_create(&p, NULL, child, NULL);
    thr_join();
    printf("parent: end\n");
    return 0;
}
```

- Why `wait()` takes a mutex as a parameter?
  
  It assumes that this mutex is locked when `wait()` is called. The responsibility of `wait()` is to release the lock and put the calling thread to sleep (atomically); when the thread wakes up (after some other thread has signaled it), it must re-acquire the lock before returning to the caller.
  
  This complexity stems from the desire to prevent certain race conditions from occurring when a thread is trying to put itself to sleep. Speciﬁcally, if the parent calls `thr_join()` and then checks the value of `done`, it will see that it is 0 and thus try to go to sleep. But just before it calls wait to go to sleep, the parent is interrupted, and the child runs. The child changes the state variable `done` to 1 and signals, but no thread is waiting and thus no thread is woken. When the parent runs again, it sleeps forever, which is sad.

- Why is `done` necessary?

  If the child runs immediately and calls `thr_exit()` immediately, the child will signal, but there is no thread asleep on the condition. When the parent runs, it will simply call wait and be stuck; no thread will ever wake it.

## Condition set
What if I want to wait for related, but not the same, conditions? Like wait for a task with a specified id.

One way is to wait for all tasks via a single condvar, and then check the task with the specified id; another way is to wait for the specified task via its own condvar.

The core problem is if the cost of using multiple condvars is larger than waking all waiters.
- A condvar is usually implemented by a atomic, a mutex, and implicitly a waiter list. 
- For OS threads, waking all waiters is likely more expensive. But for couroutines, the answer is unsure.
- Single condvar is more flexiable, allowing cross-condition checks.
- Multiple condvars use more memory, but this is negligible for small amount of conditions.

[c++ - Multiple vs single condition variable - Stack Overflow](https://stackoverflow.com/questions/50580656/multiple-vs-single-condition-variable)

[c++ - What is the best way to wait on multiple condition variables in C++11? - Stack Overflow](https://stackoverflow.com/questions/27341029/what-is-the-best-way-to-wait-on-multiple-condition-variables-in-c11)

## Libraries
### Rust
- [`std::sync::Condvar`](https://doc.rust-lang.org/std/sync/struct.Condvar.html)
  - [`wait_while()`](https://doc.rust-lang.org/std/sync/struct.Condvar.html#method.wait_while)

  [Why does sync::Condvar require a Mutex? : r/rust](https://www.reddit.com/r/rust/comments/12cpdgr/why_does_synccondvar_require_a_mutex/)

- [`tokio::sync::Notify`](https://docs.rs/tokio/latest/tokio/sync/struct.Notify.html)
  - [sync: provide API for notifying multiple waiters. - Issue #3066 - tokio-rs/tokio](https://github.com/tokio-rs/tokio/issues/3066)
  - [Condition variables (again) - Issue #3892 - tokio-rs/tokio](https://github.com/tokio-rs/tokio/issues/3892)
    - [kaimast/tokio-condvar: Condition Variables for Tokio](https://github.com/kaimast/tokio-condvar)
  - [tokio-notify-aggregator: A tokio-based notify event aggregator](https://github.com/Phoenix1946/tokio-notify-aggregator/)


[^three]: Operating Systems: Three Easy Pieces