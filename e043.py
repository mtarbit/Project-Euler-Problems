#! /usr/local/bin/python3

import itertools

def div_by(n,m):
    return int(n) % m == 0

if __name__ == '__main__':
    perms = [''.join(map(str,p)) for p in itertools.permutations(range(0,10),3)]
    perms = [p for p in perms if div_by(p,17)]
    
    for d in [13,11,7,5,3,2,1]:
        new_perms = []
        for k,v in enumerate(perms):
            remaining_digits = [x for x in range(0,10) if str(x) not in v]
            for n in remaining_digits:
               p = str(n) + v
               if div_by(p[:3], d):
                  new_perms.append(p)
        perms = new_perms[:]
    
    print(perms)
    print(sum(map(int,perms)))
