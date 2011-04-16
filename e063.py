#! /usr/bin/python

import math

def problem():
    matches = 0
    for d in xrange(1, 1000):
        start = int(math.ceil(math.pow(10 ** (d - 1), 1.0/d)))
        for n in xrange(start, 100000):
            p = str(n ** d)
            if len(p) == d:
                matches += 1
                print "%d: %s" % (d, p)
            if len(p) > d:
                if n == start:
                    return matches
                else:
                    break

if __name__ == "__main__":
    print problem()

