class Rover

  attr_reader :x
  attr_reader :y
  attr_reader :orientation
  
  @@map_orientation_to_deg = {"N" => 0, "W" => 90, "S" => 180, "E" => 270} #Mapping orientation to degree wrt +ve Y axis and positive in anticlockwise direction
  @@map_deg_to_orientation = {0 => "N", 90 => "W", 180 => "S", 270 => "E"} #Reverse mapping of degrees to orientation
  @@map_orientation_to_movement = {"N" => [0, 1], "W" => [-1, 0], "S" => [0, -1], "E" => [1, 0]} #Mapping orientation to motion

  def initialize(x = 0, y = 0, orientation = "N")
    raise "Not a valid configuration" if x.class != Fixnum || y.class != Fixnum || orientation.length != 1 || !orientation[/[NEWS]/]
    @x = x #x-coordinate of the rover
    @y = y #y-coordinate of the rover
    @orientation = orientation
  end

  def rotate(degree) # rotates the rover by 'degree' degrees, degree must be a multiple of 90.
    
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
  
  def move(max_x, max_y, min_x = 0, min_y = 0) # moves the rover by 1 unit in the current direction, if the rover remains inside the boundaries
    
    raise "Dimensions not valid!" if max_x < min_x || max_y < min_y
    raise "Dimensions must be integers!" if max_x.class != Fixnum || max_y.class != Fixnum || min_x.class != Fixnum || min_y.class != Fixnum 
    
    new_x = @x + @@map_orientation_to_movement[@orientation][0]
    new_y = @y + @@map_orientation_to_movement[@orientation][1]
    if(new_x.between?(min_x,max_x) && new_y.between?(min_y,max_y))
      @x = new_x
      @y = new_y
    end
  end

  def give_commands(commands, max_x, max_y, min_x = 0, min_y = 0) # parses the commands string and calls move and rotate accordingly
    
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