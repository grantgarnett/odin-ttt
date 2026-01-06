# This module contains all of the necessary functions
# for displaying the game board and prompting the user.
module Display
  def self.prompt_name(player_type)
    puts "Name of Player #{player_type}: "
    gets.chomp
  end

  def self.prompt_move(player_type)
    puts "\nIndicate your next move by row and column (for example, b3)"
    puts "Player #{player_type}, make your move.\n"
  end

  def self.display_row_index(index)
    case index
    when 0
      print "a - "
    when 1
      print "b - "
    when 2
      print "c - "
    end
  end

  def self.display_board(game_state)
    # Game state is an array of three 3x3 arrays

    print "\n    1 2 3\n"
    print "   -------\n"

    game_state.each_with_index do |row, index|
      display_row_index(index)

      row.each do |element|
        print "#{element} "
      end
      print "-\n"
    end

    print "   -------\n"
  end

  def self.display_winner(game_winner)
    puts "#{game_winner} got the win."
  end
end
