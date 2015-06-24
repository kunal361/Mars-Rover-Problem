class Rover

  attr_reader :x
  attr_reader :y
  attr_reader :orientation
  
  @@map_orientation_to_deg = {"N" => 0, "W" => 90, "S" => 180, "E" => 270}
  @@map_deg_to_orientation = {0 => "N", 90 => "W", 180 => "S", 270 => "E"}
  @@map_orientation_to_movement = {"N" => [0, 1], "W" => [-1, 0], "S" => [0, -1], "E" => [1, 0]}

  def initialize(x = 0, y = 0, orientation = "N")
    raise "Not a valid configuration" if x.class != Fixnum || y.class != Fixnum || orientation.length != 1 || !orientation[/[NEWS]/]
    @x = x
    @y = y
    @orientation = orientation
  end

  def rotate(degree)
    
    raise "Not a valid rotation, as #{degree} is not a multiple of 90!" if degree%90 != 0
    raise "Not a valid rotation, as #{degree} is not an Integer!" if degree.class != Fixnum
    
    current_deg = @@map_orientation_to_deg[@orientation]
    new_deg = current_deg + degree
    while new_deg >= 360
      new_deg -= 360
    end
    while new_deg < 0
      new_deg += 360
    end
    @orientation = @@map_deg_to_orientation[new_deg]
  end
  
  def move(max_x, max_y, min_x = 0, min_y = 0)
    
    raise "Dimensions not valid!" if max_x < min_x || max_y < min_y
    raise "Dimensions must be integers!" if max_x.class != Fixnum || max_y.class != Fixnum || min_x.class != Fixnum || min_y.class != Fixnum 
    
    new_x = @x + @@map_orientation_to_movement[@orientation][0]
    new_y = @y + @@map_orientation_to_movement[@orientation][1]
    if(new_x.between?(min_x,max_x) && new_y.between?(min_y,max_y))
      @x = new_x
      @y = new_y
    end
  end

  def give_commands(commands, max_x, max_y, min_x = 0, min_y = 0)
    
    raise "Invalid Rover, lies outside plateau!" if !@x.between?(min_x,max_x) || !@y.between?(min_y,max_y)
    
    command_number = 0
    number_of_commands = commands.size
    while command_number < number_of_commands
      command = commands[command_number]
      case command
        when 'L'
          rotate 90
        when 'R'
          rotate -90
        when 'M'
          move(max_x,max_y,min_x,min_y)
        else
          raise "Invalid Input: Required one of ['L', 'R', 'M'], found #{command}."
      end
      command_number +=1
    end
  end
end