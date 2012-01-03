class Cell
  attr_reader :neighbours

  def initialize(alive = false)
    @alive = alive
    @neighbours = []
  end

  def alive?
    @alive
  end

  def should_live?
    living_neighbours = @neighbours.inject(0) do |result, neighbour|
      result += 1 if neighbour.alive?
      result
    end
    return true if alive? && (2..3) === living_neighbours
    return true if !alive? && 3 == living_neighbours
    false
  end

  def prepare
    @should_be_alive = should_live?
  end

  def evolve
    @alive = @should_be_alive
  end

  def befrend(neighbour)
    @neighbours << neighbour unless @neighbours.include? neighbour
  end
end
