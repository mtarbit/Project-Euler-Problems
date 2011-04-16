#!/usr/bin/python

def reverse(n, seq):
    for c in seq[::-1]:
        if c == 'D':
            n = n * 3
        elif c == 'U':
            n = ((n * 3) - 2)
            div, mod = divmod(n, 4)
            if mod: return False
            n = div
        elif c == 'd':
            n = ((n * 3) + 1)
            div, mod = divmod(n, 2)
            if mod: return False
            n = div
    return n


if __name__ == "__main__":
    # x = 10 ** 6
    # search = 'DdDddUUdDD'
    x = 10 ** 15
    search = 'UDDDUdddDDUDDddDdDddDDUDDdUUDd'

    while True:
        n = x

        numbs = [n]
        steps = ''
    
        while n > 1 and steps == search[:len(steps)]:
            r = n % 3
            if r == 0:
                next = n / 3
                step = 'D'
            elif r == 1:
                next = ((4 * n) + 2) / 3
                step = 'U'
            elif r == 2:
                next = ((2 * n) - 1) / 3
                step = 'd'

            n = next

            numbs.append(n)
            steps += step

        # print numbs
        # print x, steps
        
        if steps[:len(search)] == search:
            print x, steps
            print numbs
            break
        
        x += 1