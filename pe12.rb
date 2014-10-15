require 'prime'

tri_number = 3
addend = 3
x = 0

def num_divisors(n)
  result = 0
  (1..Math.sqrt(n)).each do |i|
    if n%i == 0
      result += 2
    end
  end
  return result
end

while(num_divisors(tri_number) < 500)
  tri_number += addend
  addend += 1
end

puts tri_number



