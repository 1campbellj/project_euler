def collatz_length(n)
  result = 1
  while n > 1
    if n%2 == 0
      n = n/2
    else
      n = 3*n + 1
    end
    result += 1
  end
  return result
end

puts collatz_length(13)

max_len = 0
start = 0
(1..999999).each do |i|
  len = collatz_length(i)
  if len > max_len
    max_len = len
    start = i
  end
end

puts start