#If p is the perimeter of a right angle triangle 
# with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
# {20,48,52}, {24,45,51}, {30,40,50}
# For which value of p ≤ 1000, is the number of solutions maximised?

# a**2 + b**2 = c**2
# a  +  b  +  c  = 1000

require 'set'

max = 0
maxPer = 0
for per in 10..1000 do
  s = Set[]
  for a in 1..(per/2) do
    for b in a..(per/2) do
      for c in b..(per/2) do
        next unless a + b + c == per
        next unless a**2 + b**2 == c**2
        triple = [a, b, c].sort
        s.add(triple)
      end
    end
  end
  if s.length > max
    maxPer = per
    max = s.length
    puts "#{maxPer} -> #{max}"
  end
end

puts maxPer
puts max