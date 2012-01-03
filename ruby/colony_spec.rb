require 'rspec'
require_relative 'colony'

describe Colony do
  def inhabit_colony(colony, distribution)
    distribution.each_index do |row|
      distribution[row].each_index do |column|
        colony.occupy [row, column], (distribution[row][column] == 1 ? true : false)
      end
    end
  end

  subject { Colony.new(CartesianAddress) }

  it "should keep dead colony dead" do
    inhabit_colony subject, [[0,0,0], [0,0,0], [0,0,0]]
    10.times do
      subject.evolve
      subject.population.each { |coordinates, cell| cell.alive?.should == false }
    end
  end

  it "should keep block alive" do
    inhabit_colony subject, [[0,0,0,0], [0,1,1,0], [0,1,1,0], [0,0,0,0]]
    10.times do
      subject.evolve
      subject.population.each do |coordinates, cell|
        cell.alive?.should == ["1-1", "1-2", "2-1", "2-2"].include?(coordinates)
      end
   end
  end

  it "should keep loaf alive" do
    inhabit_colony subject, [[0,0,0,0,0,0], [0,0,1,1,0,0], [0,1,0,0,1,0], [0,0,1,0,1,0], [0,0,0,1,0,0], [0,0,0,0,0,0]]
    10.times do
      subject.evolve
      subject.population.each do |coordinates, cell|
        cell.alive?.should == ["1-2", "1-3", "2-1", "2-4", "3-2", "3-4", "4-3"].include?(coordinates)
      end
   end
  end

  it "should keep blinker alive" do
    inhabit_colony subject, [[0,1,0], [0,1,0], [0,1,0]]

    10.times do |iteration|
      subject.evolve
      alive = iteration % 2 == 0 ? true : false

      subject.population["0-0"].alive?.should == false
      subject.population["0-1"].alive?.should == !alive
      subject.population["0-2"].alive?.should == false
      subject.population["1-0"].alive?.should == alive
      subject.population["1-1"].alive?.should == true
      subject.population["1-2"].alive?.should == alive
      subject.population["2-0"].alive?.should == false
      subject.population["2-1"].alive?.should == !alive
      subject.population["2-2"].alive?.should == false
    end
  end

  it "should keep beacon alive" do
    inhabit_colony subject, [[0,0,0,0,0,0], [0,1,1,0,0,0], [0,1,0,0,0,0], [0,0,0,0,1,0], [0,0,0,1,1,0], [0,0,0,0,0,0]]
    static = ["1-1", "1-2", "2-1", "3-4", "4-3", "4-4"]
    changing = ["2-2", "3-3"]
    10.times do |iteration|
      subject.evolve
      expected = static
      expected += changing if iteration % 2 == 0
      subject.population.each do |coordinates, cell|
        cell.alive?.should == expected.include?(coordinates)
      end
   end
  end
end
