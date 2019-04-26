class Card
  include Comparable

  attr_reader :value
  attr_reader :suit

  COMPARATOR_MAP = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14,
    't' => 10,
    'j' => 11,
    'q' => 12,
    'k' => 13,
    'a' => 14
  }.freeze

  def initialize(card)
    @value = COMPARATOR_MAP[card[0]]
    @suit = card[1].upcase
  end

  def <=>(other)
    @value <=> other.value
  end
end
