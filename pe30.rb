limit = 355000
results = []
(2..limit).each do |i|
  str = i.to_s
  sum = 0
  (0..str.length-1).each do |j|
    sum += str[j].to_i**5 
  end
  results << i if i == sum
end

puts results.inject(:+)