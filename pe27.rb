require 'prime'

def num_quadratic_primes(a, b)
  num = 0
  n = 0
  while Prime.prime?((n*n) + (a*n) + b)
    n += 1
    num += 1
  end
  num
end

max_primes = 0
vals = []

(-999..999).each do |a|
  (-999..999).each do |b|
    primes = num_quadratic_primes(a, b)
    if primes > max_primes
      max_primes = primes
      vals = [a, b]
    end
  end
end

puts max_primes
puts vals.to_s