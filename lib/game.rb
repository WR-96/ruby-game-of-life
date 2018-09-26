require './lib/board.rb'

# Controls game play
class Game < Board
  attr_accessor :board

  def next_generation
    cells_changed = []
    @board.each do |row|
      row.each do |cell|
        old_status = cell.alive?
        check_rules(cell)

        cells_changed.push(cell) unless old_status == cell.alive?
      end
    end

    cells_changed.each { |cell| notify_status(cell) }
  end

  def notify_status(cell)
    cell.neighbors.each do |position|
      neighbor = @board[position[:row]][position[:column]]
      cell.alive? ? neighbor.nearby += 1 : neighbor.nearby -= 1
    end
  end

  def kill(cell)
    cell.status = false if cell.alive?
  end

  def revive(cell)
    cell.status = true unless cell.alive?
  end

  def check_rules(cell)
    if cell.alive?
      kill(cell) if cell.nearby <= 1 || cell.nearby >= 4
    elsif cell.nearby == 3
      revive(cell)
    end
  end
end
