import math

def fac(n, limit=1):
    m = n
    while n > (limit + 1):
        n -= 1
        m *= n
    return m

def combinations(n,r):
    # 12 * 11 * ... * 1 /
    # 3 * 2 * 1   *   9 * 8 * ... * 1
    # return fac(n + r - 1) / (fac(r) * fac(n - 1))
    return fac(n + r - 1, n - 1) / fac(r)

def cuboid_shortest_path(w,h,d):
    i = math.hypot(w, h+d)
    j = math.hypot(h, d+w)
    k = math.hypot(d, h+w)
    # print i, j, k
    return min(i,j,k)

def solutions(m=100):
    n = 0
    c = 0
    m += 1
    for w in xrange(1, m):
        for h in xrange(w, m):
            for d in xrange(h, m):
                p = cuboid_shortest_path(w,h,d)
                c += 1
                if p == int(p):
                    # print "(%d,%d,%d): %d" % (w,h,d, p)
                    n += 1
    return c, n

def main(i=1,j=200):
    for x in xrange(i,j):
        c, n = solutions(x)
        print "%d: %d solutions in %d combinations" % (x, n, c)