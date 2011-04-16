#!/usr/bin/python


if __name__ == "__main__":
    pentagonal = []
    pent_sieve = [False]

    n = 1
    while n <= 10000:
        p = int((n * ((3 * n) - 1)) / 2.0)
        pentagonal.append(p)
        pent_sieve += [False] * (p - len(pent_sieve))
        pent_sieve += [True]

        for a in pentagonal:
            found = False

            b = p - a
            if pent_sieve[b]:
                print "%d + %d = %d" % (a, b, p)

                c = abs(a - b)
                if pent_sieve[c]:
                    found = True
                    print "%d - %d = %d" % (a, b, c)
                    break

        if found:
            break

        n += 1

    # print pentagonal
    # print pent_sieve


