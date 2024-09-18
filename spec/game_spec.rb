require 'spec_helper'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'creates a new game with an empty board and sets the first player to X' do
      expect(game.instance_variable_get(:@board).grid).to eq(Array.new(6) { Array.new(7) })
      expect(game.instance_variable_get(:@current_player)).to eq('X')
    end
  end

  describe '#play' do
    context 'when the move is valid' do
      it 'places a piece in the board and switches the player' do
        game.play(0)
        expect(game.instance_variable_get(:@board).grid[5][0]).to eq('X')
        expect(game.instance_variable_get(:@current_player)).to eq('O')
      end
    end

    context 'when a win is detected' do
      it 'identifies a horizontal win' do
        4.times { |i| game.play(i) }
        expect(game.play(4)).to be true
      end

      it 'identifies a vertical win' do
        4.times { game.play(0) }
        expect(game.play(0)).to be true
      end

      it 'identifies a diagonal win (bottom-left to top-right)' do
        game.play(0)
        game.play(1)
        game.play(1)
        game.play(2)
        game.play(2)
        game.play(2)
        game.play(3)
        expect(game.play(3)).to be true
      end

      it 'identifies a diagonal win (bottom-right to top-left)' do
        game.play(3)
        game.play(2)
        game.play(2)
        game.play(1)
        game.play(1)
        game.play(0)
        game.play(0)
        expect(game.play(0)).to be true
      end
    end

    context 'when the move is invalid' do
      it 'does not allow a move in a full column' do
        6.times { game.play(0) }
        expect(game.play(0)).to be false
      end
    end
  end
end