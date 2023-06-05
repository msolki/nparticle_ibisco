# Specify the compiler
CC=mpicc

# Specify options for the compiler
CFLAGS=-O3 -fopenmp -std=c99

# Libraries for the linker
LIBS=-lm

# The build target executable:
TARGET=nparticle

all: $(TARGET)

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).c $(LIBS)

clean:
	$(RM) $(TARGET)
