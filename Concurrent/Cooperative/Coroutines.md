# Coroutines
[Wikipedia](https://en.wikipedia.org/wiki/Coroutine)

## Stackfulness
There are two flavors of coroutines - stackful, and stackles[^stack-hacksoflife]:
- Fibers are stackful coroutines - the whole stack is saved to suspend the routine, allowing us to suspend at any point in execution anywhere.
- C++20 coroutines are stackless, which means you can only suspend inside a coroutine itself - suspension depends on the compiler transforms of the coroutine (into a state machine object) to achieve the suspend.

In contrast to a stackless coroutine *a stackful coroutine can be suspended from within a nested stackframe*. Execution resumes at exactly the same point in the code where it was suspended before. With a stackless coroutine, only the top-level routine may be suspended. Any routine called by that top-level routine may not itself suspend. This prohibits providing suspend/resume operations in routines within a general-purpose library.[^stack-boost]

The real difference is not nesting, but the fact that stackful coroutines manage a growable stack dynamically at runtime, while stackless coroutines pass the job on to the compiler to evaluate all possible nesting permutations, and create an optimally memory-efficient stack machine that represents the coroutine.[^stack-hacker]

Languages with stackless coroutines:
- C++
- C#
- JavaScript
- Python
- Rust

  [I'm somewhat disappointed that rust is going with async style stackless continua... | Hacker News](https://news.ycombinator.com/item?id=17537242)
- Swift

  [Why stackless (async/await) for Swift? - Evolution / Discussion - Swift Forums](https://forums.swift.org/t/why-stackless-async-await-for-swift/52785)

Languages with stackful coroutines:
- Erlang
- Go
- Lua
- Scheme

[Calling the stackful coroutine model as offered by Go superior to stackless coro... | Hacker News](https://news.ycombinator.com/item?id=24361590)

[The Hacks of Life: We Never Needed Stackfull Coroutines](http://hacksoflife.blogspot.com/2021/06/we-never-needed-stackfull-coroutines.html)

[There's something truly perverse about the way languages are recapitulating the ... | Hacker News](https://news.ycombinator.com/item?id=16318535)

## Generators
[Wikipedia](https://en.wikipedia.org/wiki/Generator_(computer_programming))


[^stack-hacksoflife]: [The Hacks of Life: We Never Needed Stackfull Coroutines](http://hacksoflife.blogspot.com/2021/06/we-never-needed-stackfull-coroutines.html)
[^stack-boost]: [Introduction - 1.57.0](https://www.boost.org/doc/libs/1_57_0/libs/coroutine/doc/html/coroutine/intro.html#coroutine.intro.stackfulness)
[^stack-hacker]: [Calling the stackful coroutine model as offered by Go superior to stackless coro... | Hacker News](https://news.ycombinator.com/item?id=24361590)