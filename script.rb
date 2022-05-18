class Game
  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
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
      @players.each_index do |index|
        round.print_round(index)
        mark_indexes = round.get_indexes
        @board = round.place_mark(mark_indexes)
      end
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

  def print_round(index)
    puts "Round #{@@round_instances}"
    puts "It's #{@players[index].name}'s turn!\n\n"
    puts "#{show_board}\n\n"
    puts "#{@players[0].name}: X"
    puts "#{@players[1].name}: O"
    puts 'Type one of the numbers on screen to place your markdown here:'
  end

  def get_pos
    position = gets.chomp
    if position.length == 1 && position.match?(/[1-9]/)
      position.to_i
    else
      puts "Invalid answer! Try again."
      get_pos
    end
  end

  def search_indexes(element)
    arr_indexes = nil
    @board.each_index do |i|
      @board[i].each_index do |j|
        arr_indexes = [i, j] if element == @board[i][j]
      end
    end
    arr_indexes
  end

  def get_indexes
    position = get_pos
    position_indexes = search_indexes(position)
    if position_indexes.nil?
      puts 'An mark already has been placed on this position! Try other number.'
      get_indexes
    else
      position_indexes
    end
  end

  def place_mark(arr_indexs)
    @board[arr_indexs[0]][arr_indexs[1]] = '$'
    @board
  end
end

Game.new
