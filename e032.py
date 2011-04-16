#! /usr/local/bin/python3

# n * nnnn = nnnn
# nn * nnn = nnnn
# nnn * nn = nnnn
# nnnn * n = nnnn

import itertools

def numlist2str(a):
    return ''.join(map(str, a))

if __name__ == '__main__':
    products = []
    for p in itertools.permutations(range(1,10),9):
        for i in [1,2,3,4]:
            mulA = int(numlist2str(p[:i]))
            mulB = int(numlist2str(p[i:5]))
            prod = int(numlist2str(p[5:]))
            if (mulA * mulB) == prod:
                print("{0} * {1} = {2}".format(mulA, mulB, prod))
                products.append(prod)

    print(sum(set(products)))
