#!/usr/bin/ruby

require 'benchmark'
def bm; Benchmark.measure { yield }.format('%.3r'); end

module Enumerable
  def sum
    self.inject(0) { |acc, i| acc + i }
  end

  def average
    self.sum / self.length.to_f
  end

  def sample_variance
    avg = self.average
    sum = self.inject(0) { |acc, i| acc + (i - avg) ** 2 }
    (1 / self.length.to_f * sum)
  end

  def standard_deviation
    Math.sqrt(self.sample_variance)
  end
end

def bm_compare(f1,f2,iterations)
  deltas = []

  iterations.times do
    timeA = Benchmark.realtime { f1 }
    timeB = Benchmark.realtime { f2 }
    deltas << (timeA - timeB)
  end

  std_dev = deltas.standard_deviation
  average = deltas.average

  puts "Std. deviation of deltas: #{std_dev}"
  puts "Mean average of deltas: #{average}"
  min = average - 2.0 * std_dev
  max = average + 2.0 * std_dev
  if min <= 0 || 0 >= max
   puts "No statistical difference."
  end
end



def series(limit)
  (limit * (limit+1)) / 2
end

def series_divisible_by(limit,n)
  # the sum of the integers divisible by n is 
  # equal to n * the series upto limit div n
  # ie. 3 + 6 + 9 + 12 = 3 * (1 + 2 + 3 + 4)
  m = limit / n
  n * series(m)
end

def e1(limit)
  fn = lambda {|n| series_divisible_by(limit,n) }
  fn.call(3) + fn.call(5) - fn.call(15)
end


def fib_recurse(n)
  (n <= 2) ? 1 : fib_recurse(n-2) + fib_recurse(n-1)
end

def fib(n)
  a = b = 1
  (1..n).each do |i|
    a,b = b,a+b if i > 2
  end
  b
end

def e2(limit)
  sum = 0
  a = 1
  b = 1
  c = a+b
  while c < limit
    sum += c
    a = b+c
    b = c+a
    c = a+b
  end
  sum
end


def is_prime?(n)
  prime = true
  if n == 1:    prime = false # 1 is a unit, not a prime
  elsif n<4:    prime = true  # 2 & 3 are prime
  elsif n%2==0: prime = false # no even primes other than 2
  elsif n<9:    prime = true  # 5 & 7 are prime
  elsif n%3==0: prime = false # no more primes divisible by 3
  else
    # if n has no factors <= its square root, then it's prime
    r = Math.sqrt(n).floor
    # all primes > 3 can be written in the form 6k +/- 1
    f = 5
    while f<=r
      if n%f==0 or n % (f+2) == 0
        prime = false
        break
      end
      f += 6
    end
  end
  prime
end

def sieve_of_eratosthenes(max)
  sieve = (2..max).to_a
  (2..Math.sqrt(max)).each do |i|
    next unless sieve.include?(i)
    sieve.delete_if {|j| j>i and j%i == 0 }
  end
  sieve
end

def prime_factors_simple(n)
  prime_factors = []
  factor = 2

  while n>1
    if n%factor==0
      while n%factor==0
        n /= factor
        prime_factors << factor
      end
    end
    factor += 1
  end

  prime_factors
end

def prime_factors(n)
  prime_factors = []

  # Treat 2 separately since it's the only even prime.
  if n%2==0
    while n%2==0
      n /= 2
      prime_factors << 2
    end
  end
  
  # Now carry on from 3, increasing by 2 each step
  factor = 3
  # If we exhaust all factors less than the current number's 
  # square root then whatever remains must be prime.
  factor_limit = Math.sqrt(n)
  while n>1 and factor<=factor_limit
    if n%factor==0
      while n%factor==0
        n /= factor
        prime_factors << factor
      end
      factor_limit = Math.sqrt(n)
    end
    factor += 2
  end
  
  # If there's anything left, it's a prime factor, so add it in
  if n!=1
    prime_factors << n
  end

  prime_factors
end

def e3(n)
  prime_factors(n).last
end


def is_palindromic?(n)
  s = n.to_s
  (s == s.reverse)
end

