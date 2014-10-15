i = 20
a = nil
t = true


while a.nil? do
  (2..20).each do |k|
    unless i%k == 0
      t = false
    end
  end
  if t == true
    a = i
  end
  t = true
  i += 10
end

puts a