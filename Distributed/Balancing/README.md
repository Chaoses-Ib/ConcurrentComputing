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
Compoments:[^kumarVariousDynamicLoad2015]
- Transfer policy: In this policy it is responsible to determine when a task should be transferred from one node to the other node.
- Selection policy: In this policy it focuses on choosing the processor for load transfer so that the overall response time and throughput may be improved.
- Location policy: In this policy it determines the availability of essential resources for providing services and makes a selection based on location of resources.
- Information policy: In this policy it acquires workload related information about the system such as nature of workload and the average load on each node.
- Load estimation policy: In this policy it determines the total workload of a node in a system.

Algorithms:
- Work stealing

### Libraries
Rust:
- [mrinalxdev/Rust-load: Complex and high performing load balancer in rust](https://github.com/mrinalxdev/Rust-load/)

## Dynamic servers
What if not only the workload, but also the (number of) servers are dynamic and adjustable?

Obviously, when the workload is heavy, there should be more servers.

Algorithm:
- Naive: spawn a dedicated server for every job.
  - High cost
  - High cold start cost
    - Pre-spwaning
- Naive with total limit
  - When reaching limit, it turns into tranditional load balancing.
  - High cold start cost before reacing limit
  - May lead to very high load when the limit is small compared to jobs
- Random spawn (naive with ratio)
  - May lead to high load even when jobs are few
- Round-robin spawn: every $n$ jobs spwan a server
- Server retention: keep server available for a moment, if no job comes in, shutdown.
  - Put more load on a started server to avoid cold start cost.
  - High load at peak times and low load at trough times

Applications:
- Serverless


[^mitzenmacherPowerTwoRandom2001]: Mitzenmacher, M., Richa, A. W., & Sitaraman, R. (2001). The Power of Two Random Choices: A Survey of Techniques and Results. In S. Rajasekaran, P. M. Pardalos, J. H. Reif, & J. Rolim (Eds.), Handbook of Randomized Computing (Vol. 9, pp. 255–312). Springer US. https://doi.org/10.1007/978-1-4615-0013-1_9
[^kumarVariousDynamicLoad2015]: Kumar, S., & Singh, D. (2015). Various Dynamic Load Balancing Algorithms in Cloud Environment: A Survey. International Journal of Computer Applications, 129(6), 14–19. https://doi.org/10.5120/ijca2015906927