def e4()
  largest = 0
  (100..999).each do |i|
    (i..999).each do |j|
      k = i*j
      if is_palindromic?(k)
        if k > largest
          largest = k
          puts "#{i} * #{j} = #{k}"
        end
      end
    end
  end
  nil
end


def e8
  max = 0
  str = '7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450'
  arr = str.split(//)
  arr.each_with_index do |n,i|
    tot = arr[i,5].inject(1) {|product,s| product *= s.to_i }
    max = tot if tot > max
  end
  max
end


def e9
  product = nil

  (1..1000).each do |a|
    (a..1000).each do |b|
      h = (a*a) + (b*b)
      c = Math.sqrt(h)
      if c%1 == 0
        puts "%3d + %3d = %-3d (%d)" % [a,b,c, h]
        if (a+b+c) == 1000
          product = a*b*c
          break
        end
      end
    end
    break if product
  end

  puts "------------------------------"
  puts "Found it! (product: %d)" % [product]
  puts "------------------------------"
end


def e10(max)
  max -= 1
  limit = Math.sqrt(max).floor
  sieve = Array.new(max, true)
  sieve[0] = sieve[1] = nil
  (2..limit).each do |i|
    next if sieve[i].nil?
    j = i
    loop do
      j += i
      break if j > max
      sieve[j] = nil
    end
  end
=begin
  primes = []
  sieve.each_index do |i|
    primes << i if sieve[i]
  end
  primes
=end
  sum = 0
  sieve.each_index do |i|
    sum += i if sieve[i]
  end
  sum
end


def factors(n)
  factors = n>1 ? [1,n] : [1]
  divisor = 2
  limit = n
  loop do
    break if divisor >= limit
    if n%divisor == 0
      quotient = n/divisor
      factors << divisor
      if quotient > divisor
        factors << quotient
        limit = quotient
      end
    end
    divisor += 1
  end
  factors
end

def e12(max)
  t = 1
  n = 1
  loop do
    f = factors(t)
    puts "%3d: %s (%d)" % [t, f.join(','), f.size]
    if f.size >= max
      break
    end
    n += 1
    t += n
  end
end


def e13
  n = 37107287533902102798797998220837590246510135740250 +
  46376937677490009712648124896970078050417018260538 +
  74324986199524741059474233309513058123726617309629 +
  91942213363574161572522430563301811072406154908250 +
  23067588207539346171171980310421047513778063246676 +
  89261670696623633820136378418383684178734361726757 +
  28112879812849979408065481931592621691275889832738 +
  44274228917432520321923589422876796487670272189318 +
  47451445736001306439091167216856844588711603153276 +
  70386486105843025439939619828917593665686757934951 +
  62176457141856560629502157223196586755079324193331 +
  64906352462741904929101432445813822663347944758178 +
  92575867718337217661963751590579239728245598838407 +
  58203565325359399008402633568948830189458628227828 +
  80181199384826282014278194139940567587151170094390 +
  35398664372827112653829987240784473053190104293586 +
  86515506006295864861532075273371959191420517255829 +
  71693888707715466499115593487603532921714970056938 +
  54370070576826684624621495650076471787294438377604 +
  53282654108756828443191190634694037855217779295145 +
  36123272525000296071075082563815656710885258350721 +
  45876576172410976447339110607218265236877223636045 +
  17423706905851860660448207621209813287860733969412 +
  81142660418086830619328460811191061556940512689692 +
  51934325451728388641918047049293215058642563049483 +
  62467221648435076201727918039944693004732956340691 +
  15732444386908125794514089057706229429197107928209 +
  55037687525678773091862540744969844508330393682126 +
  18336384825330154686196124348767681297534375946515 +
  80386287592878490201521685554828717201219257766954 +
  78182833757993103614740356856449095527097864797581 +
  16726320100436897842553539920931837441497806860984 +
  48403098129077791799088218795327364475675590848030 +
  87086987551392711854517078544161852424320693150332 +
  59959406895756536782107074926966537676326235447210 +
  69793950679652694742597709739166693763042633987085 +
  41052684708299085211399427365734116182760315001271 +
  65378607361501080857009149939512557028198746004375 +
  35829035317434717326932123578154982629742552737307 +
  94953759765105305946966067683156574377167401875275 +
  88902802571733229619176668713819931811048770190271 +
  25267680276078003013678680992525463401061632866526 +
  36270218540497705585629946580636237993140746255962 +
  24074486908231174977792365466257246923322810917141 +
  91430288197103288597806669760892938638285025333403 +
  34413065578016127815921815005561868836468420090470 +
  23053081172816430487623791969842487255036638784583 +
  11487696932154902810424020138335124462181441773470 +
  63783299490636259666498587618221225225512486764533 +
  67720186971698544312419572409913959008952310058822 +
  95548255300263520781532296796249481641953868218774 +
  76085327132285723110424803456124867697064507995236 +
  37774242535411291684276865538926205024910326572967 +
  23701913275725675285653248258265463092207058596522 +
  29798860272258331913126375147341994889534765745501 +
  18495701454879288984856827726077713721403798879715 +
  38298203783031473527721580348144513491373226651381 +
  34829543829199918180278916522431027392251122869539 +
  40957953066405232632538044100059654939159879593635 +
  29746152185502371307642255121183693803580388584903 +
  41698116222072977186158236678424689157993532961922 +
  62467957194401269043877107275048102390895523597457 +
  23189706772547915061505504953922979530901129967519 +
  86188088225875314529584099251203829009407770775672 +
  11306739708304724483816533873502340845647058077308 +
  82959174767140363198008187129011875491310547126581 +
  97623331044818386269515456334926366572897563400500 +
  42846280183517070527831839425882145521227251250327 +
  55121603546981200581762165212827652751691296897789 +
  32238195734329339946437501907836945765883352399886 +
  75506164965184775180738168837861091527357929701337 +
  62177842752192623401942399639168044983993173312731 +
  32924185707147349566916674687634660915035914677504 +
  99518671430235219628894890102423325116913619626622 +
  73267460800591547471830798392868535206946944540724 +
  76841822524674417161514036427982273348055556214818 +
  97142617910342598647204516893989422179826088076852 +
  87783646182799346313767754307809363333018982642090 +
  10848802521674670883215120185883543223812876952786 +
  71329612474782464538636993009049310363619763878039 +
  62184073572399794223406235393808339651327408011116 +
  66627891981488087797941876876144230030984490851411 +
  60661826293682836764744779239180335110989069790714 +
  85786944089552990653640447425576083659976645795096 +
  66024396409905389607120198219976047599490197230297 +
  64913982680032973156037120041377903785566085089252 +
  16730939319872750275468906903707539413042652315011 +
  94809377245048795150954100921645863754710598436791 +
  78639167021187492431995700641917969777599028300699 +
  15368713711936614952811305876380278410754449733078 +
  40789923115535562561142322423255033685442488917353 +
  44889911501440648020369068063960672322193204149535 +
  41503128880339536053299340368006977710650566631954 +
  81234880673210146739058568557934581403627822703280 +
  82616570773948327592232845941706525094512325230608 +
  22918802058777319719839450180888072429661980811197 +
  77158542502016545090413245809786882778948721859617 +
  72107838435069186155435662884062257473692284509516 +
  20849603980134001723930671666823555245252804609722 +
  53503534226472524250874054075591789781264330331690
  n
end


def e14(limit)
  longest_chain = []
  (limit).downto(1) do |n|
    chain = [n]
    while n>1
      n = (n%2==0) ? (n/2) : ((3*n) + 1)
      chain << n
    end
    if chain.size > longest_chain.size
      longest_chain = chain
    end
  end
  puts "start: %d\nchain: %d\n(%s)" % [longest_chain.first, longest_chain.size, longest_chain.join(', ')] 
end

def binomial_coefficient(n,k)
  fac(n) / (fac(k) * fac(n-k))
end

def monotonic_path_combinations(grid_size)
  n = grid_size
  binomial_coefficient(2*n, n)
end

def e15(n)
  monotonic_path_combinations(n)
end


def num_as_words(n)
  num_words = %w{ one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen }
  ten_words = %w{ twenty thirty forty fifty sixty seventy eighty ninety }

  words = ''

  if n == 0
    # do nothing
  elsif n < 20
    words << num_words[n - 1]
  elsif n < 100 
    a = n / 10
    b = n % 10
    words << ten_words[a - 2]
    words << '-' + num_as_words(b) if b>0 
  elsif n < 1000
    a = n / 100 
    b = n % 100 
    words << num_words[a - 1] + ' hundred'
    words << ' and ' + num_as_words(b) if b>0 
  elsif n < 10_000
    a = n / 1000
    b = n % 1000
    words << num_words[a - 1] + ' thousand'
    words << ' ' + num_as_words(b) if b>0 
  end 

  words
end

def e17(max)
  chars = 0 
  (1..max).each do |n| 
    s = num_as_words(n)
    puts s
    chars += s.gsub(/[ -]+/,'').length
  end 
  puts "Characters: #{chars}"
end


def is_leap_year?(y)
  (y%4==0 and !(y%100==0 unless y%400==0))
end

def e19
  sundays_on_the_first = 0
  wdays = 1
  mdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  (1900..2000).each do |y|
    mdays[1] = is_leap_year?(y) ? 29 : 28
    mdays.each do |days|
      if wdays%7 == 0 and y>1900
        sundays_on_the_first += 1
      end
      wdays += days
    end
  end
  puts sundays_on_the_first
end


def e18
  t0 = "
  1
  1 2
  1 1 2
  9 1 1 2
  1 1 2 1 1
  1 2 1 1 1 1
  1 1 1 1 1 1 1
  "

  t1 = "
  3
  7 5
  2 4 6
  8 5 9 3"

  t2 = "
  75
  95 64
  17 47 82
  18 35 87 10
  20 04 82 47 65
  19 01 23 75 03 34
  88 02 77 73 07 63 67
  99 65 04 28 06 16 70 92
  41 41 26 56 83 40 80 70 33
  41 48 72 33 47 32 37 16 94 29
  53 71 44 65 25 43 91 52 97 51 14
  70 11 33 28 77 73 17 78 39 68 17 57
  91 71 52 38 17 14 91 43 58 50 27 29 48
  63 66 04 68 89 53 67 30 73 16 69 87 40 31
  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"

  t = t2
  t = t.strip.split(/\n/).collect {|line| line.strip.split(/ /).collect {|s| s.to_i } }

  # Faster algorithm
  (t.length-1).downto(1) do |r|
    (t[r].length-1).times do |c|
      t[r-1][c] += t[r][c,2].max
    end
  end

  t[0][0]

=begin
  n = 2
  r = t.length - 1
  permutations = (0...(n**r)).collect {|n| n.to_s(2).rjust(r+1).gsub(/ /,'0').split(//).collect {|s| s.to_i } }

  max = 0
  permutations.each do |p1|
    sum = j = 0
    # arr = []
    p1.each_with_index do |p2,i|
      j += p2
      sum += t[i][j]
    end
    # sum = arr.sum
    # puts "%s: %s (%d)" % [p1.join, arr.join(', '), sum]
    if sum>max
      max = sum
    end
  end
=end

end


def fac(n)
  (1..n).inject(1) {|p,n| p*=n }
end

def e20
  n = fac(100)
  n.to_s.split(//).inject(0) {|sum,s| sum += s.to_i }
end


def proper_divisors(n)
  divisors = [1]
  divisor = 2
  max = n
  loop do
    break if divisor >= max
    if n%divisor == 0
      quotient = n/divisor
      divisors << divisor
      if quotient > divisor
        divisors << quotient
        max = quotient
      end
    end
    divisor += 1
  end
  divisors
end

def e21
  amicable = []
  (1...10_000).each do |a|
    next if amicable.include?(a)
    b = proper_divisors(a).sum
    if a != b and a == proper_divisors(b).sum
      amicable += [a,b]
      puts "#{a} & #{b}"
    end
  end
  amicable.sum
end


def word_score(word)
  score = 0
  word.downcase.each_byte do |c|
    score += (c - 96)
  end
  score
end

def e22
  i = 0
  total = 0
  IO.foreach('data/names3.txt') do |line|
    i += 1
    name = line.chomp
    score = word_score(name)
    total += (i * score)
    puts "%10s: %4d x %3d = %d" % [name, i, score, i*score]
  end
  puts total
end


def abundant?(n)
  proper_divisors(n).sum > n
end

def abundants(max)
  sieve = Array.new(max, nil)

  (12..max).each do |i|
    next if sieve[i]
    d = proper_divisors(i).sum
    if d>=i
      j = i
      sieve[j] = true unless d==i
      loop do
        j += i
        break if j > max
        sieve[j] = true
      end
    end
  end

  abundant = []
  sieve.each_index do |i|
    abundant << i if sieve[i]
  end
  abundant
end


def e23
  max = 28123
  # max = 20
  abund = abundants(max)
  sieve = Array.new(max, nil)

  abund.each_with_index do |x,i|
    (i .. (abund.size-1)).each do |j|
      y = abund[j]
      z = x + y
      break if z > max
      sieve[z] = true
    end
  end

=begin
  unsummable = []
  sieve.each_index do |i|
    unsummable << i unless sieve[i]
  end
  return unsummable
=end

#=begin
  unsummable = 0
  sieve.each_index do |i|
    unsummable += i unless sieve[i]
  end
  unsummable
#=end
end


def permutations()
  p = []
  n = 3
  (0...n).each do |i|
    (0...n).each do |j|
      next if j==i
      (0...n).each do |k|
        next if k==i or k==j
        p << i.to_s + j.to_s + k.to_s
      end
    end
  end
  p
end

def e24
end


def e25(digits)
  i = a = b = 1 
  loop do
    if a.to_s.length >= digits
      puts "%d: %d" % [i,a]
      puts "Has #{digits} digits"
      break
    end
    a,b = b,a+b
    i += 1
  end
end


def recurrence(n)
  recurrence = nil
  (1..14).each do |i|
    pow = (10 ** i)
    chk = (n * (pow - 1))
    # puts "%s: %s" % [chk, (chk % 1  === 0)]
    if chk % 1  === 0
      recurrence = chk.to_i
      break
    end
  end
  recurrence
end

=begin
def e26
  max = 0
  cur = nil

  (2..999).each do |n|
    m = (1.0/n)
    r = recurrence(m)
    if r.to_s.size > max
      max = r.to_s.size
      cur = n
    end
  end

  m = (1.0/cur)
  r = recurrence(m)
  puts "1/%d: %s (%d digit recurrence)" % [cur, m, r.to_s.size] if r
end
=end

def coprime(m,n)
  return m.gcd(n) == 1
end

def totient(n)
  totatives = 0
  (1..n).each do |i|
    totatives += 1 if coprime(i,n)
  end
  totatives
end

def mord(n)
  mord = nil
  (1..(n-1)).each do |i|
    if (10 ** i) % n == 1
      mord = i
      break
    end
  end
  mord
end

def period(n)
  if coprime(n,10)
    return [0, mord(n)]
  end
  (1..(n-1)).each do |i|
    (1..(n-1)).each do |j|
      a = 10 ** i
      b = 10 ** (i+j)
      if (a - b) % n == 0
        return [i,j]
      end
    end
  end
end

def e26
  cur = 0
  max = 0
  (2..999).each do |n|
    m = (1.0/n)
    f = prime_factors(n).uniq

    has2 = f.include?(2)
    has5 = f.include?(5)
    hasX = (f.select {|i| i!=2 and i!=5 }.size > 0)

    if hasX
      p = period(n)
      if p[1] > max
        max = p[1] 
        cur = n
      end
      puts "1/%d: %s (%s) %d" % [n, m, p.join(', '), (coprime(n,10) ? 1:0) ]
    end
  end
  cur
end


def e27
  a = 1
  b = 0
  # n = 0
  # loop do
  (0..40).each do |n|
    m = (n ** 2) + (a * n) + b
    # break unless is_prime?(m)
    puts "%s %3s: %d" % [(is_prime?(m) ? 'x':'.'), n,m]
    n += 1
  end
end


def e28(size)
  spiral = Array.new(size)
  spiral.each_index do |i|
    spiral[i] = Array.new(size)
  end

  size.times do |r|
    size.times do |c|
      spiral[r][c] = "#{r},#{c}"
    end
  end

  r = c = size/2
  min = size/2 - 1
  max = size/2 + 1
  dir = 1
  (1..size*size).each do |n|
    puts "%d,%d: %d" % [r,c,n]
    spiral[r][c] = n
    if dir == 1
      if c<max
        c += 1
      else
        if r<max
          r += 1
        else
          c -= 1
          dir *= -1
          max += 1
        end
      end
    else
      if c>min
        c -= 1
      else
        if r>min
          r -= 1
        else
          c += 1
          dir *= -1
          min -= 1
        end
      end
    end
  end

  sum = 0
  size.times do |n|
    sum += spiral[n][n]
    sum += spiral[n][(size - 1 - n)] if n!=(size/2)
  end
  sum
end


def e29(n)
  terms = []
  (2..n).each do |i|
    term = i
    (n-1).times do |j|
      terms << term *= i
    end
  end
  terms.uniq.length
end


def e30(pow)
  total = 0
  (2..1_000_000).each do |n|
    digits = n.to_s.split(//).collect {|d| d.to_i }
    sum = digits.inject(0) {|acc,d| acc + (d**pow) }
    if n == sum
      puts n
      total += n
    end
  end
  total
end


def e34(limit)
  total = 0
  factorials = (0..9).collect {|n| fac(n) }
  (3..limit).each do |n|
    digits = n.to_s.split(//).collect {|d| d.to_i }
    sum = digits.inject(0) {|acc,d| acc + factorials[d] }
    if n == sum
      puts n
      total += n
    end
  end
  total
end


def is_circular?(prime)
  s = prime.to_s
  return false if s.length>1 and s =~ /[024568]/
  circular = true
  s.length.times do |n|
    p = (s[-n,n] + s[0,s.length-n]).to_i
    circular = false if not is_prime?(p)
  end
  circular
end

def sieve_of_eratos(max)
  sieve = (2..max).to_a
  (2..Math.sqrt(max)).each do |i|
    next unless sieve.include?(i)
    sieve.delete_if {|j| j>i and j%i == 0 }
  end
  sieve
end

def e35(max)
  primes = sieve_of_eratos(max)
  primes = primes.select {|p| is_circular?(p) }
  puts primes.length
  primes
end


def triangle_number(n)
  m = Integer((n/2.0) * (n+1))
end

def triangle_numbers_upto(max)
  triangles = []
  i = 0
  loop do
    i += 1
    n = triangle_number(i)
    break if n > max
    triangles << n
  end
  triangles
end

def is_pandigital?(n)
  s = n.to_s
  m = s.size
  m <= 9 and s.split(//).sort.join == (1..m).to_a.join
end

def e41
  max = 987654321
  min = 123456789
  n = max
  loop do
    if is_pandigital?(n) and is_prime?(n)
      puts n
      break
    end
    break if n < min
    n -= 2
  end
=begin
  n = 987654321
  loop do
    puts n if is_pandigital?(n)
    break if n.to_s.size < 9
    # break if is_prime?(n) and is_pandigital?(n)
    n -= 1
  end
  n
=end
end


def e42
  max = 192
  triangles = triangle_numbers_upto(max)
  triangle_words = 0
  IO.foreach('data/words2.txt') do |line|
    word = line.chomp
    score = word_score(word)
    if triangles.include?(score)
      puts "%10s: %4d" % [word, score]
      triangle_words += 1
    end
  end
  puts triangle_words
end


def is_truncatable_prime?(n)
  return if not is_prime?(n)
  prime = true
  s = n.to_s
  (0...(s.length-1)).each do |i|
    prime = false if not is_prime?(s[0..i].to_i)
    prime = false if not is_prime?(s[-(i+1)..-1].to_i)
  end
  prime
end

def e37
  n = 11
  sum = 0
  found = 0
  loop do
    break if found >= 11
    if is_truncatable_prime?(n)
      puts n
      sum += n
      found += 1
    end
    if is_truncatable_prime?(n+2)
      puts n+2
      sum += (n + 2)
      found += 1
    end
    n += 6
  end
  sum
end


def polygon_num(s,n)
  Integer((((s-2)*(n*n)) - ((s-4)*n)) / 2.0)
end
def polygon_num_undo(s,n)
  a = s-2
  b = s-4
  (Math.sqrt((8*a*n) + (b*b)) + b) / (2*a)
end
def is_polygon_num?(s,n)
  polygon_num_undo(s,n)%1 == 0
end

def e45
  i = 285
  loop do
    i += 1
    t = polygon_num(3,i)
    if is_polygon_num?(5,t) and is_polygon_num?(6,t)
      puts t
      break
    end
  end
end


def e48(max)
  sum = 0
  (1..max).each do |n|
    sum += n ** n
  end
  puts sum
  puts "last ten digits: #{sum.to_s[-10,10]}"
end


def fac(n)
  return if n<0
  f = 1
  (1..n).inject(1) {|f,i| f*=i }
end

def com(n,r)
  return if r>n
  fac(n) / (fac(r) * fac(n-r))
end

def e53
  millions = 0
  (23..100).each do |i|
    (1..i).each do |j|
      c = com(i,j)
      if c > 1_000_000
        # puts "%d,%d: %d" % [i,j,c]
        millions += 1
      end
    end
  end
  millions
end


class Hand
  @@ranks = %w{ 2 3 4 5 6 7 8 9 T J Q K A }
  @@suits = %w{ S H D C }

  def initialize(hand)
    hand = hand.split(/ /) if hand.is_a?(String)
    @count = {}
    @@ranks.each {|c| @count[c] = 0 }
    @@suits.each {|c| @count[c] = 0 }
    hand.each do |card|
      rank,suit = card.split(//)
      @count[rank] += 1
      @count[suit] += 1
    end
  end

  def rank
    score = 0
    rank = nil
    if self.flush? and self.straight? and @count['A']>0
      rank = 'Royal Flush'
      score = 10_000_000
    elsif self.flush? and self.straight?
      rank = 'Straight Flush'
      score = 9_000_000
    elsif self.of_a_kind==4
      rank = 'Four of a Kind'
      score = 8_000_000
    elsif self.of_a_kind==3 and self.pairs==1
      rank = 'Full House'
      score = 7_000_000 + self.score_of_a_kind
    elsif self.flush?
      rank = 'Flush'
      score = 6_000_000
    elsif self.straight?
      rank = 'Straight'
      score = 5_000_000
    elsif self.of_a_kind==3
      rank = 'Three of a Kind'
      score = 4_000_000 + self.score_of_a_kind
    elsif self.pairs==2
      rank = 'Two Pairs'
      score = 3_000_000 + self.score_pairs
    elsif self.pairs==1
      rank = 'One Pair'
      score = 2_000_000 + self.score_pairs
    else
      rank = 'High Card'
      score = 1_000_000
    end
    [rank, (score + score_for_rank(highest_rank))]
  end
  
  def score
    self.rank[1]
  end

  def score_for_rank(rank)
    @@ranks.index(rank)
  end

  def score_pairs
    score = 0
    @@ranks.each {|s| score += score_for_rank(s) if @count[s] == 2 }
    score * 1000
  end

  def score_of_a_kind
    max = 0
    rank = nil
    @@ranks.each do |s| 
      if @count[s] > max
        max = @count[s]
        rank = s
      end
    end
    score = score_for_rank(rank)
    score * 1000
  end

  def pairs
    pairs = 0
    @@ranks.each {|s| pairs += 1 if @count[s] == 2 }
    pairs
  end

  def of_a_kind
    max = 0
    @@ranks.each {|s| max = [max,@count[s]].max }
    max
  end
  
  def highest_rank
    max = 0
    @@ranks.reverse.each do |s| 
      if @count[s] > 0
        max = s
        break
      end
    end
    max
  end

  def flush?
    flush = false
    @@suits.each {|s| flush = true if @count[s] == 5 }
    flush
  end
  
  def straight?
    in_a_row = 0
    @@ranks.each do |r|
      in_a_row = (@count[r]==1) ? in_a_row+1 : 0
      break if in_a_row == 5
    end
    (in_a_row == 5)
  end
end

def e54
  p1win = 0
  hands = IO.readlines('data/poker.txt').collect do |line|
    cards = line.strip.split(/ /)
    p1 = Hand.new(cards[0..4])
    p2 = Hand.new(cards[-5..-1])
    if p1.score > p2.score
      p1win += 1
    end
  end
  p1win
end


def is_lychrel?(n)
  lychrel = true
  50.times do
    n = n + n.to_s.reverse.to_i
    if is_palindromic?(n)
      lychrel = false
      break
    end
  end
  lychrel
end

def e55(max)
  count = 0
  (1..max).each do |n|
    if is_lychrel?(n)
      puts n
      count += 1
    end
  end
  count
end


def e59
  # Printable ascii character range is 32 - 126
  ascii = IO.readlines('data/cipher1.txt').first.strip.split(',').collect {|s| s.to_i }

=begin
  mins = [255,255,255]
  maxs = [0,0,0]
  ascii.each_with_index do |n,i|
    i %= 3
    mins[i] = n if n<mins[i]
    maxs[i] = n if n>maxs[i]
  end
  puts mins.join(",")
  puts maxs.join(",")
=end

=begin
  sets = [[],[],[]]
  ascii[0..300].each_with_index do |n,i|
    sets[i%3] << n
  end
  
  'abcdefghijklmnopqrstuvwxyz'.each_byte do |m|
    puts "A %3d: %s" % [m, sets[0].collect {|n| n ^ m }.pack('c*')]
    puts "B %3d: %s" % [m, sets[1].collect {|n| n ^ m }.pack('c*')]
    puts "C %3d: %s" % [m, sets[2].collect {|n| n ^ m }.pack('c*')]
    puts  
  end
=end
  
  key = 'god'.unpack('c*')
  
  sum = 0
  decrypted = []
  ascii.each_with_index do |n,i|
    new_ascii = (n ^ key[i%3])
    decrypted << new_ascii
    sum += new_ascii
  end
  puts decrypted.pack('c*')

  sum
end


def e67
  t = IO.readlines('data/triangle.txt').collect {|line| line.strip.split(/ /).collect {|s| s.to_i } }

  (t.length-1).downto(1) do |r|
    (t[r].length-1).times do |c|
      t[r-1][c] += t[r][c,2].max
    end
  end

  t[0][0]
end


def num_as_roman(n)
  unit_numerals = %w{ I II III IV V VI VII VIII IX }
  tens_numerals = %w{ X XX XXX XL L LX LXX LXXX XC }
  hund_numerals = %w{ C CC CCC CD D DC DCC DCCC CM }

  roman = ''

  if n == 0
    # do nothing
  elsif n < 10
    roman << unit_numerals[n - 1]
  elsif n < 100
    a = n / 10
    b = n % 10
    roman << tens_numerals[a - 1] + num_as_roman(b)
  elsif n < 1000
    a = n / 100 
    b = n % 100 
    roman << hund_numerals[a - 1] + num_as_roman(b)
  elsif n < 10_000
    a = n / 1000
    b = n % 1000
    roman << ('M' * a) + num_as_roman(b)
  end 

  roman
end

def parse_roman(r)
  numerals = {'I'=>1, 'V'=>5, 'X'=>10, 'L'=>50, 'C'=>100, 'D'=>500, 'M'=>1000}
  decimal = a = b = 0
  r.upcase.split(//).reverse.each do |c|
    a = numerals[c]
    if a<b
      a = -a
    else
      b = a
    end
    decimal += a
  end
  decimal
end

def e89
  saved = 0
  IO.foreach('data/roman.txt') do |line|
    r = line.chomp
    n = parse_roman(r)
    m = num_as_roman(n)
    c = r.length - m.length
    saved += c
    puts "%6d: %18s %18s (%d)" % [n,r,m,c]
  end
  puts saved
end


def e145(max)
  min = (max > 1_000) ? 1_000 : 1
  count = (min > 1) ? 120 : 0
  (min...max).each do |num|
    next if num%10 == 0
    rev = num.to_s.reverse.to_i
    str = (num + rev).to_s
    if str =~ /^[13579]+$/
      puts "#{num} + #{rev} = #{str}"
      count += 1
    end
  end
  count
end


def e206
  series = "1234567890".split(//)
  min = Math.sqrt(series.join('0').to_i).floor
  max = Math.sqrt(series.join('9').to_i).ceil
  n = min
  loop do
    break if n > max
    m = n*n
    if m.to_s =~ /1.2.3.4.5.6.7.8.9.0/
      puts "#{n}: #{m}" 
      break
    end
    n += 10
  end
end

