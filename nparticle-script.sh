#!/bin/bash

export UCX_NET_DEVICES=mlx5_0:1 
export UCX_IB_GPU_DIRECT_RDMA=yes 
export UCX_TLS=ib 

# Check if the number of processors and threads arguments are provided
if [ $# -ne 2 ]
then
    echo "Usage: $0 <MAX_NPROCS> <MAX_NTHREADS>"
    exit 1
fi

max_num_procs=$1
max_num_threads=$2

# Compile the program
echo "Compile program"
make
echo 

# Run the program for each combination of MPI processes and OpenMP threads
for ((num_procs=32; num_procs<=max_num_procs; num_procs*=2))
do
    for ((num_threads=2; num_threads<=max_num_threads; num_threads*=2))
    do
        export OMP_NUM_THREADS=$num_threads
        echo "Running with $num_procs MPI processes and $OMP_NUM_THREADS OpenMP threads"
        srun -N $num_procs -p parallel --reservation=maintenance ./nparticle
    done
done

# Clear temporary file
echo "Clear temporary file"
make clean
echo 
