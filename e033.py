#! /usr/local/bin/python3

if __name__ == '__main__':
    for n in range(10,100):
        for m in range(10,100):
            if n/m >= 1:
                continue
            N = str(n)
            M = str(m)
            # for indices in ((0,0), (0,1), (1,1), (1,0)):
            for indices in ((0,1), (1,0)):
                a,b = indices
                if N[a] == M[b]:
                    i,j = int(N[1 - a]), int(M[1 - b])
                    if m != 0 and j != 0 and n/m == i/j:
                        print("{0}/{1} == {2}/{3}".format(n, m, i, j))
