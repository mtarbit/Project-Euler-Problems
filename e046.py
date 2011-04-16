#!/usr/bin/python

import math

def sieve(limit):
    res = [True] * limit
    res[0] = res[1] = False

    for x in xrange(2, int(math.ceil(limit / 2.0))):
        if res[x]:
            n = x * 2
            while n < limit:
                res[n] = False
                n += x
    
    return res

def goldbach(n, primes):
    for p in primes:
        m = n - p
        div, mod = divmod(m, 2)
        if mod == 0:
            root = math.sqrt(div)
            if root == int(root):
                return p, int(root)
    return False    

if __name__ == "__main__":
    res = sieve(1000000)
    primes = [k for k, v in enumerate(res) if v]
    odd_composites = [k for k, v in enumerate(res) if not v and k>1 and k%2]
    
    for n in odd_composites:
        if not goldbach(n, primes):
            print n
            break