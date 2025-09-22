# Virtualization
[Wikipedia](https://en.wikipedia.org/wiki/Virtualization)

> In computing, **virtualization** (abbreviated **v12n**) is a series of technologies that allows dividing of physical computing resources into a series of virtual machines, operating systems, processes or containers.
>
> The usual goal of virtualization is to centralize administrative tasks while improving scalability and overall hardware-resource utilization.

Virtualization is just resource-sharing like multitasking. But each instance only has minimum permissions by default, and the security/performance is often enforced/accelerated by hardware.

Another point of virtualization is reproducible environment. Although hiding differences cuts down power, it's fine for tasks don't (need or want to) utilize those differences.

## Objects
- [→Hardware sharing](https://github.com/Chaoses-Ib/ComputerHardware#virtualization)
  - [→Processor (CPU/GPU) sharing](https://github.com/Chaoses-Ib/Processors#virtualization)
  - Memory sharing
- OS sharing
- App (host) sharing
