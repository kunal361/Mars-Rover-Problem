require "./Rover.rb"
def main
  puts "Enter plateau Dimensions:"
  done = false
  while !done
    begin
      dimensions = gets.chomp.split(" ")
      raise RuntimError if dimensions[0]!~ /^\d+$/ || dimensions[1]!~ /^\d+$/
      raise RuntimError if dimensions.size != 2
      max_x = dimensions[0].to_i
      max_y = dimensions[1].to_i
      done = true
      raise RuntimeError if max_x == nil || max_y == nil
    rescue
      puts "Enter Valid Plateau Dimensions:"
      done = false
    end
  end
  while true
    puts "Enter x, y, orientation: "
    line1 = gets.chomp.split
    done = false
    while !done
      begin
        break if line1.size == 0
        done = true
        raise RuntimeError if line1.size != 3
        raise RuntimError if line1[0]!~ /^\d+$/ || line1[1]!~ /^\d+$/ || line1[2].length != 1 || line1[2]!~ /^[NEWS]/
        x = line1[0].to_i
        y = line1[1].to_i
        raise RuntimError if x > max_x || y > max_y || x < 0 || y < 0
        orientation = line1[2]
      rescue
        done = false
        puts "Enter valid x, y, orientation: "
        line1 = gets.chomp.split
      end
    end
    break if line1.size == 0
    done = false
    puts "Enter commands: "
    while !done
      begin
        done = true
        line2 = gets.chomp
        raise RuntimError if line2[/[^LRM]+$/]
      rescue
        done = false
        puts "Enter valid commands: "
      end
    end
    rover = Rover.new(x, y, orientation)
    rover.give_commands(line2, max_x, max_y)
    puts "#{rover.x} #{rover.y} #{rover.orientation}"
  end
end

main