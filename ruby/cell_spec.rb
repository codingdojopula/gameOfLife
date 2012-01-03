require 'rspec'
require_relative 'cell'

describe Cell do
  def dead_neighbour
    Cell.new
  end

  def alive_neighbour
    Cell.new(true)
  end

  def check_state_before_and_after_evolving(state)
    subject.should_live?.should == state
    subject.prepare
    subject.evolve
    subject.alive?.should == state
  end

  it "should be dead by default" do
    subject.alive?.should == false
  end

  it "should be able to initialize alive" do
    living = Cell.new(true)
    living.alive?.should == true
  end

  it "should accept neighbours" do
    2.times { subject.befrend dead_neighbour }
    subject.neighbours.size.should == 2
  end

  context "when dead" do
    it "should expect to remain dead when underpopulated" do
      2.times { subject.befrend dead_neighbour }
      2.times { subject.befrend alive_neighbour }
      check_state_before_and_after_evolving false
    end

    it "should expect to remain dead when overpopulated" do
      2.times { subject.befrend dead_neighbour }
      4.times { subject.befrend alive_neighbour }
      check_state_before_and_after_evolving false
    end

    it "should become alive with 3 living neighbours" do
      2.times { subject.befrend dead_neighbour }
      3.times { subject.befrend alive_neighbour }
      check_state_before_and_after_evolving true
    end
  end

  context "when alive" do
    subject { Cell.new(true) }

    it "should expect to die when underpopulated" do
      2.times { subject.befrend dead_neighbour }
      1.times { subject.befrend alive_neighbour }
      check_state_before_and_after_evolving false
    end

    it "should expect to die when overpopulated" do
      2.times { subject.befrend dead_neighbour }
      4.times { subject.befrend alive_neighbour }
      check_state_before_and_after_evolving false
    end

    it "should continue to live with 2 living neighbours" do
      2.times { subject.befrend dead_neighbour }
      2.times { subject.befrend alive_neighbour }
      check_state_before_and_after_evolving true
    end

    it "should continue to live with 3 living neighbours" do
      2.times { subject.befrend dead_neighbour }
      3.times { subject.befrend alive_neighbour }
      check_state_before_and_after_evolving true
    end
  end
end
