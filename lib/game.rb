# This class contains all of the essential functionality
# for tracking and updating the state of a game of Tic Tac Toe
class Game
  attr_reader :game_state

  def initialize
    @game_state = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
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
    (game_state[row_to_num(move[0])][move[1].to_i] == " ")
  end

  def new_move(move, player_type)
    if valid_move?(move)
      game_state[row_to_num(move[0])][move[1].to_i] = player_type
    else
      puts "Invalid input. Please try again."
      false
    end
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

  attr_writer :game_state
end
