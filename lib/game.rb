require_relative "display"

# This class contains all of the essential functionality
# for tracking and updating the state of a game of Tic Tac Toe
class Game
  include Display

  attr_reader :game_state, :last_to_play

  def initialize
    @game_state = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    @last_to_play = " "
  end

  def row_to_num(move_row)
    case move_row # rubocop:disable Style/HashLikeCase
    when "a"
      0
    when "b"
      1
    when "c"
      2
    end
  end

  def valid_move?(move)
    (move.length == 2) &&
      (game_state[row_to_num(move[0])][move[1].to_i - 1] == " ")
  rescue StandardError
    false
  end

  def new_move(move, player_type)
    until valid_move?(move)
      puts "Invalid input. Please try again."
      move = Display.prompt_move(player_type)
    end
    game_state[row_to_num(move[0])][move[1].to_i - 1] = player_type
    self.last_to_play = player_type
  end

  def winning_row?
    game_state.each do |row|
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
      ((flat_game_arr[4] == flat_game_arr[0] &&
       flat_game_arr[4] == flat_game_arr[8]) ||
       (flat_game_arr[4] == flat_game_arr[2] &&
       flat_game_arr[4] == flat_game_arr[6]))
  end

  def game_over?
    winning_row? || winning_column? || winning_diagonal?
  end

  private

  attr_writer :game_state, :last_to_play
end
