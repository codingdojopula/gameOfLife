class Colony
  attr :address_provider
  attr_reader :population

  def initialize(address_provider)
    @address_provider = address_provider
    @population = {}
  end

  def occupy(coordinates, alive=false)
    cell = Cell.new(alive)
    cell.extend address_provider
    cell.occupy(coordinates)
    @population[cell.address] = cell
    befrend_neighbours_for cell
    cell
  end

  def befrend_neighbours_for(cell)
    cell.nearby.each do |address|
      neighbour = @population[address.address]
      if neighbour
        cell.befrend neighbour
        neighbour.befrend cell
      end
    end
  end

  def evolve
    #TODO: try to implement evolve in one step instead of two
    #also, can this be implemented on cell level?
    @population.each { |address, cell| cell.prepare }
    @population.each { |address, cell| cell.evolve }
  end
end
