# Loop Dependency
## Bornstein
In the process of executing each code, two variable sets of input and output are usually designed. For the $P_i$ code block operation, $I_i$ represents the input variable set and $O_i$ represents the output variable set.

The criterion that the two code blocks $P_1$ and $P_2$ can be executed in parallel can be expressed as:
- $I_1 \cap O_2 = \emptyset$
- $I_2 \cap O_1 = \emptyset$
- $O_1 \cap O_2 = \emptyset$

Let $P_1$ be the code block currently executed, $P_2$ be the code block to be executed subsequently.

P1\\P2 | Read | Write
--- | --- | ---
Read | Read before read: No dependency | Read before write: Anti dependency <br /> $I_1\cap O_2\ne\emptyset$
Write | Write before read: Stream dependency<br />$I_2\cap O_1\ne\emptyset$ | Write first and then write: Output dependency <br /> $O_1\cap O_2\ne\emptyset$

## Dependency elimination
- Stream denpendency: Partial, by reconstruction methods
- Ant-denpendency: By a temporary array
- Output dependency: By temporary variables
