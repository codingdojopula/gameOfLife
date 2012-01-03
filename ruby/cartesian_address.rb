module CartesianAddress
  include Comparable

  def occupy(coordinates)
    @coordinates = coordinates
  end

  def <=>(anOther)
    @coordinates <=> anOther.coordinates
  end

  def coordinates
    @coordinates
  end

  def address
    @coordinates.join("-")
  end
  alias_method :to_s, :address

  def nearby
    neighbours = get_nearby_coordinates.map do |coordinate|
      neighbour = Object.new
      neighbour.extend CartesianAddress
      neighbour.occupy coordinate
      neighbour
    end
    neighbours
  end

  private

  def get_nearby_coordinates
    axes = @coordinates.map do |coordinate|
      [coordinate - 1, coordinate, coordinate + 1]
    end
    matrix = axes.inject { |result, axis| result.product(axis) || axis }
    coordinates = matrix.map { |element| element.flatten }
    coordinates.delete @coordinates
    coordinates
  end
end
