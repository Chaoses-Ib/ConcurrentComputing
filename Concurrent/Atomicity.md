# Atomicity
[Wikipedia](https://en.wikipedia.org/wiki/Linearizability)

Primitive atomic instructions:
- Atomic read-write
- Atomic swap
  - x86: XCHG
- [Test-and-set](https://en.wikipedia.org/wiki/Test-and-set)
  - x86: BTS
- [Fetch-and-add](https://en.wikipedia.org/wiki/Fetch-and-add)
  - x86: XADD
- [Compare-and-swap](https://en.wikipedia.org/wiki/Compare-and-swap)
  - x86: CMPXCHG
- [Load-link/store-conditional](https://en.wikipedia.org/wiki/Load-link/store-conditional)

  Pseudocode[^three]:
  ```c
  int LoadLinked(int *ptr) {
      return *ptr;
  }

  int StoreConditional(int *ptr, int value) {
      if (no update to *ptr since LoadLinked to this address) {
          *ptr = value;
          return 1; // success!
      } else {
          return 0; // failed to update
      }
  }
  ```

  - ARM: LDREX/STREX (ARMv6~v7), LDXR/STXR (ARMv8)
  - RISC-V: LR/SC


[^three]: Operating Systems: Three Easy Pieces