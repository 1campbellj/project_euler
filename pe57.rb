def sqrt_2(n)
  return 1 if n == 0

  1 + (1 / (1 + sqrt_2(n - 1).to_r).to_r)
end

sum = 0
for i in 1..1_000
  r = sqrt_2(i)
  sum += 1 if r.numerator.to_s.length > r.denominator.to_s.length
end

puts sum
