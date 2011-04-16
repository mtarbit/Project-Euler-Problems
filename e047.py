#!/usr/bin/python

import math

def erato(limit):
    sieve = [True] * limit
    sieve[0] = sieve[1] = False

    for x in xrange(2, int(math.ceil(limit / 2.0))):
        if sieve[x]:
            n = x * 2
            while n < limit:
                sieve[n] = False
                n += x
    
    return sieve

def erato_primes(limit):
    return [k for k,v in enumerate(erato(limit)) if v]

def factors(n, primes):
    res = []
    mid = int(math.ceil(n / 2.0))
    for p in primes:
        if p > mid:
            break
        while n % p == 0:
            n /= p
            res.append(p)
    return res

def distinct_factors(n, primes):
    res = set(factors(n, primes))
    return list(res)

if __name__ == "__main__":
    bounds = 1000000
    primes = erato_primes(bounds)

    search = 4
    so_far = []
    max_consecutive = 0

    for n in xrange(2, bounds + 1):
        if n % 10000 == 0:
            print n

        res = distinct_factors(n, primes)
        length = len(res)

        if length == search:
            so_far.append((n, res))
        else:
            so_far = []

        if len(so_far) > max_consecutive:
            max_consecutive = len(so_far)
            print max_consecutive

        if len(so_far) == search:
            for n, res in so_far:
                print n, res
            break

    