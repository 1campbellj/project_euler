require 'prime'

ans = 0
i = 1

Prime::instance.each(1000000).each do |p|
  if i == 10001
    ans = p
    break
  end
  i += 1
end

puts ans