require "./Rover.rb"
require "test/unit"
 
class TestRover < Test::Unit::TestCase
 
  def test_simple
    ################################################################################
    rover = Rover.new(1,2,"N")
    rover.move("LMLMLMLMM",5,5)
    assert_equal("1 3 N", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(3,3,"E")
    rover.move("MMRMMRMRRM",5,5)
    assert_equal("5 1 E", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(0,0,"N")
    rover.move("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",10,10)
    assert_equal("0 10 N", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(0,0,"N")
    rover.move("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMRMMMMM",10,10)
    assert_equal("5 10 E", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(10,10,"N")
    rover.move("MRMLMLM",10,10)
    assert_equal("9 10 W", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
  end
end