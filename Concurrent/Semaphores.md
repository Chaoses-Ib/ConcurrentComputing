# Semaphores
[Wikipedia](https://en.wikipedia.org/wiki/Semaphore_(programming))

A **semaphore** is an object with an integer value that we can manipulatewith two routines.

Semaphores are a powerful and flexible primitive for writing concurrent programs. Some programmers use them exclusively, shunning locks and condition variables, due to their simplicity and utility.[^three]

## Binary semaphores
Semaphores can be used as locks. Because locks only have two states (held and not held), we sometimes call a semaphore used as a lock a **binary semaphore**. 

C[^three]:
```c
sem_t m;
sem_init(&m, 0, 1);  // **1**

void t() {
    sem_wait(&m);
    // critical section here
    sem_post(&m);
}
```

## Semaphores for ordering
Semaphores can be used as an ordering primitive, similar to the use of condition variables.

C[^three]:
```c
sem_t s;

void* child(void *arg) {
    printf("child\n");
    sem_post(&s);  // signal here: child is done
    return NULL;
}

int main(int argc, char *argv[]) {
    sem_init(&s, 0, 0);  // **0**
    printf("parent: begin\n");
    pthread_t c;
    Pthread_create(&c, NULL, child, NULL);
    sem_wait(&s);  // wait here for child
    printf("parent: end\n");
    return 0;
}
```

Curiously, building condition variables out of semaphores is a much trickier proposition. Some highly experienced concurrent programmers tried to do this in the Windows environment, and many different bugs ensued.

## POSIX
Example[^three]:
```c
#include <semaphore.h>

int sem_wait(sem_t *s) {
    // Decrement the value of semaphore s by one.
    // Wait if value of semaphore s is negative.
}

int sem_post(sem_t *s) {
    // Increment the value of semaphore s by one.
    // If there are one or more threads waiting, wake one.
}

sem_t s;
sem_init(&s, 0, 1);
```

Zemaphores[^three]:
```c
typedef struct __Zem_t {
    int value;
    pthread_cond_t cond;
    pthread_mutex_t lock;
} Zem_t;

// only one thread can call this
void Zem_init(Zem_t *s, int value) {
    s->value = value;
    Cond_init(&s->cond);
    Mutex_init(&s->lock);
}

void Zem_wait(Zem_t *s) {
    Mutex_lock(&s->lock);
    while (s->value <= 0)
        Cond_wait(&s->cond, &s->lock);
    s->value--;
    Mutex_unlock(&s->lock);
}

void Zem_post(Zem_t *s) {
    Mutex_lock(&s->lock);
    s->value++;
    Cond_signal(&s->cond);
    Mutex_unlock(&s->lock);
}
```

One subtle difference between Zemaphore and pure semaphores as deﬁned by Dijkstra is that it don’t maintain the invariant that the value of the semaphore, when negative, reflects the number of waiting threads; indeed, the value will never be lower than zero. This behavior is easier to implement and matches the current Linux implementation.


[^three]: Operating Systems: Three Easy Pieces