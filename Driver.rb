require "./Rover.rb"
def main
  max_x, max_y = gets.chomp.split.map{ |dimen| 
    dimen.to_i
  }
  while true
    line1 = gets.chomp.split
    break if line1.size == 0
    line2 = gets.chomp
    x = line1[0].to_i
    y = line1[1].to_i
    orientation = line1[2]
    rover = Rover.new(x, y, orientation)
    rover.give_commands(line2, max_x, max_y)
    puts "#{rover.x} #{rover.y} #{rover.orientation}"
  end
end

main