# Process Initialization, Creation, and Management
## Launch
不是直接启动的。

```cmd
mpiexec -help
mpiexec -help2
```
```cmd
mpiexec main.exe
mpiexec -c 8 main.exe
mpiexec -n 2 main.exe
```

## The World Model
### Starting MPI Process
```cpp
int MPI_Init(int *argc, char ***argv)

// required: desired level of thread support
// provided: provided level of thread support
int MPI_Init_thread(int *argc, char ***argv, int required, int *provided)
```

### Finalizing MPI
```cpp
int MPI_Finalize()
```
