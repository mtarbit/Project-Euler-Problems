#! /usr/bin/python

import math

def quad(n, a, b):
    return (n ** 2) + (a * n) + b

def is_prime(n):
    n = abs(n)
    i = 2
    while i <= math.sqrt(n):
        if n % i == 0:
            return False
        i += 1
    return True

def sieve(n):
    sqrt = math.sqrt(n)
    
    sieve = [True] * n
    sieve[0] = sieve[1] = False
    
    p = 2
    while p < sqrt:
        if sieve[p]:
            for i in xrange(p*p, n, p):
                sieve[i] = False
        p += 1

    return sieve

def primes_from_sieve(sieve):
    return [k for k,v in enumerate(sieve) if v]

def reflect(a):
    import operator
    b = map(operator.__neg__, a[:])
    b.reverse()
    return b + a

def problem(min,max):
    a_list = reflect(range(min,max))
    b_list = reflect(primes_from_sieve(sieve(max)[min:max]))

    max = 0
    for a in a_list:
        for b in b_list:
            n = 0
            while True:
                q = quad(n, a, b)
                if not is_prime(q):
                    break
                n += 1
            if n > max:
                print "a: %d, b: %d - %d primes" % (a, b, n)
                max = n

    print "Max. primes found: %d" % (max,)   

if __name__ == "__main__":
    problem(0,1000)


