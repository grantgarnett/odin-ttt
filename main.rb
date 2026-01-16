require_relative "lib/display"
require_relative "lib/game"

current_game = Game.new

until current_game.game_over?
  current_game.new_move(
    Display.prompt_move("X"), "X"
  )
  Display.display_board(current_game.game_state)
  break if current_game.game_over?

  current_game.new_move(
    Display.prompt_move("O"), "O"
  )
  Display.display_board(current_game.game_state)
end
