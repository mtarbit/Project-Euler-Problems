#! /usr/bin/python

if __name__ == "__main__":
    m = 1
    n = 2
    o = None
    sum = 2

    while o <= 4000000:  
        o = m + n
        if o % 2 == 0:
            sum += o
        m, n = n, o

    print sum


