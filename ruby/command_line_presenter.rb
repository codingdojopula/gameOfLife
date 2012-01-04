require 'optparse'
require 'ostruct'
require 'rbconfig'

require_relative "cell"
require_relative "colony"
require_relative "cartesian_address"

class CommandLinePresenter
  def initialize(colony, height, width)
    @colony = colony
    @height = height
    @width = width
  end

  def present
    loop do
      begin
        draw
        @colony.evolve
        sleep 0.1
      rescue SystemExit, Interrupt
        break
      end
    end
  end

  private

  def draw
    out = ""
    (1..@height).each do |x|
      (1..@width).each do |y|
        out << (@colony.population["#{x}-#{y}"].alive? ? "o" : " ")
      end
      out << "\n"
    end
    clean_screen
    print out
  end

  def clean_screen
    command = (RbConfig::CONFIG['host_os'] =~ /.*(win|mingw).*/ ? "cls" : "clear")
    system command
  end
end

# read height and width from command line arguments
options = OpenStruct.new
option_parser = OptionParser.new do |setup|
  setup.banner = "Usage: command_line_presenter [OPTIONS]"

  options.height = 25
  setup.on('-h', '--height [height]', Integer, 'Set height of the colony') { |height| options.height = height }

  options.width = 75
  setup.on('-w', '--width [width]', Integer, 'Set width of the colony') { |width| options.width = width }

  setup.on_tail('-?', '--help', 'Display this screen') do
    puts setup
    exit
  end
end

begin
  option_parser.parse!
rescue OptionParser::InvalidOption => e
  puts e
  puts option_parser
  exit
end

# build the colony
colony = Colony.new(CartesianAddress)
(1..options.height).each do |x|
  (1..options.width).each do |y|
    cell = colony.occupy [x, y], Random.rand(100) > 50 ? true : false
  end
end

# show colony evolution
presenter = CommandLinePresenter.new(colony, options.height, options.width)
presenter.present
