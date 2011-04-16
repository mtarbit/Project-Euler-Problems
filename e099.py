#! /usr/bin/python

import math


def exp_with_base2(n, p):
    return p * math.log(n, 2)


if __name__ == '__main__':

    greatest_exp = 0
    greatest_idx = None

    for i, line in enumerate(open('data/base_exp.txt')):
        n, p = map(int, line.strip().split(','))

        exp = exp_with_base2(n, p)
        if exp > greatest_exp:
            greatest_exp = exp
            greatest_idx = i

    print greatest_idx
