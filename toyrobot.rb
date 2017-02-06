class ToyRobot
  def initialize()
    @pos_x = -1
    @pos_y = -1
    @face = ""
    @placed = false
  end
  
  def operate()
    file = File.new('input.txt','r')
    while (line = file.gets)
      open('output.txt','a') do |f|
        f.puts(line)
      end
      command = line.split(" ")
      if (command.size > 0)
        if (command.at(0) === "PLACE")
          placement = command.at(1).split(",")
          if (placement.size == 3)
            place(placement.at(0).to_i,placement.at(1).to_i,placement.at(2))
          end
        elsif (command.at(0) === "MOVE" && @placed)
          move()
        elsif (command.at(0) === "LEFT" && @placed)
          left()
        elsif (command.at(0) === "RIGHT" && @placed)
          right()
        elsif (command.at(0) === "REPORT" && @placed)
          report()
        end
      end
    end
    file.close
  end
  
  def place(pos_x,pos_y,face)
    if (pos_x >= 0 && pos_x < 5 && pos_y >= 0 && pos_y < 5)
      if ["NORTH","EAST","SOUTH","WEST"].include?(face)
        @pos_x = pos_x
        @pos_y = pos_y
        @face = face
        @placed = true
      end
    end
  end
  
  def move()
    if (@face === "NORTH" && @pos_y < 4)
      @pos_y=@pos_y+1
    elsif (@face === "EAST" && @pos_x < 5)
      @pos_x=@pos_x+1
    elsif (@face === "SOUTH" && @pos_y > 0)
      @pos_y=@pos_y-1
    elsif (@face === "WEST" && @pos_x > 0)
      @pos_x=@pos_x-1
    end
  end
  
  def left()
    case @face
    when "NORTH"
      @face = "WEST"
    when "EAST"
      @face = "NORTH"
    when "SOUTH"
      @face = "EAST"
    when "WEST"
      @face = "SOUTH"
    end
  end
  
  def right()
    case @face
    when "NORTH"
      @face = "EAST"
    when "EAST"
      @face = "SOUTH"
    when "SOUTH"
      @face = "WEST"
    when "WEST"
      @face = "NORTH"
    end
  end
  
  def report()
    open('output.txt','a') do |f|
      f.puts("Output: #{@pos_x},#{@pos_y},#{@face}")
    end
  end
  
end