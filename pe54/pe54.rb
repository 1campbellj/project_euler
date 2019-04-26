require_relative 'hand_rank'

f = File.open(File.join(File.dirname(__FILE__), 'p054_poker.txt'))

wins = 0
f.each_line do |line|
  player_1_hand = HandRank.new(line[0..13].strip)
  player_2_hand = HandRank.new(line[14..line.length].strip)

  wins += 1 if player_1_hand > player_2_hand
end

puts wins
