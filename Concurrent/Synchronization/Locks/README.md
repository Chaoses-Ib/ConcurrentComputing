# Locks
[Wikipedia](https://en.wikipedia.org/wiki/Lock_(computer_science))

A **lock** or **mutex** (from mutual exclusion) is a synchronization primitive: a mechanism that enforces limits on access to a resource when there are many threads of execution. A lock is designed to enforce a mutual exclusion concurrency control policy, and with a variety of possible methods there exists multiple unique implementations for different applications.[^wiki]

A **lock** is just a variable, and thus to use one, you must declare a **lock variable** of some kind. This lock variable holds the state of the lock at any instant in time. It is either **available (or unlocked or free)** and thus no thread holds the lock, or **acquired (or locked or held)**, and thus exactly one thread holds the lock and presumably is in a critical section.

Locks provide some minimal amount of control over scheduling to programmers. In general, we view threads as entities created by the programmer but scheduled by the OS, in any fashion that the OS chooses. Locks yield some of that control back to the programmer; by putting a lock around a section of code, the programmer can guarantee that no more than a single thread can ever be active within that code. Thus locks help transform the chaos that is traditional OS scheduling into a more controlled activity.[^three]

[multithreading - How efficient is locking an unlocked mutex? What is the cost of a mutex? - Stack Overflow](https://stackoverflow.com/questions/3652056/how-efficient-is-locking-an-unlocked-mutex-what-is-the-cost-of-a-mutex)

## Atomic read-write
### Dekker's Algorithm
[Wikipedia](https://en.wikipedia.org/wiki/Dekker%27s_algorithm)

Dekker's algorithm uses only atomic read-writes.

### Peterson's algorithm
[Wikipedia](https://en.wikipedia.org/wiki/Peterson%27s_algorithm)

不同于其它 lock，Peterson's algorithm 的每个尝试获取者都在让出 lock。如果只是让出 lock，当其它线程不需要 lock 时就会出现死锁，因此又加了一个表明是否需要 lock 的 flag 数组。当 lock 被让给某个线程，它又需要 lock 时，就可以获取 lock；否则，让出者就可以获取 lock。这种让出的策略避免了 lock variable 的 data race，使得 Peterson's algorithm 只需要最基础的 atomic read-write 就能实现。

```c
bool flag[2] = {false, false};
int turn;

void P0() {
    flag[0] = true;
    turn = 1;
    while (flag[1] == true && turn == 1)
    {
        // busy wait
    }
    // critical section
    ...
    // end of critical section
    flag[0] = false;
}

void P1() {
    flag[1] = true;
    turn = 0;
    while (flag[0] == true && turn == 0)
    {
        // busy wait
    }
    // critical section
    ...
    // end of critical section
    flag1[1] = false;
}
```

不过，由于现代 CPU 的乱序访问特性，在现在使用 Peterson's algorithm 时还需要增加 memory barrier，这使得 Peterson's algorithm 失去了它的主要优势。

## Atomic swap
C[^three]:
```c
typedef struct __lock_t {
    int flag;
} lock_t;

void init(lock_t *lock) {
    // 0: lock is available, 1: lock is held
    lock->flag = 0;
}

void lock(lock_t *lock) {
    while (atomic_swap(&lock->flag, 1) == 1)
        ; // spin-wait (do nothing)
}

void unlock(lock_t *lock) {
    lock->flag = 0;
}
```

x86:
```x86asm
locked:                      ; The lock variable. 1 = locked, 0 = unlocked.
     dd      0

spin_lock:
     mov     eax, 1          ; Set the EAX register to 1.
     xchg    eax, [locked]   ; Atomically swap the EAX register with
                             ;  the lock variable.
                             ; This will always store 1 to the lock, leaving
                             ;  the previous value in the EAX register.
     test    eax, eax        ; Test EAX with itself. Among other things, this will
                             ;  set the processor's Zero Flag if EAX is 0.
                             ; If EAX is 0, then the lock was unlocked and
                             ;  we just locked it.
                             ; Otherwise, EAX is 1 and we didn't acquire the lock.
     jnz     spin_lock       ; Jump back to the MOV instruction if the Zero Flag is
                             ;  not set; the lock was previously locked, and so
                             ; we need to spin until it becomes unlocked.
     ret                     ; The lock has been acquired, return to the calling
                             ;  function.

spin_unlock:
     xor     eax, eax        ; Set the EAX register to 0.
     xchg    eax, [locked]   ; Atomically swap the EAX register with
                             ;  the lock variable.
     ret                     ; The lock has been released.
```

## Compare-and-swap
C[^three]:
```c
typedef struct __lock_t {
    int flag;
} lock_t;

void init(lock_t *lock) {
    // 0: lock is available, 1: lock is held
    lock->flag = 0;
}

void lock(lock_t *lock) {
    while (compare_and_swap(&lock->flag, 0, 1) == 1)
        ; // spin-wait (do nothing)
}

void unlock(lock_t *lock) {
    lock->flag = 0;
}
```

x86:
```x86asm
; In C: while (!__sync_bool_compare_and_swap(&locked, 0, 1)) while (locked) __builtin_ia32_pause();
spin_lock:
    mov     ecx, 1             ; Set the ECX register to 1.
retry:
    xor     eax, eax           ; Zero out EAX, because cmpxchg compares against EAX.
    XACQUIRE lock cmpxchg [locked], ecx
                               ; atomically decide: if locked is zero, write ECX to it.
                               ;  XACQUIRE hints to the processor that we are acquiring a lock.
    je      out                ; If we locked it (old value equal to EAX: 0), return.
pause:
    mov     eax, [locked]      ; Read locked into EAX.
    test    eax, eax           ; Perform the zero-test as before.
    jz      retry              ; If it's zero, we can retry.
    rep nop                    ; Tell the CPU that we are waiting in a spinloop, so it can
                               ;  work on the other thread now. Also written as the "pause".
    jmp     pause              ; Keep check-pausing.
out:
    ret                        ; All done.

spin_unlock:
    XRELEASE mov [locked], 0   ; Assuming the memory ordering rules apply, release the 
                               ;  lock variable with a "lock release" hint.
    ret                        ; The lock has been released.
```

## Load-link/store-conditional
C[^three]:
```c
void lock(lock_t *lock) {
    while (1) {
        while (load_linked(&lock->flag) == 1)
            ; // spin until it’s zero
        if (store_conditional(&lock->flag, 1) == 1)
            return; // if set-it-to-1 was a success: all done
                    // otherwise: try it all over again
    }
}

void unlock(lock_t *lock) {
    lock->flag = 0;
}
```

## Fetch-and-add
C[^three]:
```c
typedef struct __lock_t {
    int ticket;
    int turn;
} lock_t;

void lock_init(lock_t *lock) {
    lock->ticket = 0;
    lock->turn = 0;
}

void lock(lock_t *lock) {
    int myturn = fetch_and_add(&lock->ticket);
    while (lock->turn != myturn)
        ; // spin
}

void unlock(lock_t *lock) {
    lock->turn = lock->turn + 1;
}
```

Note one important difference with this solution versus our previous attempts: it ensures progress for all threads. Once a thread is assigned its ticket value, it will be scheduled at some point in the future.


[^wiki]: [Lock (computer science) - Wikipedia](https://en.wikipedia.org/wiki/Lock_(computer_science))
[^three]: Operating Systems: Three Easy Pieces