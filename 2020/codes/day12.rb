@right_directions = ['N', 'E', 'S', 'W'].freeze
@left_directions = ['N', 'W', 'S', 'E'].freeze
@opposite_direction = {'N' => 'S', 'S' => 'N', 'E' => 'W', 'W' => 'E'}.freeze
def part1
	@hsh = {'E' => 0, 'W' => 0, 'N' => 0, 'S' => 0}
	@current_direction = 'E'
	@first_flag = true
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day12.txt')
	inputs = data.split("\n")
	inputs.each do |input|
		navigate_the_ship(input)
		# puts "@hsh #{@hsh} input #{input}"
	end
	(@hsh['W'] - @hsh['E']).abs + (@hsh['N'] - @hsh['S']).abs
end
def move_right_direction(navigation_operation, navigation_value)
	# puts "current_direction #{@current_direction}"
	next_direction_postion = (@right_directions.index(@current_direction) + (navigation_value/90)) % 4
	# puts "next_direction_postion #{@directions[next_direction_postion]}"
	@current_direction = @right_directions[next_direction_postion]
end
def move_left_direction(navigation_operation, navigation_value)
	# puts "current_direction #{@current_direction}"
	next_direction_postion = (@left_directions.index(@current_direction) + (navigation_value/90)) % 4
	# puts "next_direction_postion #{@directions[next_direction_postion]}"
	@current_direction = @left_directions[next_direction_postion]
end
def navigate_ship(navigation_value, navigation_operation)
	@hsh[navigation_operation] += navigation_value
	# @hsh[@opposite_direction[navigation_operation]] -= navigation_value
end
def navigate_the_ship(input)
	navigation_operation = input[0]
	navigation_value = input[1..].to_i
	case navigation_operation
	when 'F'
		@hsh[@current_direction] += navigation_value
	when 'L' 
		move_left_direction(navigation_operation, navigation_value)
	when 'R'
		move_right_direction(navigation_operation, navigation_value)
	else
		navigate_ship(navigation_value, navigation_operation)
	end
end
