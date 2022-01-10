
class Api::Robot::OrdersController < ApplicationController

    def command
      unless params[:command].nil?
        @start_commands = "#{params[:command]}".gsub(/\]|\[|\"/,"").strip.split(/\,/)
        @places= @start_commands.shift.strip.split(/\s/)
        @place = @places.shift.strip
        @x = @places.shift.strip.to_i
        @y = @start_commands.shift.strip.to_i
        @face = @start_commands.shift.strip.upcase
        @cmnds = @start_commands
        unless @x > 5 or @y > 5
          robot_placing!
        else
          robot_falling!
        end
      else
        render json: {message: "Please place a order"}
      end
    end

    def robot_placing!
      @cmnds.each do |command|
        command = command.upcase.strip
        case  command
        when "MOVE"
          move_robot
        when "LEFT"
          move_left
        when "RIGHT"
          move_right
        when "REPORT"
          unless @x > 5 or @y > 5
            result_report
          else
            robot_falling!
          end
        end
      end
    end

    def move_robot
      case @face
      when "EAST"
        unless @x > 5 
          @x = @x + 1
        else
          robot_falling!
        end
      when "WEST"
        unless @x < 0
          @x = @x - 1
        else
          robot_falling!
        end
      when "NORTH"
        unless @y > 5 
          @y = @y + 1
        else
          robot_falling!
        end        
      when "SOUTH"
        unless @y < 0
          @y = @y - 1
        else
          robot_falling!
        end
      end
    end

    def move_left
      case @face
      when "EAST"
        @face = "NORTH"
      when "WEST"
        @face = "SOUTH"
      when "NORTH"
        @face = "WEST"
      when "SOUTH" 
        @face = "EAST" 
      end
    end

    def move_right
      case @face
      when "EAST"
        @face = "SOUTH"
      when "WEST"
        @face = "NORTH"
      when "NORTH"
        @face = "EAST"
      when "SOUTH" 
        @face = "WEST" 
      end
    end

    def result_report
      @output = "#{@x},#{@y},#{@face}"
      render json: {Output: @output}
    end

    def robot_falling!
      render json: {Error: "Robot is about to falling! Please change the command"}
    end
end

