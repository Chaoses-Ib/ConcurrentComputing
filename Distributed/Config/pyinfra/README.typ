#import "@local/ib:0.1.0": *
#title[#a[pyinfra][https://pyinfra.com/]]
#a-badge[https://github.com/pyinfra-dev/pyinfra]

- #a[Getting Started][https://docs.pyinfra.com/en/3.x/getting-started.html]
  - ```sh uv tool install pyinfra```
- #a[Compatibility][https://docs.pyinfra.com/en/3.x/compatibility.html]
  - Windows: #a[pyinfra-dev/pyinfra-windows: Windows connector, facts & operations for pyinfra.][https://github.com/pyinfra-dev/pyinfra-windows]
- #a[Performance][https://docs.pyinfra.com/en/3.x/performance.html]

#a[Infrastructure as code with pyinfra - cusy][https://cusy.io/en/blog/infrastruktur-als-code-mit-pyinfra.html]

#q(block: true)[
At a previous job we used it to test our ansible playbooks via molecule, which were part of a CI/CD pipeline to create AWS AMIs.
It worked well and was nicer to deal with than test kitchen for testing UNIXy things (is service running and/or enabled, does file have right permissions, does file include \$TEXT, etc).
It was very useful for us during big linux upgrades, such as when ubuntu went from upstart to systemd.
It can also be good at capturing edge cases with brittle outcomes (especially as ansible went through enormous changes after the red hat acquisition).
]
#q(block: true)[
On "importing Python libraries introduces bugs". This one I think is worth a closer look, because the mechanics are not what they appear.
PyInfra does not run Python on your servers. It runs Python on your control node to plan the change, then transpiles each operation to plain POSIX shell and pipes that over SSH.
If you run with `-vvv` you can see it: `sh -c '...'` and nothing else on the wire.
The target needs zero Python, zero agent, zero runtime.
So whatever library you imported into your deploy script ran locally, produced a string of shell, and that string is what touches the box.
A bug in some PyPI dependency cannot throw mid-operation on the host, because there is no Python on the host to throw it.
Worth noting that Ansible, by contrast, ships a Python interpreter and module code to the target for most tasks, so if anything the library exposure on the executing side is larger there, not smaller.
]
#q[
Thank you for this. I've implemented my own version of this a couple times over the previous 25 years. This is how my code always looked.

I've used Salt, CFEngine, Chef, Puppet, Make, Bash, and many hand-rolled iterations of this approach. I finally threw in the towel and forced myself to come to terms with Ansible and it's quirks because I needed the wider community support.

Now with AI tooling, I'm not so convinced the community modules moat is an actual moat. I'm going to very seriously consider porting all my Ansible code to this and see how it feels. I anticipate I'll be much happier after the change.
]
#footnote[#a[PyInfra 3.8.0 | Hacker News][https://news.ycombinator.com/item?id=48008083]]

#q[
I was using ansible for my homelab. It was getting really frustrating. It was bad... and everything is like a hack... The yaml config is horrible.... And the speed... it was just sad. Also, why do I need `python3` on my server to run a bunch of shell commands. (I know, I know, ansible creates a python bundle, uploads it over ssh into a temporary directory, and execute it on the server with python. But seriously, why?!?)

I discovered `pyinfra` thanks to Google AI Mode (not an ad for my employer, I speak for myself). Finally, it was a breeze of fresh air! I've only been using for almost a month, so take everything I say with a grain of salt, and I didn't explore everything.

*The good*
- The speed: it's not blazing fast, but much much faster than ansible. (My ideal configuration management would use a dependency tree and parallelize everything including ssh commands, no agent needed)
- The custom logic: you can write logic in python, this is amazing for looping and conditions
- The minimalism: no roles and nested subdirectory, you only need a shell on the server, no need to install `python` or `python-apt` on your orchestrated machine.
- The planning: it will generate a plan based on the current state before executing, and if you don't pass `-y` it will ask you "you want to run this?"

*The bad*
- The default operations are a tiny subset of ansible's module (pyinfra operations = ansible modules)
- The code can quickly and up a little bit spaghetti-y
- `if 'web_server' in hosts.groups` is not great, but I feel that `operation(..., filter_group='web_server')` might be worse. I don't know what would be better here...

