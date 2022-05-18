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
    loop do
    round = Round.new(@players, @board)
    @players.each_index { |index| round.print_round(index) }
    end
  end
end

class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Round
  @@round_instances = 0
  def initialize(players, board)
    @players = players
    @board = board
    @@round_instances += 1
    
  end

  def show_board
    string_board = ''
    @board.each do |row|
      row.each do |position|
        string_board += " #{position} |"
      end
      string_board.delete_suffix!('|')
      string_board += "\n---+---+---\n"
    end
    string_board.delete_suffix!("\n---+---+---\n")
  end

  def get_coordinate
    puts 'Type the coordinate of your markdown here:'
    coordinate = gets.chomp
    coordinate
  end

  def print_round(index)
    puts "Round #{@@round_instances}"
    puts "It's #{@players[index].name}'s turn!\n\n"
    puts "#{show_board}\n\n"
    puts "#{@players[0].name}: X"
    puts "#{@players[0].name}: O"
    get_coordinate
  end
end

Game.new
