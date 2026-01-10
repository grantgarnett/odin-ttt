require_relative "lib/display"
require_relative "lib/game"

Display.prompt_name("X")
Display.display_board([[" ", " ", " "],
                       [" ", " ", " "], [" ", " ", " "]])
Display.prompt_move("X")
Display.display_board([["X", " ", "O"],
                       [" ", "X", " "], [" ", " ", "X"]])

current_game = Game.new
current_game.new_move("a2", "X")
Display.display_board(current_game.game_state)
puts current_game.game_over?
current_game.new_move("b1", "X")
Display.display_board(current_game.game_state)
puts current_game.game_over?
current_game.new_move("a2", "O")
current_game.new_move("c0", "X")
Display.display_board(current_game.game_state)
puts current_game.game_over?
