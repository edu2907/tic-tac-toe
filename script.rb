# frozen_string_literal: true
class Game
  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def start
    create_players
    loop do
      end_game = false
      @players.each_index do |player_i|
        round = Round.new(@players, @board)
        round.print_round(player_i)
        mark_indexes = round.get_indexes
        @board = round.place_mark(mark_indexes, player_i)
        if end_game?(@players[player_i], @board)
          end_game = true
          break
        end
      end
      break if end_game
    end
  end

  def create_players
    @players = Array.new(2) { nil }
    @players.length.times do |i|
      puts "Hello Player #{i + 1}! Insert your name below here:"
      name = gets.chomp
      @players[i] = Player.new(name, i)
    end
  end

  def end_game?(player, board)
    condition = false
    if winner?(player, board)
      puts "#{player.name} wins!"
      condition = true
    elsif draw?(board)
      puts 'It\'s a tie!'
      condition = true
    end
    condition
  end

  def horizontal?(win_condition, board)
    condition = false
    board.each do |hor_arr|
      condition = true if hor_arr.join == win_condition
    end
    condition
  end

  def vertical?(win_condition, board)
    condition = false
    board.length.times do |i|
      ver_arr = [board[0][i], board[1][i], board[2][i]]
      condition = true if ver_arr.join == win_condition
    end
    condition
  end

  def diagonal?(win_condition, board)
    condition = false
    diag_arr = [board[0][0], board[1][1], board[2][2]]
    diag_inv_arr = [board[0][2], board[1][1], board[2][0]]
    condition = true if diag_arr.join == win_condition || diag_inv_arr.join == win_condition
    condition
  end

  def winner?(player, board)
    win_condition = player.win_condition
    horizontal?(win_condition, board) || vertical?(win_condition, board) || diagonal?(win_condition, board)
  end

  def draw?(board)
    condition = true
    board.each do |row|
      row.each do |el|
        condition = false if el.is_a?(Integer)
      end
    end
    condition
  end
end

class Player
  attr_reader :name, :mark, :win_condition

  @@marks_list = %w[X O]
  def initialize(name, player_i)
    @name = name
    @mark = @@marks_list[player_i]
    @win_condition = @mark * 3
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
      puts 'Invalid answer! Try again.'
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

  def place_mark(arr_indexs, player_i)
    @board[arr_indexs[0]][arr_indexs[1]] = @players[player_i].mark
    @board
  end
end

Game.new.start
