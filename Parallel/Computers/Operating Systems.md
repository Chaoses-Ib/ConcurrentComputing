# Supercomputer Operating Systems
While early operating systems were custom tailored to each supercomputer to gain speed, the trend has been moving away from in-house operating systems and toward some form of Linux, with it running all the supercomputers on the TOP500 list in November 2017. In 2021, top 10 computers run for instance RHEL, or some variant of it or other Linux distribution e.g. Ubuntu.

Given that modern massively parallel supercomputers typically separate computations from other services by using multiple types of nodes, they usually run different operating systems on different nodes, e.g., using a small and efficient lightweight kernel such as [Compute Node Kernel](https://en.wikipedia.org/wiki/CNK_operating_system "CNK operating system") (CNK) or [Compute Node Linux](https://en.wikipedia.org/wiki/Compute_Node_Linux "Compute Node Linux") (CNL) on compute nodes, but a larger system such as a Linux-derivative on server and I/O nodes.[^wiki]


[^wiki]: [Supercomputer operating system - Wikipedia](https://en.wikipedia.org/wiki/Supercomputer_operating_system)