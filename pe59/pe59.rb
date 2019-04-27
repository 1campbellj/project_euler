f = File.open(File.join(File.dirname(__FILE__), 'p059_cipher.txt'))

cipher = ''
f.each_line do |line|
  cipher = line
end

possible_keys = []
cipher = cipher.split(',').map(&:to_i)

(0..cipher.length - 1).step(3) do |i|
  possible_keys << [cipher[i] ^ 't'.ord, cipher[i + 1] ^ 'h'.ord, cipher[i + 2] ^ 'e'.ord]
end

message = ''
possible_keys.each do |key|
  message = ''
  (0..cipher.length - 1).step(3) do |i|
    begin
      a = (cipher[i] ^ key[0])
      b = (cipher[i + 1] ^ key[1])
      c = (cipher[i + 2] ^ key[2])
      message += a.chr
      message += b.chr
      message += c.chr
    rescue StandardError
    end
  end
  break if message.include?('An extract taken from')
end

sum = 0
message.chars.each do |c|
  sum += c.ord
end

puts sum
