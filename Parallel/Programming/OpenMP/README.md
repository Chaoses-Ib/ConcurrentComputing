# [OpenMP](https://www.openmp.org/)
**OpenMP (Open Multi-Processing)** is an API that supports multi-platform *shared-memory multiprocessing* programming in C, C++, and Fortran, on many platforms, instruction-set architectures and operating systems, including Solaris, AIX, FreeBSD, HP-UX, Linux, macOS, and Windows.[^wiki]

[Specifications](https://www.openmp.org/specifications/)

The directives, library routines, environment variables, and tool support allow users to create, to manage, to debug and to analyze parallel programs while permitting portability.
- The directives extend the C, C++ and Fortran base languages with SPMD constructs, tasking constructs, device constructs, work-distribution constructs, and synchronization constructs, and they provide support for sharing, mapping and privatizing data.
- The functionality to control the runtime environment is provided by library routines and environment variables.
- Compilers that support the OpenMP API often include command line options to enable or to disable interpretation of some or all OpenMP directives.

## Implementations
Compiler | OpenMP
--- | ---
MSVC | OpenMP 2.0
GCC 4.3.1 | OpenMP 3.0
ICC 11.0 |
GCC 4.7 | OpenMP 3.1
Clang 3.7 |
ICC 12.1 |
GCC 4.9.0 | OpenMP 4.0
ICC 15.0 |
GCC 6 | OpenMP 4.5
ICC 17.0 |
GCC 9 | OpenMP 5.0
Clang 12 |
ICC 19.1 |

### MSVC
[OpenMP in Visual C++ | Microsoft Docs](https://docs.microsoft.com/en-us/cpp/parallel/openmp/openmp-in-visual-cpp?view=msvc-160)
- OpenMP 2.0

[Examples | Microsoft Docs](https://docs.microsoft.com/en-us/cpp/parallel/openmp/a-examples?view=msvc-160)
[/openmp (Enable OpenMP Support) | Microsoft Docs](https://docs.microsoft.com/en-us/cpp/build/reference/openmp-enable-openmp-2-0-support?view=msvc-160)

- [ ] 能用来反逆向吗？

## 浮点数求和误差问题
[Different math results in openMP depended on number of processes - Intel Community](https://community.intel.com/t5/Intel-oneAPI-HPC-Toolkit/Different-math-results-in-openMP-depended-on-number-of-processes/td-p/858929)
- 升序相加以降低误差？
- [ ] [What Every Computer Scientist Should Know About Floating-Point Arithmetic](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html)

[Reduction in Openmp returns different results with the same number of threads in my code - Stack Overflow](https://stackoverflow.com/questions/38113646/reduction-in-openmp-returns-different-results-with-the-same-number-of-threads-in)
- [Order of execution in Reduction Operation in OpenMP - Stack Overflow](https://stackoverflow.com/questions/16306440/order-of-execution-in-reduction-operation-in-openmp)


[^wiki]: [OpenMP - Wikipedia](https://en.wikipedia.org/wiki/OpenMP)