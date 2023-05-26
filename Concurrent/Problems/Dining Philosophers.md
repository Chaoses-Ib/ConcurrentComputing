# Dining Philosophers Problem
[Wikipedia](https://en.wikipedia.org/wiki/Dining_philosophers_problem)

![](https://upload.wikimedia.org/wikipedia/commons/7/7b/An_illustration_of_the_dining_philosophers_problem.png)

The basic setup for the problem is this: assume there are ﬁve “philosophers” sitting around a table. Between each pair of philosophers is a single fork (and thus, ﬁve total). The philosophers each have times where they think, and don’t need any forks, and times where they eat. In order to eat, a philosopher needs two forks, both the one on their left and the one on their right. The contention for these forks, and the synchronization problems that ensue, are what makes this a problem we study in concurrent programming.[^three]

Here is the basic loop of each philosopher:
```c
while (1) {
    think();
    getforks();
    eat();
    putforks();
}

int left(int p) { return p; }
int right(int p) { return (p + 1) % 5; }
```

Using semaphores:
```c
sem_t forks[5];

void getforks() {
    sem_wait(forks[left(p)]);
    sem_wait(forks[right(p)]);
}

void putforks() {
    sem_post(forks[left(p)]);
    sem_post(forks[right(p)]);
}
```

The problem is deadlock. If each philosopher happens to grab the fork on their left before any philosopher can grab the fork on their right, each will be stuck holding one fork and waiting for another, forever.

The simplest way to attack this problem is to change how forks are acquired by at least one of the philosophers; indeed, this is how Dijkstra himself solved the problem. Speciﬁcally, let’s assume that philosopher 4 (the highest numbered one) acquires the forks in a different order. The
code to do so is as follows:[^three]

```c
void getforks() {
    if (p == 4) {
        sem_wait(forks[right(p)]);
        sem_wait(forks[left(p)]);
    } else {
        sem_wait(forks[left(p)]);
        sem_wait(forks[right(p)]);
    }
}
```


[^three]: Operating Systems: Three Easy Pieces