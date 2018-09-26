require './lib/cell.rb'
# Board class
class Board
  @board = []
  def initialize(size = 25)
    @size = size
    set_board
    set_neighbors
  end

  def draw_board
    @board.each do |row|
      row.each do |cell|
        print cell.alive? ? "\u25A0 " : '  '
      end
      puts "\n"
    end
    true
  end

  def set_board
    @board = []
    @size.times do |i|
      @board[i] = []

      @size.times do |j|
        @board[i][j] = Cell.new({ row: i, column: j }, constraint(i, j))
      end
    end
    true
  end

  def set_neighbors
    @board.each do |row|
      row.each do |cell|
        add_neighbors(cell)
      end
    end
    true
  end

  def add_neighbors(cell)
    cell.bounds[:upper_row].upto(cell.bounds[:lower_row]) do |i|
      cell.bounds[:first_neighbor].upto(cell.bounds[:last_neighbor]) do |j|
        @board[i][j].add_neighbor(cell.position) unless cell == @board[i][j]
      end
    end
  end

  # Return the bounds of a cell
  def constraint(row, column)
    upper_row = (row - 1).clamp(0, @size - 1)
    lower_row = (row + 1).clamp(0, @size - 1)
    first_neighbor = (column - 1).clamp(0, @size - 1)
    last_neighbor = (column + 1).clamp(0, @size - 1)

    bounds = {
      upper_row: upper_row,
      lower_row: lower_row,
      first_neighbor: first_neighbor,
      last_neighbor: last_neighbor
    }
  end
end
