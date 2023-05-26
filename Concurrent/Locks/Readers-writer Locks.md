# Readers-writer Locks
[Wikipedia](https://en.wikipedia.org/wiki/Readers%E2%80%93writer_lock)

C[^three]:
```c
typedef struct _rwlock_t {
    sem_t lock; // binary semaphore (basic lock)
    sem_t writelock; // used to allow ONE writer or MANY readers
    int readers; // count of readers reading in critical section
} rwlock_t;

void rwlock_init(rwlock_t *rw) {
    rw->readers = 0;
    sem_init(&rw->lock, 0, 1);
    sem_init(&rw->writelock, 0, 1);
}

void rwlock_acquire_readlock(rwlock_t *rw) {
    sem_wait(&rw->lock);
    rw->readers++;
    if (rw->readers == 1)
        sem_wait(&rw->writelock); // first reader acquires writelock
    sem_post(&rw->lock);
}

void rwlock_release_readlock(rwlock_t *rw) {
    sem_wait(&rw->lock);
    rw->readers--;
    if (rw->readers == 0)
        sem_post(&rw->writelock); // last reader releases writelock
    sem_post(&rw->lock);
}

void rwlock_acquire_writelock(rwlock_t *rw) {
    sem_wait(&rw->writelock);
}

void rwlock_release_writelock(rwlock_t *rw) {
    sem_post(&rw->writelock);
}
```

Readers-writer locks can also be implemented by [light switches](Light%20Switches.md):
```c
typedef struct _rwlock_t {
    lightswitch_t lightswitch;
    sem_t writelock; // used to allow ONE writer or MANY readers
    int readers; // count of readers reading in critical section
} rwlock_t;

void rwlock_init(rwlock_t *rw) {
    rw->readers = 0;
    lightswitch_init(&rw->lightswitch);
    sem_init(&rw->writelock, 0, 1);
}

void rwlock_acquire_readlock(rwlock_t *rw) {
    lightswitch_lock(&rw->lightswitch);
}

void rwlock_release_readlock(rwlock_t *rw) {
    lightswitch_unlock(&rw->lightswitch);
}

void rwlock_acquire_writelock(rwlock_t *rw) {
    sem_wait(&rw->writelock);
}

void rwlock_release_writelock(rwlock_t *rw) {
    sem_post(&rw->writelock);
}
```

## Starvation
If a writer arrives while there are readers in the critical section, it might wait in queue forever while readers come and go. As long as a new reader arrives before the last of the current readers departs, there will always be at least one reader in the room.

To solve this, you can add a **turnstile** for the readers and allow writers to lock it:[^little]
```python
def writer():
    turnstile.wait()
    roomEmpty.wait()  # i.e. writelock.wait()
    # critical section for writers
    turnstile.signal()
    roomEmpty.signal()

def reader():
    turnstile.wait()
    turnstile.signal()
    readSwitch.lock(roomEmpty)
    # critical section for readers
    readSwitch.unlock(roomEmpty)
```


[^three]: Operating Systems: Three Easy Pieces
[^little]: The Little Book of Semaphores