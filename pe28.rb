size = 1001
val = 1
sum = 1
step = 2
iteration = 0
while val <= size*size
  if iteration == 4
    iteration = 0
    step += 2
  end
  iteration += 1
  val += step
  sum += val if val <= size*size
  puts val
end

puts sum

