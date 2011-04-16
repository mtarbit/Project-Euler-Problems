#! /usr/local/bin/python3

    
def make_change(total, coins):
    n = 0
    c = coins.pop(0)
    div, mod = divmod(total, c)
    for x in range(0, div + 1):
        if total == 0:
            n += 1
        elif len(coins):
            n += make_change(total, coins[:])
        else:
            pass
        total -= c
    return n


if __name__ == '__main__':
    total = 100
    coins = list(range(100,0,-1))

    print(make_change(total, coins))
            
        
