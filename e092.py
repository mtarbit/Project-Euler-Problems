
def sum_sq_digits(n):
    return sum([int(s)**2 for s in str(n)])

def main():
    count = 0
    arrives_at_A = { 1:True }
    arrives_at_B = { 89:True }

    for n in xrange(1,10000000):
        m = n
        isA = False
        isB = False
        seq = [m]

        while True:

            isA = arrives_at_A.has_key(m)
            if isA: break

            isB = arrives_at_B.has_key(m)
            if isB: break

            m = sum_sq_digits(m)
            seq.append(m)

        seq_as_dict = dict.fromkeys(seq,True)

        if isA:
            arrives_at_A.update(seq_as_dict)
            # arrives_at = 1
        if isB:
            arrives_at_B.update(seq_as_dict)
            # arrives_at = 89
            count += 1

        # print "%s -> %d" % (",".join(map(str, seq)), arrives_at)

    return count


