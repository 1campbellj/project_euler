sum = 0
sum_sq = 0

(1..100).each do |i|
  sum += i
  sum_sq += i*i
end

sum = sum * sum
puts sum
puts sum_sq

puts sum - sum_sq