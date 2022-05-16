class Game
  attr_accessor :board

  def initialize
    @board = Array.new(3) { Array.new(3) }
  end

  def start_game
    @players = Array.new(2) { nil }
    @players.length.times do |i|
      puts "Hello Player #{i + 1}! Insert your name below here:"
      name = gets.chomp
      @players[i] = Player.new(name)
    end
  end
end

class Player
  def initialize(name) 
    @name = name
  end
end

class Round
end

new_game = Game.new
new_game.start_game
