set = {}

(2..100).each do |a|
  (2..100).each do |b|
    set[a**b] = 1
  end
end

puts set.keys.size