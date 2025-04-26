# Load Balancing
[Wikipedia](https://en.wikipedia.org/wiki/Load_balancing_(computing))

> Load balancing is the subject of research in the field of parallel computers. Two main approaches exist: static algorithms, which do not take into account the state of the different machines, and dynamic algorithms, which are usually more general and more efficient but require exchanges of information between the different computing units, at the risk of a loss of efficiency.

[Types of load balancing algorithms | Cloudflare](https://www.cloudflare.com/learning/performance/types-of-load-balancing-algorithms/)

## Static algorithms
Or load balancing with limited information.

> Ideally, when a task arrives requesting a server, we would like to assign it to the least loaded server. However, complete information about the loads of all the servers may be expensive to obtain.[^mitzenmacherPowerTwoRandom2001]

- Round-robin
- Random
- Less work
- Hash
- Power of two choices

  > pick two servers at random and choose the better of the two options.

  > An alternative approach that requires no information about the server loads is to simply allocate each task to a random server. If there are $n$ tasks and $n$ servers, using the balls-and-bins analogy, some server is assigned $\Theta(\log n/ \log \log n)$ tasks with high probability. If instead each task obtains limited information by querying the load of two servers chosen independently and uniformly at random, and allocates itself to the least loaded of these two servers, then the maximum load on the $n$ servers is only $\Theta(\log \log n)$ with high probability.[^mitzenmacherPowerTwoRandom2001]

  For $b=2$, $\log \log n$ is smaller than $\log n/ \log \log n$ when $16<n<65536$.

> The advantage of static algorithms is that they are easy to set up and extremely efficient in the case of fairly regular tasks (such as processing HTTP requests from a website). However, there is still some statistical variance in the assignment of tasks which can lead to the overloading of some computing units.

### Libraries
Rust:
- [tower::balance - Rust](https://docs.rs/tower/latest/tower/balance/)

## Dynamic algorithms
- Work stealing

### Libraries
Rust:
- [mrinalxdev/Rust-load: Complex and high performing load balancer in rust](https://github.com/mrinalxdev/Rust-load/)


[^mitzenmacherPowerTwoRandom2001]: Mitzenmacher, M., Richa, A. W., & Sitaraman, R. (2001). The Power of Two Random Choices: A Survey of Techniques and Results. In S. Rajasekaran, P. M. Pardalos, J. H. Reif, & J. Rolim (Eds.), Handbook of Randomized Computing (Vol. 9, pp. 255–312). Springer US. https://doi.org/10.1007/978-1-4615-0013-1_9
