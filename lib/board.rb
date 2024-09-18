class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def drop_piece(column, piece)
    return false unless valid_column?(column)

    row = lowest_available_row(column)
    return false if row.nil?  # Column is full

    @grid[row][column] = piece
  end

  def check_winner
    # code
  end

  private

  def valid_column?(column)
    column.between?(0, 6)
  end

  def lowest_available_row(column)
    (0..5).reverse_each do |row|  # Start from the bottom row (5) to the top row (0)
      return row if @grid[row][column].nil?
    end
    nil  # Return nil if the column is full
  end
end
