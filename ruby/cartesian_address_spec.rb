require 'rspec'
require_relative 'cartesian_address'

describe CartesianAddress do
  def address(*coordinates)
    address = Object.new
    address.extend CartesianAddress
    address.occupy coordinates
    address
  end

  it "should expose address" do
    address(3, 4, 5, 6).address.should == "3-4-5-6"
  end

  it "should compare for 2 dimensions" do
    (address(3,5) > address(3,4)).should == true
  end

  it "should compare for 3 dimensions" do
    subject = address(3, 4, 5)
    smaller = address(3, 4, 3)
    (subject > smaller).should == true
  end

  it "should get nearby addresses for 2 dimensions" do
    subject = address(3, 5)
    subject.nearby.should == [
      address(2, 4), address(2, 5), address(2, 6),
      address(3, 4), address(3, 6),
      address(4, 4), address(4, 5), address(4, 6),
      ]
  end

  it "should get nearby addresses for 3 dimensions" do
    subject = address(3, 4, 5)
    subject.nearby.should == [
      address(2, 3, 4), address(2, 3, 5), address(2, 3, 6),
      address(2, 4, 4), address(2, 4, 5), address(2, 4, 6),
      address(2, 5, 4), address(2, 5, 5), address(2, 5, 6),
      address(3, 3, 4), address(3, 3, 5), address(3, 3, 6),
      address(3, 4, 4), address(3, 4, 6),
      address(3, 5, 4), address(3, 5, 5), address(3, 5, 6),
      address(4, 3, 4), address(4, 3, 5), address(4, 3, 6),
      address(4, 4, 4), address(4, 4, 5), address(4, 4, 6),
      address(4, 5, 4), address(4, 5, 5), address(4, 5, 6),
      ]
  end
end
