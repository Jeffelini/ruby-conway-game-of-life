require_relative 'automatons'

# Conway's game of life is a cellular automaton devised by the mathematician John Conway.
# We're doing this to practice Ruby, but co-pilot has been doing it for me.
class ConwayGameOfLife
  # attr_accessor :board

  def initialize(initial_board = nil)
    @board = initial_board.nil? ? Array.new(10) { Array.new(10, 0) } : initial_board
    puts "Board initialized #{@board}"
  end

  def print_board
    puts "
        -----Printing board-----
        "
    @board.each do |row|
      printed_row = row.map { |cell| cell.zero? ? '.' : "\u25A0" }
      puts printed_row.join(' ')
    end
  end

  def get_num_neighbors(row, col)
    num_neighbors = 0
    (-1..1).each do |i|
      (-1..1).each do |j|
        next if i.zero? && j.zero?

        if row + i >= 0 && row + i < @board.length && col + j >= 0 && col + j < @board[0].length
          num_neighbors += @board[row + i][col + j]
        end
      end
    end
    num_neighbors
  end

  def tick
    new_board = @board.map(&:dup)
    new_board.each_with_index do |row, i|
      row.each_with_index do |_cell, j|
        num_neighbors = get_num_neighbors(i, j)
        if @board[i][j] == 1
          if num_neighbors < 2
            new_board[i][j] = 0
          elsif num_neighbors > 3
            new_board[i][j] = 0
          end
        elsif num_neighbors == 3
          new_board[i][j] = 1
        end
      end
    end
    @board = new_board
    system('clear') # Clear the console
    print_board # Print the new board
    sleep(0.1) # Wait for 0.5 seconds
  end
end

game = ConwayGameOfLife.new(GOSPER_GUN)
game.print_board
loop do
  game.tick
end
