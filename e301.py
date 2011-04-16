#!/usr/bin/python


def nim(a,b,c):
    return a^b^c > 0


if __name__ == "__main__":
    limit = 300
    c = 0
    for n in range(1, limit+1):
        res = nim(1*n, 2*n, 3*n)
        if not res:
            c += 1 
        if n % 10 == 0:
            print '%d: %d' % (n, c)


