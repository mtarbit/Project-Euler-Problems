#! /usr/bin/python

def sqrt2_expand(n):
    if n <= 1:
        return 2
    else:
        return 2 + 1.0 / sqrt2_expand(n - 1)

def intifier(n):
    i = 0
    while True:
        i += 1
        m = i * n
        if m == int(m):
            return i

def pell_lucas(n):
    if n < 2:
        return 2
    else:
        return (2 * pell_lucas(n-1)) + pell_lucas(n-2)

def pell(n):
    if n < 2:
        res = n
    else:
        res = (2 * pell(n-1)) + pell(n-2)

if __name__ == "__main__":
    c = 0
    pell = [0]
    pell_lucas = [2]
    for x in xrange(1,1001):

        if x < 2:
            n = x
            m = 2
        else:
            n = (2 * pell[x-1]) + pell[x-2]
            m = (2 * pell_lucas[x-1]) + pell_lucas[x-2]
        
        pell.append(n)
        pell_lucas.append(m)
        
        num = m / 2
        den = n
        if len(str(num)) > len(str(den)):
            c += 1
    print c
