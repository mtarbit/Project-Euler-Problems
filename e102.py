#!/usr/bin/python

class p:
    def __init__(self, x,y):
        self.x = x
        self.y = y
    
    def __str__(self):
        return repr((self.x, self.y))

def origin_in_triangle(a, b, c):
    return point_in_triangle(p(0,0), a, b, c)

def point_in_triangle(p, a, b, c):
    o1 = orientation(a, b, p)
    o2 = orientation(b, c, p)
    o3 = orientation(c, a, p)

    if o1 == o2 and o2 == o3:
        return True

def orientation(a, b, c):
    o = ((b.x - a.x) * (c.y - a.y)) - ((c.x - a.x) * (b.y - a.y))
    if o > 0:
        return +1
    elif o < 0:
        return -1
    else:
        return 0

# print origin_in_triangle((-340, 495), (-153, -910), (835, -947))
# print origin_in_triangle((-175, 41), (-421, -714), (574, -645))

def determinant(a, b):
    return (a.x * b.y) - (a.y * b.x)

def contains_origin(a, b, c):
    k = determinant(a, b) >= 0
    l = determinant(b, c) >= 0
    m = determinant(c, a) >= 0
    return k == l == m

if __name__ == "__main__":

    count = 0
    for line in open('data/triangles.txt'):
        coords = map(int, line.strip().split(','))
        a = p(*coords[0:2])
        b = p(*coords[2:4])
        c = p(*coords[4:6])
        # if origin_in_triangle(a,b,c):
        if contains_origin(a, b, c):
            count += 1
            print a,b,c

    print count
        

