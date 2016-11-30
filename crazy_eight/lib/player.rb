

class Player

  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name, bankroll)
    @name, @bankroll = name, bankroll
  end

  def points
    @hand.points
  end

  def receive_points(other_player)
    @bankroll += other_player.points
  end


  
end
