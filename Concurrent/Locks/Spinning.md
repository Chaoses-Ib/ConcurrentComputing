# Spinning
[Wikipedia](https://en.wikipedia.org/wiki/Busy_waiting), [Spinlock - Wikipedia](https://en.wikipedia.org/wiki/Spinlock)

One good reason to avoid spin locks is performance: as described in the main text, if a thread is interrupted while holding a lock, other threads that use spin locks will spend a large amount of CPU time just waiting for the lock to become available.

However, it turns out there is another interesting reason to avoid spin locks on some systems: correctness. The problem to be wary of is known as **priority inversion**, which unfortunately is an intergalactic scourge. Just avoiding the use of spin locks, unfortunately, does not avoid the problem of inversion (alas). You can address the priority inversion problem in a number of ways:
- In the speciﬁc case where spin locks cause the problem, you can avoid using spin locks.
- More generally, a higher-priority thread waiting for a lower-priority thread can temporarily boost the lower thread’s priority, thus enabling it to run and overcoming the inversion, a technique known as **priority inheritance**.
- A last solution is simplest: ensure all threads have the same priority.

[Energy efficient spin-locking in multi-core machines](https://www.alessandropellegrini.it/publications/tRivi17.pdf)

## x86
Example implementation:
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

[Spin Locks Considered Harmful, and How to Write Them When We Must](https://www.intel.com/content/www/us/en/developer/articles/technical/spin-locks-considered-harmful.html)

除了 PAUSE，还有 TPAUSE、UMONITOR 和 UMWAIT：
- TPAUSE 可以等待到指定 TSC 时钟。
- UMONITOR 可以监视地址写入，然后用 UMWAIT 等待。
- 不过似乎只有 Clang 支持，MSVC 不支持？

[Introduction to umonitor/umwait/tpause instructions - L](https://liujunming.top/2022/03/01/Introduction-to-umonitor-umwait-tpause-instructions/)

[Using UMONITOR, UMWAIT, TPAUSE in CLR and exposing in Intel specific hardware intrinsics · Issue #66873 · dotnet/runtime](https://github.com/dotnet/runtime/issues/66873)