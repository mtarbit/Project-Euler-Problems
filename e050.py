#!/usr/bin/python

from __future__ import division
import math

if __name__ == "__main__":
    limit = 1000000
    sieve = [True] * limit
    sieve[0] = sieve[1] = False

    for x in xrange(2, int(math.ceil(limit / 2))):
        if sieve[x]:
            n = x * 2
            while n < limit:
                sieve[n] = False
                n += x

    primes = [k for k,v in enumerate(sieve) if v]

    max_len = 0
    terms = len(primes)
    
    print terms
    
    for i in xrange(0, terms):
        seq_sum = primes[i]
        seq_len = 1
        for j in xrange(i + 1, terms):
            seq_sum += primes[j]
            seq_len += 1
            if seq_sum >= limit:
                break
            if seq_len > max_len and sieve[seq_sum]:
                max_len = seq_len
                print i, seq_sum, seq_len
                

    