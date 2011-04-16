#! /usr/local/bin/python3

import math
import itertools

def is_prime(n):
    x = 2
    while x < math.sqrt(n):
        if n % x == 0:
            return False
        x += 1
    return True

if __name__ == '__main__':
    digits = 7
    primes = []
    for n in itertools.permutations(range(1, digits+1), digits):
        n = int(''.join(map(str, n)))
        if is_prime(n):
            primes.append(n)
    print(max(primes))
