# Async/await
[Wikipedia](https://en.wikipedia.org/wiki/Async/await)

The **async/await pattern** is a syntactic feature of many programming languages that allows an asynchronous, non-blocking function to be structured in a way similar to an ordinary synchronous function. It is semantically related to the concept of a coroutine and is often implemented using similar techniques, and is primarily intended to provide opportunities for the program to execute other code while waiting for a long-running, asynchronous task to complete, usually represented by promises or similar data structures.

A significant benefit of the async/await pattern in languages that support it is that asynchronous, non-blocking code can be written, with minimal overhead, and looking almost like traditional synchronous, blocking code. In particular, it has been argued that await is the best way of writing asynchronous code in message-passing programs; in particular, being close to blocking code, readability and the minimal amount of boilerplate code were cited as await benefits. As a result, async/await makes it easier for most programmers to reason about their programs, and await tends to promote better, more robust non-blocking code in applications that require it. Such applications range from programs presenting graphical user interfaces to massively scalable stateful server-side programs, such as games and financial applications.

When criticising await, it has been noted that await tends to cause surrounding code to be asynchronous too; on the other hand, it has been argued that this contagious nature of the code (sometimes being compared to a "zombie virus") is inherent to all kinds of asynchronous programming, so await as such is not unique in this regard.

Supported languages:
- 2007 F# 2.0
- 2012 C# 5
- 2012 Haskell
- 2015 Python 3.5
- 2015 TypeScript 1.7
- 2017 ECMAScript 2017
- 2017 Kotlin 1.1
- 2019 Rust 1.39
- 2020 C++ 20
- 2021 Swift 5.5
