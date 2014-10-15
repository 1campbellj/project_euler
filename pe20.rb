source = (100).downto(1).inject(:*).to_s

sum = 0
(0..source.length-1).each do |i|
  sum += source[i].to_i
end

puts sum
