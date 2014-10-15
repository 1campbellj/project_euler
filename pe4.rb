def isPalindrome?(n)
  s = n.to_s
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

answer = 1
(100..999).each do |i|
  (100..999).each do |j|
    if isPalindrome?(i*j) && i*j > answer
      answer = i*j
    end
  end
end

puts answer