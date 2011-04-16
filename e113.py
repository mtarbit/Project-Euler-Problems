#! /usr/bin/python


def is_bouncy(n):
    s = str(n)
    up = False
    dn = False
    for i in xrange(1, len(s)):
        a = int(s[i - 1])
        b = int(s[i])
        if a < b: up = True
        if a > b: dn = True
        if up and dn:
            return True
    return False


def bounce(s):
    inc = True
    dec = True
    for i in xrange(1, len(s)):
        a = int(s[i - 1])
        b = int(s[i])
        if a > b: inc = False
        if a < b: dec = False
        if not inc and not dec:
            break
    return inc, dec


if __name__ == '__main__':
    total = 99

    both = []
    incs = []
    decs = []

    n = 100
    while n < 1000:
        s = str(n)
        inc, dec = bounce(s)
        if inc and dec:
            both.append(s)
        else:
            if inc: incs.append(s)
            if dec: decs.append(s)
        n += 1

    total += len(both) + len(incs) + len(decs)

    print 1, 9
    print 2, 90

    previous_total = 99

    digits = 3
    while digits < 25: # 101:
        print digits, (total - previous_total)
    
        new_both = []
        new_incs = []
        new_decs = []
    
        for s in both:
            c = s[0]
            new_both.append(c + s)
            for x in xrange(1, int(c)):
                new_incs.append(str(x) + s)
            for x in xrange(int(c) + 1, 10):
                new_decs.append(str(x) + s)
    
        for s in incs:
            c = s[0]
            for x in xrange(1, int(c) + 1):
                new_incs.append(str(x) + s)

        for s in decs:
            c = s[0]
            for x in xrange(int(c), 10):
                new_decs.append(str(x) + s)

        for x in xrange(1, 10):
            new_decs.append(str(x) + ('0' * digits))

        both = new_both
        incs = new_incs
        decs = new_decs

        previous_total = total
        total += len(both) + len(incs) + len(decs)
        digits += 1

    print total


#def is_bouncy(n):
#    s = str(n)
#    up = False
#    dn = False
#    for i in xrange(1, len(s)):
#        a = int(s[i - 1])
#        b = int(s[i])
#        if a < b:
#            up = True
#        if a > b:
#            dn = True
#        if up and dn:
#            if a < b:
#                s = s[:i] + ('9' * (len(s) - i))
#            if a > b:
#                s = s[:i] + (str(a) * (len(s) - i))
#            n = int(s)
#            return n
#    return False
#
#if __name__ == '__main__':
#    googol = 10 ** 100
#
#    c = 0
#    n = 100
#
#    while n < googol:
#        next_bouncy = is_bouncy(n)
#        if next_bouncy:
#            d = next_bouncy - n
#            c += (1 + d)
#            n = next_bouncy
#        n += 1
#    
#    print n - c
