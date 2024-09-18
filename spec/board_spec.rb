require 'spec_helper'
require './lib/board'

RSpec.describe Board do
  describe '#initialize' do
    it 'creates a 7x6 board' do
      board = Board.new
      expect(board.grid.length).to eq(6)
      expect(board.grid.first.length).to eq(7)
    end

    it 'starts with an empty board' do
      board = Board.new
      expect(board.grid.flatten).to all(be_nil)
    end
  end

  describe '#drop_piece' do
    it 'places a piece in the lowest available row' do
      board = Board.new
      board.drop_piece(1, 'X')  # Player X drops a piece in column 1
      expect(board.grid[5][1]).to eq('X') # Bottom-most row should have the piece
    end

    it 'places subsequent pieces above the first one' do
      board = Board.new
      board.drop_piece(1, 'X')
      board.drop_piece(1, 'O')
      expect(board.grid[4][1]).to eq('O') # Piece O should be placed above piece X
    end
  end

  describe '#check_winner' do
    it 'returns true for a horizontal win' do
      board = Board.new
      4.times { |i| board.drop_piece(i, 'X') } # Drop 4 pieces in row 6
      expect(board.check_winner('X')).to be true
    end

    it 'returns true for a vertical win' do
      board = Board.new
      4.times { board.drop_piece(1, 'X') }  # Drop 4 pieces in column 1
      expect(board.check_winner('X')).to be true
    end

    it 'returns true for a diagonal win (bottom-left to top-right)' do
      board = Board.new
      board.drop_piece(0, 'X')  # Drop at column 0, row 5
      board.drop_piece(1, 'O')  # Add an obstacle piece
      board.drop_piece(1, 'X')  # Drop at column 1, row 4
      board.drop_piece(2, 'O')  # Add another obstacle piece
      board.drop_piece(2, 'O')  # Fill another row
      board.drop_piece(2, 'X')  # Drop at column 2, row 3
      board.drop_piece(3, 'O')  # Add some more obstacles
      board.drop_piece(3, 'O')
      board.drop_piece(3, 'O')
      board.drop_piece(3, 'X')  # Drop at column 3, row 2 to complete the diagonal
      expect(board.check_winner('X')).to be true
    end

    it 'returns true for a diagonal win (bottom-right to top-left)' do
      board = Board.new
      board.drop_piece(3, 'X')  # Drop at column 3, row 5
      board.drop_piece(2, 'O')  # Add an obstacle piece
      board.drop_piece(2, 'X')  # Drop at column 2, row 4
      board.drop_piece(1, 'O')  # Add another obstacle piece
      board.drop_piece(1, 'O')  # Fill another row
      board.drop_piece(1, 'X')  # Drop at column 1, row 3
      board.drop_piece(0, 'O')  # Add some more obstacles
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')  # Drop at column 0, row 2 to complete the diagonal
      expect(board.check_winner('X')).to be true
    end

    describe '#check_winner' do
    it 'returns false if there is no win' do
      board = Board.new
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'X')
      board.drop_piece(2, 'X')
      board.drop_piece(3, 'O')  # This breaks the streak
      expect(board.check_winner('X')).to be false
    end
  end
end
