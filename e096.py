

grid = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"

class Sudoku:

    def __init__(self, grid):
        self.data = map(int, list(grid))

    def col(self, i):
        return [self.data[j] for j in xrange(i, i + (8*9) + 1, 9)]
    
    def row(self, i):
        m = i * 9
        n = m + 9
        return self.data[m:n] 
    
    def box(self, i):
        j = (i * 3) + (i / 3 * 18)
        return self.data[j:j+3] + self.data[j+9:j+9+3] + self.data[j+18:j+18+3]

    def solve(self):
        for i in xrange(1,10):
            for x in xrange(0,9):
                box = self.box(x)
                if 0 in box and not i in box:
                    print "box %d is missing: %d" % (x, i)

    def grid(self):
        s = ''
        for i in xrange(0,9):
            if i % 3 == 0:
                s += "+-------+-------+-------+\n"
            r = map(str, self.row(i))
            s += "| %s | %s | %s |\n" % (' '.join(r[0:3]), ' '.join(r[3:6]), ' '.join(r[6:9]))
        s += "+-------+-------+-------+\n"
        return s.replace('0',' ')
                
        
