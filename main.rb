require_relative "lib/display"

Display.prompt_name("X")
Display.display_board([[" ", " ", " "],
                       [" ", " ", " "], [" ", " ", " "]])
Display.prompt_move("X")
Display.display_board([["X", " ", "O"],
                       [" ", "X", " "], [" ", " ", "X"]])
