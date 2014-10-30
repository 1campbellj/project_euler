champ = ""
i = 1
while champ.length < 1000000 do 
  champ += i.to_s
  i += 1
end

puts champ[10].to_i * champ[10-1].to_i * champ[100-1].to_i * champ[1000-1].to_i * champ[10000-1].to_i * champ[100000-1].to_i * champ[1000000-1].to_i