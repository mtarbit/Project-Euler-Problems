#! /usr/bin/python


def is_bouncy(n):
    s = str(n)
    up = False
    dn = False
    for i in xrange(1, len(s)):
        a = int(s[i - 1])
        b = int(s[i])
        if a < b:
            up = True
        if a > b:
            dn = True
        if up and dn:
            return True
    return False


if __name__ == '__main__':
    proportion = None
    c = 0
    n = 0
    while True:
        n += 1
        if is_bouncy(n):
            c += 1
        proportion = c / float(n)
        if proportion >= 0.99:
            print n
            break