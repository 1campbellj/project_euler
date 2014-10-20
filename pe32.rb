def pandigital?(a, b)
  prod = a*b
  digits = {}
  a = a.to_s
  b = b.to_s
  prod = prod.to_s
  nums = [a, b, prod]
  nums.each do |n|
    (0..n.length-1).each do |i|
      if digits[ n[i] ] || n[i] == "0"
        return false
      else
        digits[ n[i] ] = 1
      end
    end
  end
  ret = true
  (1..9).each do |i|
    ret = false if !digits[i.to_s]
  end
  return ret
end

pan = {}

(1..10000).each do |i|
  (1..10000).each do |j|
    if i != j && ( (i.to_s.length == 3 && j.to_s.length == 2)|| (i.to_s.length==4 && j.to_s.length == 1))
      if pandigital?(i, j)
        puts "#{i}, #{j}"
        pan[i*j] = [i, j] 
        puts pan.keys.to_s
      end
    end
  end
end

puts pan.to_s
puts pan.keys.inject(:+)