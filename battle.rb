# Battle of wolf and sheep
class Points
	attr_accessor :x, :y
	def initialize x,y
		@x = x;
		@y = y;
	end
	def to_s
		"[#{x},#{y}]"
	end
	def ==(other)
		return true if ( (self.x == other.x) && (self.y == other.y) )
		return false
	end
end

class Sheep
	attr_accessor :current_point
	def move
		x = @current_point.x
		y = @current_point.y
		possible_points = [ [x,y+1], [x+1,y], [x-1,y], [x,y-1] ]
		p = possible_points.sample
		until( (p[0].between?(0,4)) && (p[1].between?(0,4)) ) do
			p = possible_points.sample
		end
		@current_point = Points.new(p[0], p[1])
		puts "Sheep moved to #{@current_point.to_s} \n\n"				
	end	
	def initialize point
		@current_point = point
	end
	
end

class Wolf
	attr_accessor :current_point
	def move
		x = @current_point.x
		y = @current_point.y
		possible_points = [ [x+1,y+1], [x-1,y-1], [x-1,y+1], [x+1,y-1] ]
		p = possible_points.sample
		until( (p[0].between?(0,4)) && (p[1].between?(0,4)) ) do
			p = possible_points.sample
		end
		@current_point = Points.new(p[0], p[1])
		puts "Wolf  moved to #{@current_point.to_s}"				
	end
	def initialize point
		@current_point = point
	end
end

puts "Enter the starting point for Wolf: ";
x = gets.chomp.to_i; 
y = gets.chomp.to_i;
p1 = Points.new(x,y)
wolf = Wolf.new(p1)
abort("Error!!! Enter a values between 0 and 4") unless( (x.between?(0,4)) && (y.between?(0,4)) )

puts "Enter the starting point for Sheep: ";
x = gets.chomp.to_i; 
y = gets.chomp.to_i;
p2 = Points.new(x,y)
sheep = Sheep.new(p2)
abort("Error!!! Enter a values between 0 and 4") unless( (x.between?(0,4)) && (y.between?(0,4)) )

until(sheep.current_point == wolf.current_point)
	wolf.move
	sheep.move
end
puts"Wolf captured sheep!!!! GAME OVER!!!\n\n"










