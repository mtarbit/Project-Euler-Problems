#!/usr/bin/python

from __future__ import division
import math

if __name__ == "__main__":

    perimeters = list(xrange(120, 1001))
    perimeters.reverse()

    max = 0
    max_perimeter = 120

    for p in perimeters:
        midway = int(math.ceil(p / 2))
        
        solutions = 0

        for a in xrange(1, midway + 1):
            for b in xrange(a, midway + 1):
                c = math.sqrt((a ** 2) + (b ** 2))
                if int(c) == c:
                    if (a + b + c) == p:
                        solutions += 1

        if solutions > max:
            max = solutions
            max_perimeter = p
            print "%d: %d solutions" % (max_perimeter, max)

