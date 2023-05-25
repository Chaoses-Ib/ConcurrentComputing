# Parallel Algorithms
## PCAM
- Paritioning
	Break down into smaller tasks to exploit parallelism
	- Domain decomposition: data decomposition
	- Functional decomposition: decomposition of computing functions
- Communication
	Determine the data exchange between tasks, and evaluate the rationality of the partioning
	- Without communication → Embarrassingly parallel
	- With communication
	
	Communication visibility:
	- Explicit: message passing model
	- Transparent: shared memory model
- Agglomeration
	According to the locality of the task, combine fine tasks into larger tasks. Reduce communication costs by increasing the task granularity and repeating computation.
- Mapping
	Distribute each task to a processor, and improve the performance of the algorithm