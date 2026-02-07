require_relative "../main"

describe Game do
  subject(:tic_tac_toe) { described_class.new }

  let(:display) { instance_double(Display) }

  describe("#play") do
    context "when game_over? is false once" do
      before do
        allow(tic_tac_toe).to receive(:game_over?).and_return(false, true)
        allow(Display).to receive(:display_board).at_least(:once)
        allow(Display).to receive(:prompt_move).at_least(:once)
      end

      it "doesn't loop" do
        expect(tic_tac_toe).to receive(:new_move).once
        tic_tac_toe.play
      end
    end

    context "when game_over? is false twice" do
      before do
        allow(tic_tac_toe).to receive(:game_over?).and_return(false, false, true)
        allow(Display).to receive(:display_board).at_least(:once)
        allow(Display).to receive(:prompt_move).at_least(:once)
      end

      it "loops once" do
        expect(tic_tac_toe).to receive(:new_move).twice
        tic_tac_toe.play
      end
    end

    context "when game_over? is false three times" do
      before do
        allow(tic_tac_toe).to receive(:game_over?).and_return(false, false, false, true)
        allow(Display).to receive(:display_board).at_least(:once)
        allow(Display).to receive(:prompt_move).at_least(:once)
      end

      it "loops twice" do
        expect(tic_tac_toe).to receive(:new_move).exactly(3).times
        tic_tac_toe.play
      end
    end
  end
  describe("#game_over?") do
    context "when a row is full" do
      before do
        allow(tic_tac_toe).to receive(:puts)
        tic_tac_toe.instance_variable_set(:@game_state,
                                          [%w[X X X],
                                           [" ", " ", " "], [" ", " ", " "]])
        tic_tac_toe.instance_variable_set(:@current_player, "X")
      end

      it "outputs a win message" do
        win_message = "Player X wins!!"
        expect(tic_tac_toe).to receive(:puts).with(win_message)
        tic_tac_toe.game_over?
      end

      it "returns true" do
        expect(tic_tac_toe.game_over?).to be true
      end
    end

    context "When a column is full" do
      before do
        allow(tic_tac_toe).to receive(:puts)
        tic_tac_toe.instance_variable_set(:@game_state,
                                          [[" ", "O", " "],
                                           [" ", "O", " "], [" ", "O", " "]])
        tic_tac_toe.instance_variable_set(:@current_player, "O")
      end

      it "outputs a win message" do
        win_message = "Player O wins!!"
        expect(tic_tac_toe).to receive(:puts).with(win_message)
        tic_tac_toe.game_over?
      end

      it "returns true" do
        expect(tic_tac_toe.game_over?).to be true
      end
    end

    context "When a diagonal is full" do
      before do
        allow(tic_tac_toe).to receive(:puts)
        tic_tac_toe.instance_variable_set(:@game_state,
                                          [[" ", " ", "X"],
                                           [" ", "X", " "], ["X", " ", " "]])
        tic_tac_toe.instance_variable_set(:@current_player, "X")
      end

      it "outputs a win message" do
        win_message = "Player X wins!!"
        expect(tic_tac_toe).to receive(:puts).with(win_message)
        tic_tac_toe.game_over?
      end

      it "returns true" do
        expect(tic_tac_toe.game_over?).to be true
      end
    end
  end

  describe("#new_move") do
    context("when given a valid input") do
      before do
        tic_tac_toe.instance_variable_set(:@current_player, "O")
        tic_tac_toe.new_move("b2")
      end
      it "updates the game state correctly" do
        new_game_state = tic_tac_toe.instance_variable_get(:@game_state)
        correct_game_state = [[" ", " ", " "], [" ", "O", " "], [" ", " ", " "]]
        expect(new_game_state).to eq(correct_game_state)
      end
    end
  end

  describe("#valid_move?") do
    context("when given a valid move") do
      it "returns true" do
        valid_move = "c3"
        expect(tic_tac_toe.valid_move?(valid_move)).to be true
      end
    end

    context("when given an invalid move") do
      it "returns false" do
        invalid_move = "d1"
        expect(tic_tac_toe.valid_move?(invalid_move)).to be false
      end

      it "returns false" do
        invalid_move = "a4"
        expect(tic_tac_toe.valid_move?(invalid_move)).to be false
      end

      it "returns false" do
        invalid_move = "2b"
        expect(tic_tac_toe.valid_move?(invalid_move)).to be false
      end

      it "returns false" do
        invalid_move = "$!"
        expect(tic_tac_toe.valid_move?(invalid_move)).to be false
      end
    end
  end
end
