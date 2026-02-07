require_relative "display"

# This class contains all of the essential functionality
# for tracking and updating the state of a game of Tic Tac Toe
class Game
  include Display

  attr_reader :game_state

  def initialize
    @game_state = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    @current_player = "X"
    @other_player = "O"
  end

  def play
    Display.display_board(@game_state)

    until game_over?
      new_move(Display.prompt_move(@current_player))
      Display.display_board(@game_state)
      @current_player, @other_player = @other_player, @current_player
    end
  end

  def row_to_num(move_row)
    case move_row # rubocop:disable Style/HashLikeCase
    when "a" then 0
    when "b" then 1
    when "c" then 2
    end
  end

  def valid_move?(move)
    (move.length == 2) &&
      move[1].to_i.positive? &&
      (@game_state[row_to_num(move[0])][move[1].to_i - 1] == " ")
  rescue StandardError
    false
  end

  def verify_move(move)
    until valid_move?(move)
      puts "Invalid input. Please try again."
      move = Display.prompt_move(@current_player)
    end
  end

  def new_move(move)
    verify_move(move)
    @game_state[row_to_num(move[0])][move[1].to_i - 1] = @current_player
  end

  def winning_row?
    @game_state.each do |row|
      next unless row[0] != " " &&
                  row[0] == row[1] &&
                  row[0] == row[2]

      return true
    end

    false
  end

  def winning_column?
    flat_game_arr = @game_state.flatten

    (0..2).each do |i|
      next unless flat_game_arr[i] != " " &&
                  flat_game_arr[i] == flat_game_arr[i + 3] &&
                  flat_game_arr[i] == flat_game_arr[i + 6]

      return true
    end

    false
  end

  def winning_diagonal?
    flat_game_arr = @game_state.flatten

    flat_game_arr[4] != " " &&
      ((flat_game_arr[0] == flat_game_arr[4] &&
       flat_game_arr[4] == flat_game_arr[8]) ||
       (flat_game_arr[2] == flat_game_arr[4] &&
       flat_game_arr[4] == flat_game_arr[6]))
  end

  def board_full?
    @game_state.all? do |row|
      row.all? { |spot| spot != " " }
    end
  end

  def game_over?
    if winning_row? || winning_column? || winning_diagonal?
      puts "Player #{@current_player} wins!!"
      true
    else
      board_full?
    end
  end
end
