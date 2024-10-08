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
    true
  end

  def check_winner(piece)
    horizontal_win?(piece) || vertical_win?(piece) || diagonal_win?(piece)
  end

  private

  def valid_column?(column)
    column.between?(0, 6)
  end

  def lowest_available_row(column)
    (0..5).reverse_each do |row|
      return row if @grid[row][column].nil?
    end
    nil  # Return nil if the column is full
  end

  def horizontal_win?(piece)
    @grid.any? do |row|
      row.each_cons(4).any? { |consecutive_pieces| consecutive_pieces.all? { |cell| cell == piece } }
    end
  end

  def vertical_win?(piece)
    @grid.transpose.any? do |column|
      column.each_cons(4).any? { |consecutive_pieces| consecutive_pieces.all? { |cell| cell == piece } }
    end
  end

  def diagonal_win?(piece)
    diagonal_win_left_to_right?(piece) || diagonal_win_right_to_left?(piece)
  end

  def diagonal_win_left_to_right?(piece)
    (0..2).any? do |row|
      (0..3).any? do |col|
        (0..3).all? { |i| @grid[row + i][col + i] == piece }
      end
    end
  end

  def diagonal_win_right_to_left?(piece)
    (0..2).any? do |row|
      (3..6).any? do |col|
        (0..3).all? { |i| @grid[row + i][col - i] == piece }
      end
    end
  end
end
