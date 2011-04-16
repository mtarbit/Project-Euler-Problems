#!/usr/bin/python

def sum_digits(n):
    return sum(map(int, list(str(n))))

if __name__ == "__main__":
    limit = (10 ** 3)
    counts = {}

    for x in xrange(1, limit + 1):
        s1 = sum_digits(x)
        # if s1 % 9 == 0:
        s2 = sum_digits(x * 137)
        if s1 == s2:
            l = len(str(x))
            if not counts.has_key(l):
                counts[l] = 0
                # print l-1, counts.get(l-1, 0)
            counts[l] += 1
            print 'x ', x, x * 137, s1
        elif s1 % 9 == 0:
            print '- ', x, x * 137, s1, s2
        # else:
        #    print '  ', x, x * 137, s1, s2

    print counts
