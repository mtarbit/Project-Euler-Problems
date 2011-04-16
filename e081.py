#!/usr/bin/python


def perms(n,r):
    set = []
    for i in range(1, n+1):
        a = [i]
        if r > 1:
            for b in perms(n, r-1):
                set.append(a + b)
        else:
            set.append(a)
    return set

def perm_to_move(p):
    cd = 1 if p == 1 else 0
    rd = 1 if p == 2 else 0
    return (rd, cd)


if __name__ == "__main__":
    matrix = []
    for line in open('data/matrix.txt'):
        row = map(int, line.strip().split(','))
        matrix.append(row)

    # matrix = [
    #     [131, 673, 234, 103, 18],
    #     [201, 96 , 342, 965, 150],
    #     [630, 803, 746, 422, 111],
    #     [537, 699, 497, 121, 956],
    #     [805, 732, 524, 37 , 331],
    # ]
    
    max_val = 10000
    search_steps = 16
    tri_part_paths = perms(2,search_steps)

    n = matrix[0][0]
    min_path = [n]
    min_path_sum = n
    sz = len(matrix) - 1
    
    r = 0
    c = 0

    while r<sz or c<sz:
        min_sum = max_val * search_steps
        min_mov = None
        for path in tri_part_paths:
            sum = 0
            R = r
            C = c
            for p in path:
                d = perm_to_move(p)
                R += d[0]
                C += d[1]
                try:
                    sum += matrix[R][C]
                except:
                    sum += max_val
            # print path
            # print sum
            if sum < min_sum:
                min_sum = sum
                min_mov = perm_to_move(path[0])

        r += min_mov[0]
        c += min_mov[1]

        n = matrix[r][c]

        min_path.append(n)
        min_path_sum += n

        print min_path
        print min_path_sum
