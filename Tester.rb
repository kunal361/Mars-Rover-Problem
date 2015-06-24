require "./Rover.rb"
require "test/unit"
 
class TestRover < Test::Unit::TestCase

  def test_init
    
    ################################################################################
    rover = Rover.new(1,2,"N")
    ################################################################################
    assert_raise RuntimeError do
      rover = Rover.new(1.1,2,"NE")
    end
    ################################################################################

  end
  def test_rotate

    ################################################################################
    rover = Rover.new(1,2,"N")
    rover.rotate(90)
    assert_equal("1 2 W", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(1,2,"N")
    rover.rotate(-90)
    assert_equal("1 2 E", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(1,2,"N")
    rover.rotate(-900)
    assert_equal("1 2 S", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    assert_raise RuntimeError do
      rover = Rover.new(1,2,"N")
      rover.rotate(-125)
    end
    ################################################################################
    assert_raise RuntimeError do
      rover = Rover.new(1,2,"N")
      rover.rotate(-12.5)
    end
    ################################################################################

  end

  def test_move

    ################################################################################
    rover = Rover.new(1,2,"N")
    rover.move(5,5,0,0)
    assert_equal("1 3 N", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    assert_raise RuntimeError do
      rover = Rover.new(1,2,"N")
      rover.move(0,0,5,5)
    end
    ################################################################################

  end

  def test_give_commands
    
    ################################################################################
    rover = Rover.new(1,2,"N")
    rover.give_commands("LMLMLMLMM",5,5)
    assert_equal("1 3 N", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(3,3,"E")
    rover.give_commands("MMRMMRMRRM",5,5)
    assert_equal("5 1 E", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(0,0,"N")
    rover.give_commands("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",10,10)
    assert_equal("0 10 N", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(0,0,"N")
    rover.give_commands("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMRMMMMM",10,10)
    assert_equal("5 10 E", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    rover = Rover.new(10,10,"N")
    rover.give_commands("MRMLMLM",10,10)
    assert_equal("9 10 W", "#{rover.x} #{rover.y} #{rover.orientation}")
    ################################################################################
    assert_raise RuntimeError do
      rover = Rover.new(10,10,"N")
      rover.give_commands("MRMLSLM",10,10)
    end
    ################################################################################

  end

end