// Include all necessary libraries
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>
#include <omp.h>
#include <time.h>


// Define a structure for a particle:
typedef struct {
    double x, y, z;    // position
    double vx, vy, vz; // velocity
    double mass;       // mass
} Particle;


// The function to compute the force between two particles:
void compute_force(Particle *p1, Particle *p2, double *fx, double *fy, double *fz) {
    double dx = p2->x - p1->x;
    double dy = p2->y - p1->y;
    double dz = p2->z - p1->z;
    double dist_sq = dx*dx + dy*dy + dz*dz;
    double dist = sqrt(dist_sq);
    double eps = 1e-3; // Error Check (small constant to avoid division by zero)
    double force = p1->mass * p2->mass / (dist_sq * dist + eps);
    *fx = force * dx;
    *fy = force * dy;
    *fz = force * dz;
}


// The function to initialize the particles:
void initialize_particles(Particle *particles, int num_particles) {
    srand(time(NULL)); // Initialize random number generator

    double box_size = 10.0; // Size of the box that particles start in
    double max_velocity = 0.1; // Maximum initial velocity
    double mass = 1.0; // Mass of each particle

    for (int i = 0; i < num_particles; i++) {
        particles[i].x = box_size * (double)rand() / RAND_MAX;
        particles[i].y = box_size * (double)rand() / RAND_MAX;
        particles[i].z = box_size * (double)rand() / RAND_MAX;
        particles[i].vx = max_velocity * (double)rand() / RAND_MAX;
        particles[i].vy = max_velocity * (double)rand() / RAND_MAX;
        particles[i].vz = max_velocity * (double)rand() / RAND_MAX;
        particles[i].mass = mass;
    }
}



// Initialize MPI and split particles among processes:
int main(int argc, char *argv[]) {
    int num_particles = 100000; // set total number of particles
    int num_steps = 1000; // set number of time steps

    Particle *particles = malloc(num_particles * sizeof(Particle));

    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (rank == 0) {
        initialize_particles(particles, num_particles);
    }

    int chunk_size = num_particles / size; // divide particles among processes
    Particle *local_particles = malloc(chunk_size * sizeof(Particle));
    MPI_Scatter(particles, chunk_size * sizeof(Particle), MPI_BYTE,
                local_particles, chunk_size * sizeof(Particle), MPI_BYTE,
                0, MPI_COMM_WORLD);


    // Start the timer
    double start_time = MPI_Wtime();


// Compute forces and update velocities and positions:
for (int step = 0; step < num_steps; step++) {
    // Compute forces
    double *forces = malloc(chunk_size * 3 * sizeof(double));
    #pragma omp parallel for
    for (int i = 0; i < chunk_size; i++) {
        forces[3*i] = 0;
        forces[3*i+1] = 0;
        forces[3*i+2] = 0;
        for (int j = 0; j < num_particles; j++) {
            if (j != i) {
                double fx, fy, fz;
                compute_force(&local_particles[i], &particles[j], &fx, &fy, &fz);
                forces[3*i] += fx;
                forces[3*i+1] += fy;
                forces[3*i+2] += fz;
            }
        }
    }

    // Update velocities and positions
    #pragma omp parallel for
    for (int i = 0; i < chunk_size; i++) {
        local_particles[i].vx += forces[3*i] / local_particles[i].mass;
        local_particles[i].vy += forces[3*i+1] / local_particles[i].mass;
        local_particles[i].vz += forces[3*i+2] / local_particles[i].mass;
        local_particles[i].x += local_particles[i].vx;
        local_particles[i].y += local_particles[i].vy;
        local_particles[i].z += local_particles[i].vz;
    }
    free(forces);

    // Combine all particles' data back together
    MPI_Allgather(local_particles, chunk_size * sizeof(Particle), MPI_BYTE,
                  particles, chunk_size * sizeof(Particle), MPI_BYTE,
                  MPI_COMM_WORLD);
}

    // End the timer
    double end_time = MPI_Wtime();
    double elapsed_time = end_time - start_time;

    // Only the root process will print the time
    if (rank == 0) {
        printf("Elapsed time: %f seconds\n", elapsed_time);
    }

free(local_particles);
MPI_Finalize();
free(particles);
return 0;
}
