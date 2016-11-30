# Represents a computer Crazy Eights player.
class AIPlayer
  attr_reader :cards

  # Creates a new player and deals them a hand of eight cards.
  def self.deal_player_in(deck)
    cards = deck.take(8)
    AIPlayer.new(cards)

  end

  def initialize(cards)
    @cards = cards
  end

  # Returns the suit the player has the most of; this is the suit to
  # switch to if player gains control via eight.
  def favorite_suit
    hand_suits = @cards.map { |card| card.suit }

    suit_count = hand_suits.map { |suit| hand_suits.count(suit) }

    index = suit_count.find_index(suit_count.max)

    hand_suits[index]
  end

  # Plays a card from hand to the pile, removing it from the hand. Use
  # the pile's `#play` and `#play_eight` methods.
  def play_card(pile, card)
    raise 'cannot play card outside your hand' unless @cards.include?(card)

    if card.value == :eight
      pile.play_eight(card, favorite_suit)
    else
      pile.play(card)
    end

    @cards.delete(card)

  end

  # Draw a card from the deck into player's hand.
  def draw_from(deck)
    @cards += deck.take(1)
  end

  # Choose any valid card from the player's hand to play; prefer
  # non-eights to eights (save those!). Return nil if no possible
  # play. Use `Pile#valid_play?` here; do not repeat the Crazy Eight
  # rules written in the `Pile`.
  def choose_card(pile)
    hold_eights = []

  @cards.each do |card|
    hold_eights << card if card.value == :eight
    next if card.value == :eight
    return card if pile.valid_play?(card)
  end

  unless hold_eights.empty?
    return hold_eights.first
  end

  nil


  end

  # Try to choose a card; if AI has a valid play, play the card. Else,
  # draw from the deck and try again until there is a valid play.
  # If deck is empty, pass.
  def play_turn(pile, deck)
    return nil if deck.empty? && choose_card(pile).nil?

    card = choose_card(pile)
    if card.nil?
      until choose_card(pile) != nil || deck.empty?
        draw_from(deck)
      end

      play_card(pile, choose_card(pile)) unless choose_card(pile).nil?
    else
      play_card(pile, card)

    end






  end



end