*The ugly*
- Writing custom connectors suuuuuuuuuuck... This is really bad. Unless I missed something (I tried to figure it out for ~1h and then I had to read pyinfra's source code), custom connectors must be `pyproject.toml` with `pyinfra` specific entry-points. It's a nightmare to develop home grown connectors, even with `uv`... Who came up with this?! Make custom connectors a regular python file in your project, dammit!
]
#q[
I really like pyinfra and I wish it had more traction.

So far, all the companies I worked with use Ansible (with or without Terraform), and not a single one was ready to rewrite all of their automation with something else that their employees have no experience with.

pyinfra also requires the SysOps to know Python. While in my mind it should be mandatory for a SysOps to know some scripting language (especially with Ansible, Python can be used to write modules and reduce the amount of YAML mess), it's not a very common point of view, at least in France.
]
#footnote[#a[pyinfra --- agentless infrastructure automation, in plain Python | Lobsters][https://lobste.rs/s/htfm3p/pyinfra_agentless_infrastructure]]

#q[
I've been using it as well with great success.

A couple years ago I inherited about 100 Mac Pros that are part of \$dayjob's CI infrastructure. They had been managed over the years using a combination of shell scripts, Chef, and manually via VNC. No two machines were alike. The Chef recipes had all bit-rotted and weren't usable and due to \$reasons were based on an old version of Chef that \$company was stuck on.

So I looked around for alternatives, and being most comfortable in Python, I explored Ansible, Salt, and Pyinfra.

Ansible seemed like the obvious choice, but it has very few playbooks/actions for macOS systems. I was going to have to write my own. As I dug into its documentation, I found it was taking me a long time to wrap my head around all that I needed to do and started to sour on its complexity. This is a matter of taste, but I just didn't find Ansible very welcoming. I wanted something simpler.

I had previously used Fabric, so considered using it again. But Fabric offers too little (it's really not much more than parallel ssh-if you want idempotent operations you have to write that yourself), and I don't agree with the direction it took with version 2.x.

Then I found Pyinfra. It took me less than 30 minutes to understand it in its entirety. It's conceptually simple: you have an inventory of machines that it connects to in parallel over ssh. You provide it with a deploy script that combines facts and operations. Pyinfra uses the deploy script to gather facts about each machine, then you use those facts to decide whether you need to perform any operations. It then performs those operations on each machine as needed. The inventory file, deploy script, facts, and operations are trivial to write for someone comfortable with Python. It's all Python with the facts and operations being decorated functions. There is no DSL to learn. (It comes with a bunch of pre-written facts and operations, but they are mostly for Linux systems. I had to mostly wrote my own for macOS, but I found them really easy to write.)

I had it operational the same day I found it. I used it to successfully get all of the Mac Pros into consistent state: things like system settings, installing Xcode, automating installs of brew packages all at the same version, installing JVMs, updating and upgrading macOS, installing Sentinel One, etc.

I've been very happy with it, even contributing a few PRs to fix small bugs and contribute minor functionality.
]
#footnote[#a[Pyinfra: Automate Infrastructure Using Python | Hacker News][https://news.ycombinator.com/item?id=40211655]]

#q[
Yep, all of the above. Some folks are familiar with Python, yaml is instructional “code” to be parsed and processes by a system (Ansible).

Another big reason is adoption and embedding.. you’ve many large organizations with plugins, playbooks, etc that are already being used to do tons of infrastructure configuration.

Ansible integration to other systems as well.. an auditing system, RBAC, webhooks, etc. Some of that would need to be built on top of anything else.
]
#footnote[#a[Opinion on using pyinfra : r/Python][https://www.reddit.com/r/Python/comments/1phgso7/]]

= #a[Using Operations][https://docs.pyinfra.com/en/3.x/using-operations.html]
- #a[Operations][https://docs.pyinfra.com/en/3.x/operations.html]
- #a[Facts][https://docs.pyinfra.com/en/3.x/facts.html]

= #a[Inventory & Data][https://docs.pyinfra.com/en/3.x/inventory-data.html]

= #a[Connectors][https://docs.pyinfra.com/en/3.x/connectors.html]
- SSH
  - Based on Paramiko, which is also used by Fabric and Ansible.
    #footnote[#a[`InformationSecurity/Access Control/SSH/README.md` - Chaoses-Ib/InformationSecurity][https://github.com/Chaoses-Ib/InformationSecurity/blob/646c1e13e1ffc11cbd62c652d1d7646a0f500aa7/Access%20Control/SSH/README.md#implementations]]
