require_relative './poker_hands'

class Hand
  include PokerHands

  attr_reader :cards

  def initialize(cards)
    raise "must have five cards" if cards.count < 5
    @cards = cards
  end

  def self.winner(hands)
    hands.sort.last
  end

  def trade_cards(old_cards, new_cards)
    discard_cards(old_cards)
    @cards += new_cards
    raise 'must have five cards' if @cards.count < 5


  end

  def to_s

  end

  private
  def sort!

  end

  def take_cards(cards)
    @cards
  end

  def discard_cards(old_cards)
    old_cards.each do |discard|
      raise "cannot discard unowned card" unless @cards.include?(discard)
      @cards.each do |card|
        if discard == card
          @cards.delete(card)
        end
      end
    end

  end

  def has_cards?(old_cards)

  end
end
