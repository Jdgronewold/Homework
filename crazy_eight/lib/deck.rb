
class Deck

  def self.create_deck
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck
  end

  attr_reader :deck, :discard
  
  def initialize(deck = Deck.create_deck)
    @deck = deck.shuffle!
    @discard = [@deck.take(1)]

  end

  def shuffle!
    @deck.shuffle!
  end

  def take(n)
    raise "not enough cards" if count < n
    @deck.shift(n)
  end

  def discard(cards)
    @discard += cards
  end



end
