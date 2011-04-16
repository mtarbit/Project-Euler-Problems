#!/usr/bin/python

import math

def is_pan_num(n):
    if n < 123456789:
        return False
    digits = [False] * 10
    while n:
        n, r = divmod(n, 10)
        r = int(r)
        if r == 0 or digits[r]:
            return False
        digits[r] = True
    return True

def pre_digits(n, digits):
    length = int(math.log(n, 10)) + 1
    if length > digits:
        return int(n / 10 ** (length - digits))
    else:
        return n

def suf_digits(n, digits):
    return n % 10 ** digits

if __name__ == "__main__":
    a = A = 0
    b = B = 1
    x = 0

    pan = 123456789
    while True:
        a, b = b, a+b
    
        length = int(math.log(b, 10)) + 1
        digits = 15
        if length > digits:
            a = int(a / 10 ** (length - digits))
            b = int(b / 10 ** (length - digits))
        
        A, B = B, A+B
        A = suf_digits(A, 9)
        B = suf_digits(B, 9)
    
        x += 1
    
        prefix = pre_digits(a, 9)
        suffix = suf_digits(A, 9)

        if prefix >= pan and suffix >= pan:
            panpre = is_pan_num(prefix)
            pansuf = is_pan_num(suffix)
            if panpre or pansuf:
                print "%d: %d...%d (%d, %d)" % (x, prefix, suffix, panpre, pansuf)
            if panpre and pansuf:
                break


#   541: 516212329...839725641 (0, 1)
#   919: 513046096...965324781 (0, 1)
#  1788: 209129724...127893456 (0, 1)
#  4589: 495217638...452911189 (1, 0)
#  6355: 584748055...379218645 (0, 1)
#  7102: 759864321...984519551 (1, 0)
#  7727: 314782956...397498593 (1, 0)
#  8198: 853472961...416719849 (1, 0)


#def is_pan_num(n):
#    if n < 123456789:
#        return False
#    digits = [False] * 10
#    while n:
#        n, r = divmod(n, 10)
#        r = int(r)
#        if r == 0 or digits[r]:
#            return False
#        digits[r] = True
#    return True
#
#def is_pan_str(n):
#    digits = [False] * 10
#    s = str(n)
#    if len(s) != 9:
#        return False
#    for c in s:
#        i = int(c)
#        if c == '0' or digits[i]:
#            return False
#        digits[i] = True
#    return True
#
#
#if __name__ == "__main__":
#    a = 0
#    b = 1
#    x = 0
#
#    next_possible = 123456789123456789
#    while True:
#        a, b = b, a+b
#
#        if a >= next_possible:
#            length = int(math.log(a, 10)) + 1
#
#            prefix = a / 10 ** (length - 9)
#            suffix = a % 10 ** 9
#
#            if prefix >= 123456789 and suffix >= 123456789:
#                panpre = is_pan_num(prefix)
#                if panpre:
#                    pansuf = is_pan_num(suffix)
#                    print "%d: %d...%d (%d, %d)" % (x, prefix, suffix, panpre, pansuf)
#                    if pansuf:
#                        break
#                else:
#                    # Can do better than this. Rather than prefix + 1, generate all pandigital
#                    # permutations and use next in line that's greater than the current prefix.
#                    next_possible = ((prefix + 1) * (10 ** (length - 9))) + 123456789
#
#        x += 1

