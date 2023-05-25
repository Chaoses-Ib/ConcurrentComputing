# Performance Metrics
## Speedup
Denote by $T_s$ the time required to execute the entire task using a single processor, $T_p$ the time required for each processor to execute the subtask.

$$T_p=\frac{T_s}{p}$$

When all processor execute the subtasks simultaneously, $T_p$ is the time to execute the entire task.

The *speedup* of a parallel system can be defined as:

$$S=\frac{T_S}{T_P}=p$$

### Communication overhead
The *communication overhead*, $T_O$, the time it takes for processors to communicate and exchange data while executing subtaks, is overlooked. The speedup considering the communication overhead is:

$$S=\frac{T_S}{T_P}=\frac{T_S}{ \frac{T_S}{p}+T_O  } = \frac{p}{1+p\cdot \frac{T_O}{T_S}}$$

### Serial parts
Suppose a part of a given task $f_S$ must be executed serially, and the remaining part $f_P=1-f_S$ is divided into concurrent subtasks. The time to execute the task on $p$ processors is:

$$T_m=f_ST_S+(1-f_S)\frac{T_S}{p}$$

The speedup is:

$$S=\frac{T_S}{T_m}=\frac{T_S}{
f_ST_S+(1-f_S)\frac{T_S}{p}
}=\frac{p}{1+(p-1)f_S}$$

Amdahl's law:

$$\lim_{p\to\infty}S=\frac{1}{f_S}$$

### Communication overhead and serial parts

$$S=\frac{T_S}{T_m}=\frac{T_S}{
f_ST_S+(1-f_S)\frac{T_S}{p}+T_O
}
=\frac{p}{1+(p-1)f_S+p\cdot\frac{T_O}{T_S}}$$

$$\lim_{p\to\infty}S=\frac{1}{f_S+\frac{T_O}{T_S}}$$
- When $S=p$, it is a *linear speedup*, which is an ideal speedup.
- When $S<p$, it is the *true speedup ratio*.
- When $S>p$, it is a *superlinear speedup*.

## Parallel efficiency
Parallel efficiency represents the average execution efficiency/utilization of each processor when a parallel computer executes a parallel algorithm.

$$\xi=\frac{S}{p}=\frac{1}{1+(p-1)f_S+p\cdot\frac{T_O}{T_S}}$$
- When $\xi=1$, it is a *linear acceleration* ratio.
- When $\xi<1$, it is a *true case*.
- When $\xi<<1$, it is a *problematically inefficient* parallel algorithm.

## Speedup models
### Fixed load: Amdahl's law
Denote by $W$ the problem size, $W_S$ the serial component, $W_p$ the parallel component, $W_O$ the extra cost. $f_s=\frac{W_S}{W},f_P=1-f_S$ .

$$S=\frac{W_S+W_P}{W_S+\frac{W_P}{P}+W_O}
=\frac{W}{f_SW+\frac{W(1-f_S)}{p}+W_O}
=\frac{p}{1+(p-1)f_S+p\cdot\frac{W_O}{W}}$$

$$\lim_{p\to\infty}S=\frac{1}{f_S+\frac{W_O}{W}}$$

Unless the vast majority of the program is parallelized, high speedups cannot be achieved.

与上文的 speedup 表达式实际等同。

Amadahl's Law does not take in account the size of the problem. But for many problems, the proportion of serial parts of the program decreases as the problem size increases.

### Fixed Time: Gustafson's Law
$$S=\frac{W_S+pW_P}{W_S+p\frac{W_P}{P}+W_O}$$

Ignore $W_O$:

$$S=f_S+p(1-f_S)=p-f_S(p-1)$$

As the problem size increses, the serial load proportion decreases and is no longer the bottleneck of the problem.

### Memory-constrained: Sun-Ni Law
$$S=\frac{f_SW+(1-f_S)G(p)W}{f_SW+(1-f_S)G(p)\frac{W}{p}+W_O}$$

Ignore $W_O$:

$$S=\frac{f_S+(1-f_S)G(p)}{f_S+(1-f_S)\frac{G(P)}{p}}$$

- When $G(p)=1$, it is Amdahl's Law.
- When $G(p)=p$, it is Gustafson's Law.
- When $G(p)>p$, Sun-Ni speedup is higher than Amdahl and Gustafson corresponding to computer load increasing faster than storage requirement.

## Scalability
The scalability of a computer system is its ability to scale up in performance with an increase in the number of processors in a defined application context.
- A program is said to be *strongly scalable* if the constant efficiency can be maintained when increasing the number of processors without increasing the size of the problem.
- A program is said to be *weakly scalable* if increasing the number of processors, you can only increase the size of the problem at the same rate to keep the efficiency value unchanged.