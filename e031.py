#! /usr/local/bin/python3

    
def make_change(total, i=0):
    n = 0
    c = coins[i]
    div, mod = divmod(total, c)
    for x in range(0, div + 1):
        if total == 0:
            n += 1
        elif i < len(coins) - 1:
            n += make_change(total, i+1)
        else:
            pass
        total -= c
    return n


if __name__ == '__main__':
    total = 210
    coins = (200,100,50,20,10,5,2,1)

    print(make_change(total))
            
        
