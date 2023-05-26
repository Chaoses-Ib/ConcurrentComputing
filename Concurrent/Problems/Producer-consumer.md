# Producer-consumer Problem
[Wikipedia](https://en.wikipedia.org/wiki/Producer%E2%80%93consumer_problem)

**Producer-consumer problem (bounded-buffer problem)**

Imagine one or more producer threads and one or more consumer threads. Producers generate data items and place them in a buffer; consumers grab said items from the buffer and consume them in some way.

C[^three]:
```c
int buffer;
int count = 0;  // initially, empty

void put(int value) {
    assert(count == 0);
    count = 1;
    buffer = value;
}

int get() {
    assert(count == 1);
    count = 0;
    return buffer;
}
```

## Condition variables
Obviously the `put()` and `get()` routines have critical sections within them, as `put()` updates the buffer, and `get()` reads from it. However, putting a lock around the code doesn’t work; we need something more. Not surprisingly, that something more is some condition variables.[^three]

```c
int loops;  // must initialize somewhere...
cond_t cond;
mutex_t mutex;

void *producer(void *arg) {
    int i;
    for (i = 0; i < loops; i++) {
        Pthread_mutex_lock(&mutex);            // p1
        // while (count == 1)
        if (count == 1)                        // p2
            Pthread_cond_wait(&cond, &mutex);  // p3
        put(i);                                // p4
        Pthread_cond_signal(&cond);            // p5
        Pthread_mutex_unlock(&mutex);          // p6
    }
}

void *consumer(void *arg) {
    int i;
    for (i = 0; i < loops; i++) {
        Pthread_mutex_lock(&mutex);            // c1
        // while (count == 0)
        if (count == 0)                        // c2
            Pthread_cond_wait(&cond, &mutex);  // c3
        int tmp = get();                       // c4
        Pthread_cond_signal(&cond);            // c5
        Pthread_mutex_unlock(&mutex);          // c6
        printf("%d\n", tmp);
    }
}
```

With just a single producer and a single consumer, the code works. However, if we have more than one of these threads (e.g., two consumers), the solution has two critical problems:
- The first can be fixed by changing `if` to `while`.
- The second can be fixed by adding one more condition variable:

  ```c
  cond_t empty, fill;
  mutex_t mutex;

  void *producer(void *arg) {
      int i;
      for (i = 0; i < loops; i++) {
          Pthread_mutex_lock(&mutex);
          while (count == 1)
              Pthread_cond_wait(&empty, &mutex);
          put(i);
          Pthread_cond_signal(&fill);
          Pthread_mutex_unlock(&mutex);
      }
  }

  void *consumer(void *arg) {
      int i;
      for (i = 0; i < loops; i++) {
      Pthread_mutex_lock(&mutex);
      while (count == 0)
          Pthread_cond_wait(&fill, &mutex);
      int tmp = get();
      Pthread_cond_signal(&empty);
      Pthread_mutex_unlock(&mutex);
      printf("%d\n", tmp);
      }
  }
  ```

## Semaphores
C[^three]:
```c
int buffer[MAX];
int fill = 0;
int use = 0;

void put(int value) {
    buffer[fill] = value;
    fill = (fill + 1) % MAX;
}

int get() {
    int tmp = buffer[use];
    use = (use + 1) % MAX;
    return tmp;
}
```

```c
sem_t empty;
sem_t full;

void *producer(void *arg) {
    int i;
    for (i = 0; i < loops; i++) {
        sem_wait(&empty);
        put(i);
        sem_post(&full);
    }
}

void *consumer(void *arg) {
    int i, tmp = 0;
    while (tmp != -1) {
        sem_wait(&full);
        tmp = get();
        sem_post(&empty);
        printf("%d\n", tmp);
    }
}

int main(int argc, char *argv[]) {
    // ...
    sem_init(&empty, 0, MAX);  // MAX buffers are empty to begin with...
    sem_init(&full, 0, 0);  // ... and 0 are full
    // ...
}
```

If `MAX` is greater than 1 and there are multiple producers and multiple consumers, there will be a race condition. A lock is needed to fix this problem:

```c
sem_t empty;
sem_t full;
sem_t mutex;

void *producer(void *arg) {
    int i;
    for (i = 0; i < loops; i++) {
        sem_wait(&empty);  // Line P1
        sem_wait(&mutex);  // Line P1.5 (MOVED MUTEX HERE...)
        put(i);            // Line P2
        sem_post(&mutex);  // Line P2.5 (... AND HERE)
        sem_post(&full);   // Line P3
    }
}

void *consumer(void *arg) {
    int i;
    for (i = 0; i < loops; i++) {
        sem_wait(&full);   // Line C1
        sem_wait(&mutex);  // Line C1.5 (MOVED MUTEX HERE...)
        int tmp = get();   // Line C2
        sem_post(&mutex);  // Line C2.5 (... AND HERE)
        sem_post(&empty);  // Line C3
        printf("%d\n", tmp);
    }
}

int main(int argc, char *argv[]) {
    // ...
    sem_init(&empty, 0, MAX);  // MAX buffers are empty to begin with...
    sem_init(&full, 0, 0);     // ... and 0 are full
    sem_init(&mutex, 0, 1);    // mutex=1 because it is a lock
    // ...
}
```


[^three]: Operating Systems: Three Easy Pieces