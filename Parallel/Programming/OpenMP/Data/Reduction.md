# Reduction Clauses and Directives
## Reduction Identifiers
A reduction identiﬁer is either an id-expression or one of the following operators: `+, -(deprecated), *, &, |, ^, &&, ||`.

## Reduction Expression
A *reduction expression* is an OpenMP stylized expression that is relevant to reduction clauses. It is either a *combiner expression* or an *initializer expression*.

## `reduction` Clause
`reduction(operator: variable list)`
```c++
double get_pi(int num_steps) {
   int i;
   double x, pi, sum = 0.0, step;

   step = 1.0 / (double) num_steps;

   #pragma omp parallel for reduction(+:sum) private(x)
   for (i = 1; i <= num_steps; i++) {
      x = (i - 0.5) * step;
      sum += 4.0 / (1.0 + x*x);
   }

   pi = step * sum;
   return pi;
}
```