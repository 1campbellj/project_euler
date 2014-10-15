require 'prime'

sum = 0
Prime::instance.each(2000000).each do |p|
  sum += p
end

puts sum