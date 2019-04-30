require_relative 'card'

class HandRank
  include Comparable

  RANK_MAP = {
    high_card: 0,
    one_pair: 1,
    two_pairs: 3,
    three_o_kind: 4,
    straight: 5,
    flush: 6,
    full_house: 7,
    four_o_kind: 8,
    straight_flush: 9,
    royal_flush: 10
  }.freeze

  attr_reader :cards
  attr_reader :rank
  attr_reader :tie_breaker

  def initialize(hand)
    @cards = hand.split(' ').map { |s| Card.new(s) }

    # each rank determining function will return false
    # if the hand is not that rank, and if true will return
    # a tie breaker object.
    # THE ORDER OF THESE CONDITIONS IS IMPORTANT
    @rank = if royal_flush?
              @tie_breaker = royal_flush?
              RANK_MAP[:royal_flush]
            elsif straight_flush?
              @tie_breaker = straight_flush?
              RANK_MAP[:straight_flush]
            elsif four_o_kind?
              @tie_breaker = four_o_kind?
              RANK_MAP[:four_o_kind]
            elsif full_house?
              @tie_breaker = full_house?
              RANK_MAP[:full_house]
            elsif flush?
              @tie_breaker = flush?
              RANK_MAP[:flush]
            elsif straight?
              @tie_breaker = straight?
              RANK_MAP[:straight]
            elsif three_o_kind?
              @tie_breaker = three_o_kind?
              RANK_MAP[:three_o_kind]
            elsif two_pairs?
              @tie_breaker = two_pairs?
              RANK_MAP[:two_pairs]
            elsif one_pair?
              @tie_breaker = one_pair?
              RANK_MAP[:one_pair]
            elsif high_card?
              @tie_breaker = high_card?
              RANK_MAP[:high_card]
    end
  end

  def <=>(other)
    if @rank > other.rank
      return 1
    elsif rank < other.rank
      return -1
    end

    # TIE BREAKER!!!
    @tie_breaker.each_with_index do |k, i|
      if ((k <=> other.tie_breaker[i]) != 0)
        return k <=> other.tie_breaker[i]
      end
    end
    return 0 
  end

  def royal_flush?
    # dummy tie breaker
    return [1] if flush? && straight? && @cards.any? { |card| card.value == 14 }
    false
  end

  def straight_flush?
    return false unless straight? && flush?

    values = @cards.map(&:value)
    values.sort!
    [values[-1]]
  end

  def four_o_kind?
    values = @cards.map(&:value)

    match = nil
    single = nil
    # hand is size 5, so 0 or 1 index has to be part of the match
    for i in 0..1 do
      if values.count(values[i]) == 4
        match = values[i]
        single = (values - [values[i]])[0]
      end
    end

    return [match, single] if match && single

    false
  end

  def full_house?
    values = @cards.map(&:value)
    values = values.sort

    if values[0] == values[1] && (values[2] == values[3] && values[3] == values[4])
      return [ values[2], values[0] ]
    elsif (values[0] == values[1] && values[1] == values[2]) && values[3] == values[4]
      return [ values[0], values[3] ]
    end

    false
  end

  def flush?
    values = @cards.map(&:value).sort

    suit = @cards.first.suit
    return values.sort.reverse if @cards.all? { |c| c.suit == suit }

    false
  end

  def straight?
    values = @cards.map(&:value)
    values.sort!
    for i in 1..(values.length - 1)
      return false if values[i] != values[i - 1] + 1
    end

    [values[-1]]
  end

  def three_o_kind?
    values = @cards.map(&:value)
    for i in 0..2 do
      # tie breaker is [matches + rest of cards sorted desc]
      return [ values[i], (values - [values[i]]).sort.reverse ].flatten if values.count(values[i]) == 3
    end

    false
  end

  def two_pairs?
    values = @cards.map(&:value).sort

    low_pair = false
    for c in values do
      if values.count(c) == 2
        low_pair = c
        break
      end
    end

    return false unless low_pair

    values -= [c]
    for c in values do
      # tie is [high pair (this match), low pair, rest of cards reverse sorted]
      return [c, low_pair, (values - [c] - [low_pair]).sort.reverse ].flatten if values.count(c) == 2
    end

    false
  end

  def one_pair?
    values = @cards.map(&:value)

    for c in values do
      return [c, (values - [c]).sort.reverse ].flatten if values.count(c) == 2
    end

    false
  end

  def high_card?
    values = @cards.map(&:value)
    values.sort.reverse
  end
end
