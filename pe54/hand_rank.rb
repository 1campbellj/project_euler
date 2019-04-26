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
    if @rank == RANK_MAP[:royal_flush]
      return 0
    elsif @rank == RANK_MAP[:straight_flush]
      return @tie_breaker <=> other.tie_breaker
    elsif @rank == RANK_MAP[:four_o_kind]
      if @tie_breaker[:match] == other.tie_breaker[:match]
        return @tie_breaker[:single] <=> other.tie_breaker[:single]
      else
        return @tie_breaker[:match] <=> other.tie_breaker[:match]
      end
    elsif @rank == RANK_MAP[:full_house]
      if @tie_breaker[:threes] == other.tie_breaker[:threes]
        return @tie_breaker[:pair] <=> other.tie_breaker[:pair]
      else
        return @tie_breaker[:threes] <=> other.tie_breaker[:threes]
      end
    elsif @rank == RANK_MAP[:flush]
      @tie_breaker[:cards].length.downto(0) do |i|
        if (@tie_breaker[:cards][i] <=> other.tie_breaker[:cards][i]) != 0
          return @tie_breaker[:cards][i] <=> other.tie_breaker[:cards][i]
        end
      end
      return 0
    elsif @rank == RANK_MAP[:straight]
      return @tie_breaker <=> other.tie_breaker
    elsif @rank == RANK_MAP[:three_o_kind]
      if @tie_breaker[:threes] == other.tie_breaker[:threes]
        if (@tie_breaker[:others][1] <=> other.tie_breaker[:others][1]) != 0
          return @tie_breaker[:others][1] <=> other.tie_breaker[:others][1]
        else
          return @tie_breaker[:others][0] <=> other.tie_breaker[:others][0]
        end
      else
        @tie_breaker[:threes] <=> other.tie_breaker[:threes]
      end
    elsif @rank == RANK_MAP[:two_pairs]
      if @tie_breaker[:high_pair] == other.tie_breaker[:high_pair]
        if @tie_breaker[:low_pair] == other.tie_breaker[:low_pair]
          return @tie_breaker[:other] <=> other.tie_breaker[:other]
        else
          return @tie_breaker[:low_pair] <=> other.tie_breaker[:low_pair]
        end
      else
        return @tie_breaker[:high_pair] <=> other.tie_breaker[:high_pair]
      end
    elsif @rank == RANK_MAP[:one_pair]
      if @tie_breaker[:pair] == other.tie_breaker[:pair]
        @tie_breaker[:others].length.downto(0) do |i|
          if (@tie_breaker[:others][i] <=> other.tie_breaker[:others][i]) != 0
            return @tie_breaker[:others][i] <=> other.tie_breaker[:others][i]
          end
        end
        return 0
      else
        return @tie_breaker[:pair] <=> other.tie_breaker[:pair]
      end
    elsif @rank == RANK_MAP[:high_card]
      @tie_breaker[:cards].length.downto(0) do |i|
        if (@tie_breaker[:cards][i] <=> other.tie_breaker[:cards][i]) != 0
          return @tie_breaker[:cards][i] <=> other.tie_breaker[:cards][i]
        end
      end
      return 0
    end
  end

  def royal_flush?
    flush? && straight? && @cards.any? { |card| card.value == 14 }
  end

  def straight_flush?
    return false unless straight? && flush?

    values = @cards.map(&:value)
    values.sort!
    values[-1]
  end

  def four_o_kind?
    for i in 0..(@cards.length - 1) do
      dup = @cards.dup
      single = dup.delete_at(i)
      if dup.all? { |c| c == dup.first }
        return { match: dup.first, single: single }
      end
    end

    false
  end

  def full_house?
    values = @cards.map(&:value)
    values = values.sort

    if values[0] == values[1] && (values[2] == values[3] && values[3] == values[4])
      return { threes: values[2], pair: values[0] }
    elsif (values[0] == values[1] && values[1] == values[2]) && values[3] == values[4]
      return { threes: values[0], pair: values[3] }
    end

    false
  end

  def flush?
    values = @cards.map(&:value).sort
    tie = { cards: values }

    return tie if @cards.all? { |c| c.suit == 'H' }
    return tie if @cards.all? { |c| c.suit == 'D' }
    return tie if @cards.all? { |c| c.suit == 'C' }
    return tie if @cards.all? { |c| c.suit == 'S' }

    false
  end

  def straight?
    values = @cards.map(&:value)
    values.sort!
    for i in 1..(values.length - 1)
      return false if values[i] != values[i - 1] + 1
    end

    values[-1]
  end

  def three_o_kind?
    values = @cards.map(&:value)
    for i in 0..2 do
      return { threes: values[i], others: (values - [values[i]]).sort } if values.count(values[i]) == 3
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
      return { high_pair: c, low_pair: low_pair, other: values - [c] - [low_pair] } if values.count(c) == 2
    end

    false
  end

  def one_pair?
    values = @cards.map(&:value)

    for c in values do
      return { pair: c, others: (values - [c]).sort } if values.count(c) == 2
    end

    false
  end

  def high_card?
    values = @cards.map(&:value)
    values.sort!

    { cards: values }
  end
end
