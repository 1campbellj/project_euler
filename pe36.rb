
def isPalindrome?(n)
  s = n
  len = s.length
  (0..len).each do |i|
    if len%2 == 0 && len/2 == i
      return true
    elsif i >= len/2
      return true
    elsif s[i] != s[len-i-1]
      return false
    end
  end
end

results = []
(1..999999).each do |i|
  if isPalindrome?(i.to_s)
    b2 = i.to_s(2)
    if isPalindrome?(b2)
      results << [i, b2]
    end
  end
end

sum = 0
results.each do |i| 
  puts i.to_s
  sum += i[0]
end
puts sum
