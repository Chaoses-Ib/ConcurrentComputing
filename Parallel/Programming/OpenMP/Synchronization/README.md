# Synchronization Constructs and Clauses
## `critical` Construct
```c++
#pargma omp parallel for
for (int i = 0; i < 10; i++)
{
	#pargma omp critical
	sum += i;
}
```
The region that corresponds to a `critical` construct of a given name is executed as if only a single thread at a time among all threads in the contention group executes the region, without regard to the teams to which the threads belong.


## Barriers
### `barrier` Construct
```c++
#pargma omp barrier
```
 The `barrier` construct speciﬁes an explicit barrier at the point at which the construct appears. Unless the binding region is canceled, all threads of the team that executes that binding region must enter the `barrier` region and complete execution of all explicit tasks bound to that binding region before any of the threads continue execution beyond the barrier.

### Implicit Barriers
Constructs that have an implicit barrier:
- `parallel`
- `for`
- `sections`
- `critical`
- `single`

`master` 没有 implicit barrier。


## `nowait` Clause
The `nowait` clause overrides any synchronization that would otherwise occur at the end of a construct.


## Memory Ordering
### `atomic` Clauses
```c++
#pargma omp parallel for
for (int i = 0; i < 10; i++)
{
	#pargma omp atomic
	sum += i;
}
```


## `ordered` Construct
### Stand-alone `ordered` Construct
The stand-alone `ordered` construct speciﬁes that execution must not violate cross-iteration dependences as speciﬁed in the `doacross` clauses that appear on the construct.

### Block-associated `ordered` Construct
```c++
#pargma omp for ordered
for (int i = 0; i < 10; i++)
{
	#pargma omp ordered
	{
		printf("%d, %d", i, a[i]);
		// 1, ...
		// 2, ...
		// ...
	}
}
```
When the thread that is executing the ﬁrst iteration of the loop encounters an `ordered` construct, it can enter the `ordered` region without waiting. When a thread that is executing any subsequent iteration encounters a block-associated `ordered` construct, it waits at the beginning of the `ordered` region until execution of all `ordered` regions that belong to all previous iterations has completed. `ordered` regions that bind to diﬀerent regions execute independently of each other.