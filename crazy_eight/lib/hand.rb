

class Hand

  def self.deal_hand(deck)
    current_cards = deck.take(5)
    Hand.new(current_cards)
  end

  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def points
    @cards.inject { |accum, card| accum += card.crazy8_value }
  end

  def draw_until_match(deck, pile_card)

    card = deck.take(1)
    @cards += card
    until card.match?(pile_card)
      card = deck.take(1)
      @cards += card
    end

    play_card(card)

  end


  def empty?
    @cards.empty?
  end

  def draw(deck)
    @cards += deck.take(1)
  end

  def play_card(deck, card)
    deck.discard(card)
    @cards.delete(card)

  end



end
