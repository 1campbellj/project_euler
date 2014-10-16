abundant_numbers = []

def sum_divisors(n)
  sum = 0
  limit = n/2
  (1..limit).each do |i|
    if n%i == 0
      sum += i
    end
  end
  sum
end

def abundant?(n)
  sum_divisors(n) > n
end

(0..28123).each do |i|
  abundant_numbers << i if abundant?(i)
end

sums = {}

abundant_numbers.each do |i|
  abundant_numbers.each do |j|
    sums[i+j] = 1
  end
end

total_sum = 0
(1..28123).each do |i|
  if sums[i] != 1
    total_sum += i
  end
end

puts total_sum