result_num = 1
result_denom = 1

(10..99).each do |num|
  (num+1..99).each do |denom|
    next if num >= denom || num%10 + denom%10 == 0
    ns = num.to_s
    ds = denom.to_s
    ns.split("").each do |i|
      new_ds = ds.gsub(i, "")
      if new_ds != ds
        new_ns = ns.gsub(i, "")
        next if new_ds.to_i == 0
        if new_ns.to_f/new_ds.to_f == num.to_f/denom.to_f
          result_num *= num
          result_denom *= denom
          puts "#{num} #{denom}"
        end
      end
    end
  end
end

puts result_num
puts result_denom