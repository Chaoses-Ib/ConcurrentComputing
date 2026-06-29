#import "@local/ib:0.1.0": *
#title[#a[Ansible][https://www.ansible.com]]
#a-badge[https://en.wikipedia.org/wiki/Ansible_(software)]
#a-badge[https://github.com/ansible/ansible]

#q[
Ansible is a suite of software tools that enables infrastructure as code.
It is open-source and the suite includes software provisioning, configuration management, and application deployment functionality.
]

Design principles:
#q[
- Have an extremely simple setup process with a minimal learning curve.
- Manage machines quickly and in parallel.
- Avoid custom-agents and additional open ports, be agentless by
  leveraging the existing SSH daemon.
- Describe infrastructure in a language that is both machine and human
  friendly.
- Focus on security and easy auditability/review/rewriting of content.
- Manage new remote machines instantly, without bootstrapping any
  software.
- Allow module development in any dynamic language, not just Python.
- Be usable as non-root.
- Be the easiest IT automation system to use, ever.
]

Problems:
#footnote[#a[More modern alternative to Ansible : r/devops][https://www.reddit.com/r/devops/comments/17ayinx/more_modern_alternative_to_ansible/]]
- System drift
  - NixOS
    #footnote[#a[Ansible, NixOS or other automation tools : r/selfhosted][https://www.reddit.com/r/selfhosted/comments/1rkyj1s/ansible_nixos_or_other_automation_tools/]]
    #footnote[#a[Ansible is better than Nixos : r/NixOS][https://www.reddit.com/r/NixOS/comments/1cxket5/ansible_is_better_than_nixos/]]

    #a[Nix all the things (part 1): Ansible \//][https://illustris.tech/posts/nix-all-the-things-pt1/]

  #q[
  Tbh, having used VMs, containers, k8s, and various things like ansible to manage my machines over a long period of time... All of them _suck_.

  They all have real problems _over time_ that arent apparent when setting out using them. Most specifically in my experience around the underlying OS changing unexpectedly in areas not managed by them (someone changing a config by hand), being PAINS for removing things no longer needed (try removing systemd timers with ansible by just removing the entry from the variable you used to generate them!) and so on and so forth leading to this horrible mess of a system that both is and isnt managed and may or may not be the same as others that should be identical.

  You also frequently end up with this odd... drift, from the baseline OS installs and with TONS of legacy cruft without way more discipline than if you managed each server manually and by hand due to the cleanup requiring insane workarounds in the systems or discipline to go in and manually remove things despite so much of your stuff being geared around automated remote configs (aka, cleanup isnt a happy path and is MUCH harder to execute so often isnt). This drift makes tons of problems, makes different servers behave oddly even if they should be identical, etc and ruins the promise of these tools unless you are constantly deleting and rebuilding servers for funsies.

  Unless you can fix these sorts of long term pain points so we dont need to constantly worry about drift and rebuild entire OSes from scratch constantly, I'd say nothing you do will ever replace Ansible and the other tooling we got already. The people using it are fine with constant rebuilds for no apparent reason or even make it vital via cloud scaling. Others could use something that handles system lifetimes way better, and they will want an alternative really.

  Only thing remotely close Ive seen is Nix and NixOS (and imo, they also nail it even if they also go overboard with the whole /nix store and such), as this way even the OS cant drift unexpectedly on you over time. It's also why I'm a huge proponent of it...

  If you want to know why I dont like containers and things like k8s too, I can mention those, but... While some of it is related to why VMs and Ansible suck, not all of it is.

  TL;DR: As a sysadmin professionally; Ansible feels like a tool made by someone that thinks they know what managing systems is like but they really dont (or that managing them is a thing you do once and never again), fix that and you might have an alternative that gets adoption but rust alone wont matter.
  ]
  #footnote[#a[What's blocking Rust from replacing Ansible-style automation? : r/rust][https://www.reddit.com/r/rust/comments/1l9sh7e/whats_blocking_rust_from_replacing_ansiblestyle/]]

- Not really fast.
  #footnote[#a[What's blocking Rust from replacing Ansible-style automation? : r/rust][https://www.reddit.com/r/rust/comments/1l9sh7e/whats_blocking_rust_from_replacing_ansiblestyle/]]
  #footnote[#a[Why are there no decent Go or Rust alternatives to Ansible? | Hacker News][https://news.ycombinator.com/item?id=30191153]]

  #q[ansible 主要问题是太太太慢了，我都搞不明白 Python 怎么能那么慢，五台服务器每次启动任务都要先等个 10 分钟，每个任务执行前后都要卡个四五秒，也不知道在初始化什么东西……
  网络连接肯定没问题的，ssh 也是秒连，服务器本身性能肯定足够
  
  后来换 pyinfra 了，体验还可以]
  #q[上规模了，100 台以上就太慢了， 等不了。
  还是 saltstack 比较快， 已经开始转 saltstack 了。]
  #footnote[#a[Ansible 用起来好爽😄 - V2EX][https://www.v2ex.com/t/1154933]]

  - #a[Mitogen for Ansible][https://mitogen.networkgenomics.com/ansible_detailed.html]
  - pyinfra

- YAML
  - Doesn't reuse CLI and sh scripts directly.
  - Coupled with Jinja.
  - Learning curve

  #q[My main gripe with Ansible is the YAML specification.
  Ansible chooses to separate the task specification and task execution.
  Pyinfra chooses to directly expose the Python layer, instead of using slightly ugly magic functions/variables.
  I like this approach more since it allows standard Pythonic control flow instead of using a new (arguably ugly and more hassle to maintain) grammar.
  ] \
  #q[The issue is, Ansible was written for sysadmins who aren't programmers.
  There is no good explanation, other than it's a historically grown, syntactic and semantic mess that should've been barebones python from the get go.]
  #footnote[#a[Pyinfra: Automate Infrastructure Using Python | Hacker News][https://news.ycombinator.com/item?id=40211655]]

  - pyinfra

- Most modules require Python (or PowerShell) on the managed node.
  - #q[Ansible literally copies over a zip of .py files to `~/.ansible/` on the remote machine and executes those over ssh]
  - pyinfra

- The command node must be \*nix OS.
  - pyinfra

  #a[Matt on ... Whatever: Why no Ansible controller for Windows?][https://blog.rolpdog.com/2020/03/why-no-ansible-controller-for-windows.html]

- GPLv3

#a[使用 Ansible 管理 Linux 系统的配置文件 - 少数派][https://sspai.com/post/91932]

= Installation
#a[Installing Ansible --- Ansible Community Documentation][https://docs.ansible.com/projects/ansible/latest/installation_guide/intro_installation.html]

- uv:
  ```sh uv tool install --with-executables-from ansible-core,ansible-lint ansible```
  #footnote[#a[Tools | uv][https://docs.astral.sh/uv/concepts/tools/#including-additional-dependencies]]
- Windows: WSL  

= UI
Python:
- #a[Suitable: An Ansible API for humans.][https://github.com/seantis/suitable]

Web:
- #a[Semaphore UI: Modern UI and powerful API for Ansible, Terraform/OpenTofu/Terragrunt, PowerShell and other DevOps tools.][https://github.com/semaphoreui/semaphore]

  #a[使用 Ansible+Semaphore 来批量部署你的SSL证书 -- Bug次元][https://www.bug.cy/archives/94]
