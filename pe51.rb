require 'prime'
require 'set'

primes = Prime.first(20_000_000)
primeLookup = primes.to_set
should_break = false
for prime_index in 10_000_000..15_000_000
  prime = primes[prime_index]
  next unless prime > 100
  break if should_break
  ps = prime.to_s

  for first_digit in 0..(ps.length - 2) do
    break if should_break
    for second_digit in 1..(ps.length - 1) do
      s = Set[]

      for i in 0..9 do
        next if i == 0 && first_digit == 0
        copy = ps.dup
        copy[first_digit] = i.to_s
        copy[second_digit] = i.to_s
        if primeLookup.include?(copy.to_i) 
          s.add(copy)
        end
        if i - s.length > 2
          break
        end
      end
      if s.length == 8
        puts s.to_s
        should_break = true
        break
      end
    end
  end
end