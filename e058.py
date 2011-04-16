#! /usr/bin/python

import math


def is_prime(n):
    for x in xrange(2, int(math.sqrt(n)) + 1):
        if n % x == 0:
            return False
    return True


def corners(i):
    if i < 1:
        return 1
    else:
        i = ((i + 1) * 2) - 1
        n = i * i

        a = n
        b = a - i + 1
        c = b - i + 1
        d = c - i + 1
    
        return i, (a, b, c, d)


if __name__ == "__main__":
    total = 1
    prime = 0
    ratio = None

    for x in xrange(1, 40000):
        side, abcd = corners(x)
        abcd = filter(is_prime, abcd)
        
        total += 4
        prime += len(abcd)

        ratio = (prime / float(total)) * 100
        if ratio < 10:
            print side
            break
