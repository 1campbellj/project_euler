def pandigital?(n)
  digits = {}
  (0..n.length-1).each do |i|
    if digits[ n[i] ] || n[i] == "0"
      return false
    else
      digits[ n[i] ] = 1
    end
  end
  ret = true
  (1..9).each do |i|
    ret = false if !digits[i.to_s]
  end
  return ret
end

max_pan = 0

(1..9999).each do |i|
  mult = 1
  concat = ""
  while concat.length < 9
    concat += (i*mult).to_s
    mult += 1
  end

  if concat.length == 9
    if pandigital?(concat)
      max_pan = concat.to_i if concat.to_i > max_pan
    end
  end
end

puts max_pan