require_relative './card'
require_relative './hand'

class Deck
  def self.all_cards
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def deal_hand
    new_cards = take(5)
    Hand.new(new_cards)
  end

  def count
    @cards.size
  end

  def take(n)
    raise "not enough cards" if n > count
    @cards.shift(n)

  end

  def return(cards)
    @cards += cards
  end

  def shuffle
    @cards.shuffle!
  end
end
