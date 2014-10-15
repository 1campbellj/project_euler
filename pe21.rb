def sum_divisors(n)
  sum = 0
  limit = n/2
  (1..limit).each do |i|
    if n%i == 0 && i != n
      sum += i
    end
  end
  sum
end

def is_amicable(n)
  k = sum_divisors(n)
  if n == sum_divisors(k) && k != n
    return k
  else
    return nil
  end
end

sum = 0
skip = {}
(1..9999).each do |i|
  next if skip[i] == "skip"
  t = is_amicable(i)
  if t
    sum += i + t
    puts "#{i} #{t}"
    skip[t] = "skip"
  end
end

puts sum