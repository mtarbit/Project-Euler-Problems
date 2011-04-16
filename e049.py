#! /usr/bin/python

import math

def is_prime(n):
    for x in xrange(2, int(math.sqrt(n)) + 1):
        if n % x == 0:
            return False
    return True

def sorted_digits(n):
    n = list(str(n))
    n.sort()
    n = int(''.join(n))
    return n

if __name__ == "__main__":
    gap = 3330
    for i in range(1487, 10000 - (gap * 2)):
        j = i + gap
        k = j + gap
        if is_prime(i) and is_prime(j) and is_prime(k):
            I, J, K = map(sorted_digits, (i, j, k))
            if I == J == K:
                print (i, j, k)