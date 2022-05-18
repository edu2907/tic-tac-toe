class Game
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    start_game
  end

  def create_players
    @players = Array.new(2) { nil }
    @players.length.times do |i|
      puts "Hello Player #{i + 1}! Insert your name below here:"
      name = gets.chomp
      @players[i] = Player.new(name)
    end
  end

  def start_game
    create_players
    round = Round.new(@players, @board)
    round.print_round
  end
end

class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Round
  def initialize(players, board)
    @players = players
    @board = board
  end

  def show_board
    string_board = ''
    @board.each do |row|
      row.each do  |position|
        string_board += " #{position} |"
      end
      string_board.delete_suffix!('|')
      string_board += "\n---+---+---\n"
    end
    string_board.delete_suffix!("\n---+---+---\n")
  end

  def get_coordinate
    puts 'Type the coordinate of your markdown here: '
    coordinate = gets.chomp
    coordinate
  end

  def print_round
    puts "Round x\n"
    puts "#{show_board}\n"
    get_coordinate
  end
end

Game.new
