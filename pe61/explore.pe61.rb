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

%i[p3 p4 p5 p6 p7 p8].each do |fn|
  str = ''
  for n in 1..5
    str += method(fn).call(n).to_s + ', '
  end
  puts str
end

%i[p3 p4 p5 p6 p7 p8].each do |fn|
  start = 0
  fin = 0

  n = 1
  pn = method(fn).call(1)
  while pn.to_s.length <= 4
    start = n if start == 0 && pn.to_s.length == 4

    n += 1
    pn = method(fn).call(n)
  end
  fin = n - 1

  puts "#{fn} n Range: #{start}..#{fin} or #{fin - start} numbers"
  puts "#{fn} Pn Range: #{method(fn).call(start)}..#{method(fn).call(fin)}"
end
