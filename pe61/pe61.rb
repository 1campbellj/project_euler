require 'set'

def p3(n)
  n * (n + 1) / 2
end

def p4(n)
  n * n
end

def p5(n)
  n * ((3 * n) - 1) / 2
end

def p6(n)
  n * (n - 1)
end

def p7(n)
  n * ((5 * n) - 3) / 2
end

def p8(n)
  n * ((3 * n) - 2)
end

# p3 n Range: 45..140 or 95 numbers
# p3 Pn Range: 1035..9870
# p4 n Range: 32..99 or 67 numbers
# p4 Pn Range: 1024..9801
# p5 n Range: 26..81 or 55 numbers
# p5 Pn Range: 1001..9801
# p6 n Range: 33..100 or 67 numbers
# p6 Pn Range: 1056..9900
# p7 n Range: 21..63 or 42 numbers
# p7 Pn Range: 1071..9828
# p8 n Range: 19..58 or 39 numbers
# p8 Pn Range: 1045..9976

p3ns = []
p4ns = []
p5ns = []
p6ns = []
p7ns = []
p8ns = []

for p3i in 45..140
  p3ns << p3(p3i)
end
for p4i in 32..99
  p4ns << p4(p4i)
end
for p5i in 26..81
  p5ns << p5(p5i)
end
for p6i in 33..100
  p6ns << p6(p6i)
end
for p7i in 21..63
  p7ns << p7(p7i)
end
for p8i in 19..58
  p8ns << p8(p8i)
end
