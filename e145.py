#!/usr/bin/python

def reversible(n):
    if n % 10 == 0:
        return False

    r = list(str(n))
    r.reverse()
    r = int(''.join(r))

    check = n + r
    while check:
        check, m = divmod(check, 10)
        if m % 2 == 0:
            return False
    
    return True

if __name__ == "__main__":
    counts = {}
    limit = 10 ** 9
    for n in xrange(limit / 10, limit + 1):
        if reversible(n):
            l = len(str(n))
            if not counts.has_key(l):
                counts[l] = 0
            counts[l] += 1
    print counts
    
