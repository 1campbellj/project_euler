f1 = 1
f2 = 1
term = 2

while f2.to_s.length != 1000 do
  temp = f1 + f2
  f1 = f2
  f2 = temp
  term += 1
end

puts term