# Transactional Memory
[Wikipedia](https://en.wikipedia.org/wiki/Software_transactional_memory)

**Transactional memory** is a concurrency control mechanism analogous to database transactions for controlling access to shared memory. A transaction in this context occurs when a piece of code executes a series of reads and writes to shared memory. These reads and writes logically occur at a single instant in time; intermediate states are not visible to other (successful) transactions.

**Software transactional memory (STM)** is a strategy implemented in software, rather than as a hardware component.

Unlike the locking techniques used in most modern multithreaded applications, STM is often very optimistic: a thread completes modifications to shared memory without regard for what other threads might be doing, recording every read and write that it is performing in a log. 

The benefit of this optimistic approach is increased concurrency: no thread needs to wait for access to a resource, and different threads can safely and simultaneously modify disjoint parts of a data structure that would normally be protected under the same lock.

However, in practice, STM systems also suffer a performance hit compared to fine-grained lock-based systems on small numbers of processors (1 to 4 depending on the application). This is due primarily to the overhead associated with maintaining the log and the time spent committing transactions. Even in this case performance is typically no worse than twice as slow. Advocates of STM believe this penalty is justified by the conceptual benefits of STM.

[whats wrong with software transactional memory? | Hacker News](https://news.ycombinator.com/item?id=15052170)

## Implementations
Languages:
- Haskell
- Clojure

C++:
- [cpp_stm_free: Composable monadic STM for C++ on Free monads](https://github.com/graninas/cpp_stm_free)
  
  [Software Transactional Memory in C++: Pure Functional Approach (tutorial)](https://gist.github.com/graninas/c7e0a603f3a22c7e85daa4599bf92525)

Rust:
- [rust-stm: Software transactional memory](https://github.com/Marthog/rust-stm)