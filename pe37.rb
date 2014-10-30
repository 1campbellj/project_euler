require 'prime'

start = 0
limit = 1000000
results = []

Prime.each(limit) do |i|
  next if i < 10
  p = true
  temp_forward = i.to_s
  temp_backward = i.to_s
  while temp_forward.length > 1 && p
    temp_forward[0] = ""
    temp_backward[temp_backward.length - 1] = ""
    p = Prime.prime?( temp_forward.to_i ) && Prime.prime?( temp_backward.to_i ) 
  end
  results << i if p
  break if results.length == 11
end

puts results.to_s
puts results.inject(:+)