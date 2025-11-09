#include <cuda.h>
#include <math.h>
#include <stdio.h>

int checkFactor(long long product, long long factor) {
    return product % factor == 0;
}

long long factor(long long product) {
    if (product % 2 == 0) {
        return 2;
    }
    long long limit = (long long) sqrt((double) product);
    for (long long f = 3; f <= limit; f += 2) {
        if (checkFactor(product, f)) {
            return f;
        }
    }
    return 1;
}

int main(int argc, char **argv) {
    long long product = atoll(argv[1]);
    long long f = factor(product);
    if (f == 1) {
        printf("%ld is a prime number.\n", product);
    } else {
        printf("%ld has a prime factor of %ld.\n", product, f);
    }
    return 0;
}
