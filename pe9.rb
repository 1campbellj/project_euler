(1..250).each do |m|
  (1..250).each do |n|
    if n >= m
      next
    end
    a = m*m - n*n
    b = 2*m*n
    c = m*m + n*n
    if a + b+ c == 1000
      puts a
      puts b
      puts c
      puts a*b*c
    end
  end
end