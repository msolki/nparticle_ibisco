# nparticle_ibisco

This project is a parallel implementation of the N-body simulation using a hybrid model of MPI (Message Passing Interface) and OpenMP (Open Multi-Processing). It is designed to run efficiently on high-performance computing (HPC) clusters.

## Description

The simulation uses MPI for communication between nodes in a distributed environment and OpenMP for multi-threading within a single node. The N-body problem involves calculating the motion of a group of celestial objects interacting with each other gravitationally. It is a computationally intensive task that benefits greatly from parallel processing.

The project contains the following main files:

1. `nparticle.c`: This is the main C source file, which includes the parallel N-body simulation code.
2. `Makefile`: This file is responsible for automating the build process of the project.
3. `nparticle-script.sh`: This Bash shell script is used to automate the build and execution of the program on an HPC cluster.

## Building and Running

You can build the project using the provided Makefile:

```bash
make

```

To execute the program, use the provided Bash script. The script takes the maximum number of MPI processes and OpenMP threads as inputs:

```bash
./nparticle-script.sh <MAX_MPI_PROCESSES> <MAX_OMP_THREADS>

```
Remember to replace placeholders `<MAX_MPI_PROCESSES>` and `<MAX_OMP_THREADS>` with the maximum number of MPI processes and OpenMP threads.

## Results

Results will be generated for different combinations of MPI processes and OpenMP threads, which you can use to analyze the performance of the parallel implementation.

## Authors

** Mohammad Solki **
** Prakash Srinivasan **
** Ali Asgari **

## Acknowledgements

This is a group contribution to Data Management and Computer Networks Mod. B. 

## License

This project is licensed under the terms of the MIT license.
