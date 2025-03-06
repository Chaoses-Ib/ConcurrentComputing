# Aliasing
[Aliasing](https://en.wikipedia.org/wiki/Aliasing_(computing))

## Linux
> The Linux kernel uses for instance `-fno-strict-aliasing` (basically type-compatibility-no-aliasing) from GCC, which some people have argued is a language variant of C (some in favor of having the option, some against it, and some would have preferred the option to be mandatory)

> The Linux kernel is trucking along just fine while ignoring the strict aliasing rule.

> Not only is linux losing out on a good bit of performance in CPU bound scenarios, the present aliasing violations have also been a **huge** pain when the kernel sanitizers, LTO, and CFI were added.

> I haven't written Linux kernel drivers, but there are accessor functions that one must use when accessing user mode memory: https://elixir.bootlin.com/linux/v6.12.6/source/include/linux/uaccess.h#L205

## Windows
[BlueHat 2024: S09: Pointer Problems -- Why We're Refactoring the Windows Kernel](https://www.youtube.com/watch?v=-3jxVIFGuQw) ([r/cpp](https://www.reddit.com/r/cpp/comments/1i7y4ru/bluehat_2024_pointer_problems_why_were/))
> win 为了避免编译器优化导致 probe 被绕过，给 msvc 专门加了个 `/kernel` 选项直接把相关优化关了。后面还准备加读用户内存的专用函数，强制所有驱动用。

- Double-fetches

  Other threads may change the memory after validation but before use. (TOCTOU)

  > 检测后复制到本地再访问没问题，但是如果编译器优化成从源地址访问，就有可能被其它线程修改，导致实际上不可读，出错  
  > 这样的代码点在win里有10000个

  10,000 spots in Windows

  What after changes in the middle of copying?
  > 他主要说的是指针 用户指针可能会被替换成内核指针
  - SEH
  
    > Drivers must call **ProbeForRead** inside a **try/except** block. If the routine raises an exception, the driver should complete the IRP with the appropriate error. Note that subsequent accesses by the driver to the user-mode buffer must also be encapsulated within a **try/except** block: a malicious application could have another thread deleting, substituting, or changing the protection of user address ranges at any time (even after or during a call to **ProbeForRead** or **ProbeForWrite**).
  - User-mode accessors?

- Disable optimization: MSVC `/kernel`
- No-optimization hint: `RtlCopyVolatileMemory()`
- SEH
- KASAN
- Kernel Concurrency Sanitizer (KCSAN)
- User-mode accessors

  `ProbeForRead`/`Write` + `RtlCopyVolatileMemory`?

  Open the door for SMAP and PAN (ARM).

  Requires drivers to change.
- Lock-less programming
- Borrow checker

  Only works with trusted input.
- Unaligned accesses

  Windows 11 24H2: A new `memcpy` that forces unaligned accesses when size greater than 2

  [RtlCopyDeviceMemory (wdm.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/nf-wdm-rtlcopydevicememory)

API:
- [ProbeForRead (wdm.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/nf-wdm-probeforread)
- [MmProbeAndLockPages (wdm.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/nf-wdm-mmprobeandlockpages)
- [RtlCopyVolatileMemory (wdm.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/nf-wdm-rtlcopyvolatilememory)

  > The **RtlCopyVolatileMemory** function has the following properties:
  > - The function isn't recognized as a compiler intrinsic so the compiler will never optimize away the call (either entirely or replace the call with an equivalent sequence of instructions). This differs from **RtlCopyMemory** which is subject to various compiler optimizations.
  > - When the call returns, the data has been copied from *Source* to *Destination*. This functions memory accesses to the *Source* and *Destination* will only be performed within the function (for example, the compiler can't move memory accesses out of this function).
  > - The function may perform unaligned memory accesses if the platform allows for it.
  > - The function may access memory locations more than once as part of its copy operation.
  > - It's similar to **RtlCopyMemory** in that it doesn't support copy operations when *Source* and *Destination* overlap each other.

Non volatile tokens:
- Windows Consumer (1703+) only
- [RtlWriteNonVolatileMemory (ntddk.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntddk/nf-ntddk-rtlwritenonvolatilememory)
- [RtlGetNonVolatileToken (ntddk.h)](https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntddk/nf-ntddk-rtlgetnonvolatiletoken)
