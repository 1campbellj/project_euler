ones = %w(one two three four five six seven eight nine)
specials = %w(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
tens = %w(twenty thirty forty fifty sixty seventy eighty ninety)
h = "hundred"

total = 0
ones.each do |i|
  total += i.length
  puts i
end

specials.each do |i|
  total += i.length
  puts i
end

#20, 30, 40...
tens.each do |i|
  total +=  i.length
  puts i
  #21, 22, 23...
  ones.each do |j|
    total += i.length + j.length
    puts i + j
  end
end

ones.each do |i|
  #100, 200...
  total += i.length + h.length
  puts i + h
  #101, 102...
  ones.each do |j|
    total += i.length + h.length + j.length + "and".length
    puts i + h + "and" + j
  end
  #110, 111, 112...
  specials.each do |j|
    total += i.length + h.length + j.length + "and".length
    puts i + h + "and" + j
  end
  #120, 130, 140...
  tens.each do |j|
    total += i.length + h.length + j.length + "and".length
    puts i + h + "and" + j
    ones.each do |k|
      total += i.length + h.length + j.length + k.length + "and".length
      puts i + h + "and" + j + k
    end
  end
end

puts "onethousand"
total += "onethousand".length

puts total 