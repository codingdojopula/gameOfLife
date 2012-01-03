require_relative "cell"
require_relative "colony"
require_relative "cartesian_address"

class CommandLinePresenter
  def initialize(colony)
    @colony = colony
  end

  def draw(height, width)
    out = ""
    (1..height).each do |x|
      (1..width).each do |y|
        out << (@colony.population["#{x}-#{y}"].alive? ? "o" : " ")
      end
      out << "\n"
    end
    system("clear")
    print out
  end
end

WIDTH = 100
HEIGHT = 30
colony = Colony.new(CartesianAddress)
(1..HEIGHT).each do |x|
  (1..WIDTH).each do |y|
    cell = colony.occupy [x, y], Random.rand(100) > 50 ? true : false
  end
end

presenter = CommandLinePresenter.new(colony)
loop do
  begin
    presenter.draw HEIGHT, WIDTH
    colony.evolve
    sleep 0.1
  rescue SystemExit, Interrupt
    break
  end
end
