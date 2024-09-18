require './lib/board'

class Game
  def initialize
    @board = Board.new
    @current_player = 'X'
  end

  def play(column)
    if @board.drop_piece(column, @current_player)
      if @board.check_winner(@current_player)
        display_message("Player #{@current_player} wins!")
        return true  # End the game
      else
        switch_player
        false  # Continue the game
      end
    else
      display_message("Column is full or invalid. Try another one.")
      false  # Continue the game
    end
  end

  def start
    display_message("Welcome to Connect Four!")
    display_board

    game_loop
  end

  private

  def game_loop
    loop do
      display_message("Player #{@current_player}, enter a column number (0-6) to drop your piece:")
      column = get_player_input

      if column.nil?
        display_message("Invalid input. Please enter a number between 0 and 6.")
        next
      end

      if play(column)
        display_board
        break  # End the game
      else
        display_board
      end
    end
  end

  def get_player_input
    input = gets.chomp
    return nil unless input.match?(/\A\d+\z/)

    column = input.to_i
    (0..6).include?(column) ? column : nil
  end

  def display_board
    @board.grid.each do |row|
      row.each do |cell|
        print cell.nil? ? '.' : cell
        print ' '
      end
      puts
    end
    puts "0 1 2 3 4 5 6"  # Display column numbers for player reference
  end

  def display_message(message)
    puts message
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end
end

# Run the game when this file is executed
if __FILE__ == $0
  Game.new.start
end