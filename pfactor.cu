#include <cuda.h>
#include <math.h>
#include <stdio.h>

__device__ int checkFactor(long long product, long long factor) {
    return product % factor == 0;
}

__global__ void factorKernel(long long product,
                             long long limit,
                             long long *result) {

       //Global thread Index
    long long tid = blockIdx.x * blockDim.x + threadIdx.x;

    //Total number of threads
    long long totalThreads = (long long) gridDim.x * blockDim.x;

    // Thread 0 checks for factor 2
    if (tid == 0 && product % 2 == 0) {
        atomicMin(result, (long long)2);

    }
    // Starting from 3, check only odd factors
    long long f = 3 + 2 * tid;

    // Each thread checks its own sequence of candidates spaced by 2 * totalThreads
    for (long long candidate = f; candidate <= limit; candidate += 2 * totalThreads) {
        if (checkFactor(product, candidate)) {
            atomicMin(result, candidate);
            break; // may exit early if a factor is found
        }
    }

}

long long factor(long long product) {
    if (product % 2 == 0) {
        return 2;
    }
    long long limit = (long long) sqrt((double) product);

    // Sentinel assume prime until a factor is found
    long long result = product;
    long long *dResult;

    // Device memory allocation
    cudaMalloc((void **)&dResult, sizeof(long long));

    // Copy initial value to device
    cudaMemcpy(dResult, &result, sizeof(long long), cudaMemcpyHostToDevice);

    // Launch: 256 blocks x 256 threads (per block)
    dim3 grid(256);
    dim3 block(256);
    factorKernel<<<grid, block>>>(product, limit, dResult);
    cudaDeviceSynchronize();

    // Copy result back to host
    cudaMemcpy(&result, dResult, sizeof(long long), cudaMemcpyDeviceToHost);

    // Free device memory
    cudaFree(dResult);

    // If no factor found, return 1 indicating prime
    if (result == product) {
        return 1; // prime
    }

    return result;
}

int main(int argc, char **argv) {
    long long product = atoll(argv[1]);
    long long f = factor(product);
    if (f == 1) {
        printf("%lld is a prime number.\n", product); // change here the %ld to %lld for long long
    } else {
        printf("%lld has a prime factor of %lld.\n", product, f);
    }
    return 0;
}
/***************************************************************
 AI Assistance Disclosure – CSC 473 Assignment 4 (pfactor.cu)

 I used ChatGPT (GPT-5) for limited guidance during this assignment.
 The assistance included:

  • Verifying the structure and correctness of my pfactor.cu code.
  • Helping me diagnose Windows compilation issues with NVCC.
  • Providing the proper CUDA compile/run commands for the
    “x64 Native Tools Command Prompt for VS 2022.”
  • Explaining why format warnings occurred and how to resolve them.

 All CUDA logic, kernel implementation, host code, debugging,
 and final program structure were written and reviewed by me.
 The parallel factorization algorithm and all submitted work
 reflect my own understanding.

***************************************************************/
