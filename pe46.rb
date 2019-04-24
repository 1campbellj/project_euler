require 'prime'
require 'set'

primes = Prime.first(1000).to_set

solutions = {}
for num in 9..10000 do
  next if num % 2 == 0 # skip evens
  next if primes.include?(num)
  sum = 0
  solutions[num] = false
  primes.to_a.each do |prime|
    break if prime > num
    break if sum == num
    for square in 1..num do
      sum = prime + (2 * square * square)
      if sum == num
        solutions[num] = "#{num} = #{prime} + 2 * #{square}**2"
        break
      elsif sum > num
        break
      end
    end
  end
end

solutions.map { |k, v| puts k unless v}