require 'prime'

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

ans = 0

987654321.downto(2).each do |i|
  if Prime.prime?(i)
    if pandigital?(i.to_s)
      puts i
      break
    end
  end
end
