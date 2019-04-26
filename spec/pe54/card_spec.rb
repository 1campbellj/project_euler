require_relative '../../pe54/card'

RSpec.describe Card, "Card" do
  it 'creates a card' do
    c = Card.new('5H')

    expect(c.value).to eq 5
    expect(c.suit).to eq 'H'
  end

  context 'comparison' do
    it 'considers two cards of equal value' do
      c = Card.new('5H')
      c2 = Card.new('5D')

      expect(c).to be == c2
      expect(c).not_to be > c2
      expect(c).not_to be < c2
    end

    it 'considers face cards' do
      c = Card.new('QH')
      c2 = Card.new('5h')
      c3 = Card.new('AS')

      expect(c).to be > c2
      expect(c).to be < c3
    end
  end
end