# Work-Distribution Constructs
## `single` Construct
```c++
#pragma omp single
{
	//...
}
```
The `single` construct speciﬁes that the associated structured block is executed by only one of the threads in the team (not necessarily the primary thread), in the context of its implicit task.

An implicit barrier occurs at the end of a `single` region if the `nowait` clause is not speciﬁed.

## `sections` Construct
```c++
#pragma omp sections
{
	#pragma omp section
	{
		//...
	}
	#pargma omp section
	{
		//...
	}
}
```
The `sections` construct is a non-iterative worksharing construct that contains a structured block that consists of a set of structured block sequences that are to be distributed among and executed by the threads in a team. Each structured block sequence is executed by one of the threads in the team in the context of its implicit task.

An implicit barrier occurs at the end of a sectionsregion if the `nowait` clause is not speciﬁed.
