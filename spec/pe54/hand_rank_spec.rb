require_relative '../../pe54/hand_rank'

RSpec.describe HandRank, 'HandRank' do
  it 'creates a hand' do
    h = HandRank.new('5H 6H 9D QS 3D')

    expect(h.cards.length).to eq 5
    expect(h.cards.first.value).to eq 5
  end

  it 'finds flush' do
    h = HandRank.new('5H 6H 7H 8H 9H')
    h1 = HandRank.new('5C 6H 7H 8H 9H')

    expect(h.flush?).to be_truthy
    expect(h1.flush?).not_to be_truthy
  end

  it 'finds a straight' do
    h = HandRank.new('5H 6H 7H 8H 9H')
    h1 = HandRank.new('5C 5H 7H 8H 9H')

    expect(h.straight?).to be_truthy
    expect(h1.straight?).not_to be_truthy
  end

  it 'finds a straight flush' do
    h = HandRank.new('5H 6H 7H 8H 9H')
    h1 = HandRank.new('5C 6H 7H 8H 9H')

    expect(h.straight_flush?).to be_truthy
    expect(h1.straight_flush?).not_to be_truthy
  end

  it 'finds a four of a kind' do
    h = HandRank.new('5H 5S 7H 5C 5D')
    h1 = HandRank.new('5C 6H 7H 8H 9H')

    expect(h.four_o_kind?).to be_truthy
    expect(h1.four_o_kind?).not_to be_truthy
  end

  it 'finds a three of a kind' do
    h = HandRank.new('5H 5S 7H 5C 8D')
    h1 = HandRank.new('5C 6H 7H 8H 9H')

    expect(h.three_o_kind?).to be_truthy
    expect(h1.three_o_kind?).not_to be_truthy
  end

  it 'finds a full house' do
    h = HandRank.new('5H 5D QH QS QD')
    h1 = HandRank.new('5H 5D 5C QS QD')
    h2 = HandRank.new('5H 5D 6H 6D 5C')
    h3 = HandRank.new('5H 5D 5C QS KD')
    h4 = HandRank.new('5H 5D 6C QS KD')

    expect(h.full_house?).to be_truthy
    expect(h1.full_house?).to be_truthy
    expect(h2.full_house?).to be_truthy
    expect(h3.full_house?).to be false
    expect(h4.full_house?).to be false
  end

  it 'finds two pair' do
    h = HandRank.new('5H 5D QH QD 6D')
    h1 = HandRank.new('5H 5D Qh 6D 7D')

    expect(h.two_pairs?).to be_truthy
    expect(h1.two_pairs?).not_to be_truthy
  end

  it 'finds a pair' do
    h = HandRank.new('5H 5D Qh 6D 7D')

    expect(h.one_pair?).to be_truthy
  end

  it 'sorts for the highest card' do
    h = HandRank.new('5H 6H 7H AH 9H')

    expect(h.high_card?[:cards]).to eq [5, 6, 7, 9, 14]
  end

  it 'initializes rank of the hand' do
    h = HandRank.new('TH JH QH KH AH')

    expect(h.rank).to eq HandRank::RANK_MAP[:royal_flush]
  end

  it 'compares royal flushes' do
    h = HandRank.new('TH JH QH KH AH')
    h1 = HandRank.new('TD JD QD KD AD')

    expect(h).to be == h1
  end

  it 'compares straight flushes' do
    h = HandRank.new('2H 3H 4H 5H 6H')
    h1 = HandRank.new('3C 4C 5C 6C 7C')

    expect(h)
  end

  it 'compares four_o_kinds based on matched card' do
    h = HandRank.new('TH TD TS TC AS')
    h1 = HandRank.new('TH TD TS TC AS')
    h2 = HandRank.new('9H 9D 9S 9C AS')

    expect(h).to be == h1
    expect(h).to be > h2
  end

  it 'compares four_o_kinds based on single card' do
    h = HandRank.new('TH TD TS TC AS')
    h1 = HandRank.new('TH TD TS TC KS')

    expect(h).to be > h1
  end

  it 'compares full houses' do
    h = HandRank.new('TH TD TS AH AD')
    h1 = HandRank.new('TH TD TS 2H 2D')
    h2 = HandRank.new('9H 9D 9S AS AD')

    expect(h).to be > h1
    expect(h).to be > h2
  end

  it 'compares flush' do
    h = HandRank.new('9H TH JH KH AH')
    h1 = HandRank.new('2H 3H 4H 6H 7H')
    h2 = HandRank.new('9H 9H Th JH KH')
    h3 = HandRank.new('9D TD JD KD AD')

    expect(h).to be > h1
    expect(h).to be > h2
    expect(h).to be == h3
  end

  it 'compares straight' do
    h = HandRank.new('3D 4D 5D 6D 7H')
    h1 = HandRank.new('2D 3D 4D 5D 6H')

    expect(h).to be > h1
  end

  it 'compares three_o_kind' do
    h = HandRank.new('3D 3H 3C JD KS')
    h1 = HandRank.new('2D 2H 2C KD AS')
    h2 = HandRank.new('3D 3H 3S TD QS')
    h3 = HandRank.new('3D 3H 3S TD KS')

    expect(h).to be > h1
    expect(h).to be > h2
    expect(h).to be > h3
  end

  it 'compares two pairs' do
    h = HandRank.new('7D 7C 6D 6C KH')
    h1 = HandRank.new('6D 6C 5D 5C KH')
    h2 = HandRank.new('7D 7C 5D 5C KH')
    h3 = HandRank.new('7D 7C 6D 6C JH')

    expect(h).to be > h1
    expect(h).to be > h2
    expect(h).to be > h3
  end

  it 'compares one pair' do
    h = HandRank.new('KD KC 3C 4D 5C')
    h1 = HandRank.new('QD QC 2C 3D 4C')
    h2 = HandRank.new('KD KC 2C 4D 5C')

    expect(h).to be > h1
    expect(h).to be > h2
  end

  it 'compares high cards' do
    h = HandRank.new('2C 3D 5H JS AS')
    h1 = HandRank.new('2C 3D 5H 6H KS')
    h2 = HandRank.new('3C 4C 5C TS AS')

    expect(h).to be > h1
    expect(h).to be > h2
  end

  it 'solves examples from problem' do
    h1 = HandRank.new('5H 5C 6S 7S KD')
    h2 = HandRank.new('2C 3S 8S 8D TD')
    expect(h2).to be > h1

    h3 = HandRank.new('5D 8C 9S JS AC')
    h4 = HandRank.new('2C 5C 7D 8S QH')
    expect(h3).to be > h4

    h5 = HandRank.new('2D 9C AS AH AC')
    h6 = HandRank.new('3D 6D 7D TD QD')
    expect(h6).to be > h5

    h7 = HandRank.new('4D 6S 9H QH QC')
    h8 = HandRank.new('3D 6D 7H QD QS')
    expect(h7).to be > h8

    h9 = HandRank.new('2H 2D 4C 4D 4S')
    h10 = HandRank.new('3C 3D 3S 9S 9D')
    expect(h9).to be > h10
  end
end
