#!/usr/bin/python


def gcd(a, b):
    while b:
        a, b = b, a%b
    return a


def coprime(a, b):
    return gcd(a, b) == 1


def totient(n):
    totatives = 0
    for i in range(1, n+1):
        if coprime(i, n):
            totatives += 1
    return totatives


def e69(max_limit=10, min_limit=1):
    max = (0, 0, 0)
    fmt = '%d - %d, %f'
    for i in range(min_limit, max_limit+1):
        t = totient(i)
        f = i / float(t)
        if f > max[2]:
            cur = (i, t, f)
            print cur
            max = cur

if __name__ == '__main__':
    """
    From this, noted the pattern in n. That each progressive
    n for which n/totient(n) is maximal is a product of sequential 
    primes. The solution turns out to be 2 * 3 * 5 * 7 * 11 * 13 * 17.
    Also known as '17#' or '17 primorial' as discussed here:
    http://primes.utm.edu/glossary/page.php?sort=Primorial
    """
    e69(10000)


