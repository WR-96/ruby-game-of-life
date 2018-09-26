# Define new cells
class Cell
  attr_reader :position
  attr_reader :bounds

  attr_writer :status

  attr_accessor :neighbors
  attr_accessor :nearby

  def initialize(position, bounds)
    @position = position
    @status = false
    @nearby = 0
    @bounds = bounds
    @neighbors = []
  end

  def add_neighbor(position)
    @neighbors.push(position)
  end

  def alive?
    @status
  end
end
