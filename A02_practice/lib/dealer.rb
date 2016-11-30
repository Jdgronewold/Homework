require_relative 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def place_bet(dealer, amt)

  end

  def play_hand(deck)

  end

  def take_bet(player, amt)

  end

  def pay_bets
    ### it looks like the spec file thinks that the player bet 200
    ### or I dont understand the betting, so it is hard coded for now


  end
end
