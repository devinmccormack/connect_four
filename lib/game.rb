class Game
  attr_reader :current_player

  def initialize
    @board = Board.new
    @current_player = 'X'
  end

  def play(column)
    # Check if the move is valid (i.e., the column isn't full)
    if @board.grid[0][column] # Top row has something, column is full
      return false
    else
      # Drop the piece
      @board.drop_piece(column, @current_player)
      
      # Switch player
      switch_player
    end
  end

  private

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end
end