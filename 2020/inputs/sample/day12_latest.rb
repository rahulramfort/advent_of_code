@right_directions = ['N', 'E', 'S', 'W'].freeze
@left_directions = ['N', 'W', 'S', 'E'].freeze
@navigation_direction = {'E' => 'side', 'W' => 'side', 'S' => 'straight', 'N' => 'straight'}.freeze
def part1
	@hsh = {'side' => 0, 'straight' => 0} # side = L- R; straight = N - S
	@current_direction = 'E'
	@first_flag = true
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day12.txt')
	inputs = data.split("\n")
	inputs.each do |input|
		navigate_the_ship(input)
		puts "@hsh #{@hsh} input #{input}"
	end
	@hsh['side'].abs + @hsh['straight'].abs
end
def move_right_direction(navigation_operation, navigation_value)
	next_direction_postion = (@right_directions.index(@current_direction) + (navigation_value/90)) % 4
	@current_direction = @right_directions[next_direction_postion]
end
def move_left_direction(navigation_operation, navigation_value)
	next_direction_postion = (@left_directions.index(@current_direction) + (navigation_value/90)) % 4
	@current_direction = @left_directions[next_direction_postion]
end
def navigate_ship(navigation_value, navigation_operation)
	if navigation_operation == 'E' || navigation_operation == 'N'
		@hsh[@navigation_direction[navigation_operation]] += navigation_value
	else
		@hsh[@navigation_direction[navigation_operation]] -= navigation_value
	end
end
def navigate_the_ship(input)
	navigation_operation = input[0]
	navigation_value = input[1..].to_i
	case navigation_operation
	when 'F'
		if @current_direction == 'E' || @current_direction == 'N'
			@hsh[@navigation_direction[@current_direction]] += navigation_value
		else
			@hsh[@navigation_direction[@current_direction]] -= navigation_value
		end
	when 'L' 
		move_left_direction(navigation_operation, navigation_value)
	when 'R'
		move_right_direction(navigation_operation, navigation_value)
	else
		navigate_ship(navigation_value, navigation_operation)
	end
end


# Part 2

@right_directions = ['N', 'E', 'S', 'W'].freeze
@left_directions = ['N', 'W', 'S', 'E'].freeze
@navigation_direction = {'E' => 'side', 'W' => 'side', 'S' => 'straight', 'N' => 'straight'}.freeze
@positive_directions = ['N', 'E'].freeze
@negative_directions = ['S', 'W'].freeze
def part2
	@waypoint_hsh = {'side' => 10, 'straight' => 1} # side = L- R; straight = N - S
	@ship_hsh = {'side' => 0, 'straight' => 0} # side = L- R; straight = N - S
	@current_side = 'E'; @current_straight = 'N'
	@first_flag = true
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day12.txt')
	inputs = data.split("\n")
	inputs.each do |input|
		navigate_the_ship(input)
		puts "@waypoint_hsh #{@waypoint_hsh} input #{input}"
		puts "@ship_hsh #{@ship_hsh} "
	end
	@ship_hsh['side'].abs + @ship_hsh['straight'].abs
end
def move_right_direction(navigation_operation, navigation_value)
	next_side_postion = (@right_directions.index(@current_side) + (navigation_value/90)) % 4
	next_side = @right_directions[next_side_postion]
	next_straight_postion = (@right_directions.index(@current_straight) + (navigation_value/90)) % 4
	next_straight = @right_directions[next_straight_postion]
	puts "current_straight #{@current_straight} current_side #{@current_side}"
	puts "next_straight #{next_straight} next_side #{next_side}"
	# E == W
	if @navigation_direction[next_side] == @navigation_direction[@current_side]
		@waypoint_hsh['side'] = -(@waypoint_hsh['side'])
		@waypoint_hsh['straight'] = -(@waypoint_hsh['straight'])
	# E == N
	elsif (@positive_directions.include?(@current_side) && @positive_directions.include?(next_side))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = @waypoint_hsh['straight'], @waypoint_hsh['side']
	# W == N;  S == W
	elsif (@negative_directions.include?(@current_side) && @positive_directions.include?(next_side)) && (@negative_directions.include?(@current_straight) && @positive_directions.include?(next_straight))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = -(@waypoint_hsh['straight']), @waypoint_hsh['side']
	# E == S ; S == E
	elsif (@positive_directions.include?(@current_side) && @negative_directions.include?(next_side)) && (@negative_directions.include?(@current_straight) && @negative_directions.include?(next_straight))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = -(@waypoint_hsh['straight']), @waypoint_hsh['side']
	# N == E; E == S
	elsif (@positive_directions.include?(@current_side) && @negative_directions.include?(next_side)) && (@positive_directions.include?(@current_straight) && @positive_directions.include?(next_straight))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = @waypoint_hsh['straight'], -(@waypoint_hsh['side'])
	else
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = -(@waypoint_hsh['straight']), -(@waypoint_hsh['side'])
	end
	if next_side == 'N' ||  next_side == 'S'
		tmp = next_side
		next_side = next_straight
		next_straight = tmp
	end
	@current_side = next_side
	@current_straight = next_straight	
	puts "changes current_side #{@current_side} current_straight #{@current_straight}"
end
def move_left_direction(navigation_operation, navigation_value)
	next_side_postion = (@left_directions.index(@current_side) + (navigation_value/90)) % 4
	next_side = @left_directions[next_side_postion]
	next_straight_postion = (@left_directions.index(@current_straight) + (navigation_value/90)) % 4
	next_straight = @left_directions[next_straight_postion]
	puts "current_straight #{@current_straight} current_side #{@current_side}"
	puts "next_straight #{next_straight} next_side #{next_side}"
	# E == W
	if @navigation_direction[next_side] == @navigation_direction[@current_side]
		@waypoint_hsh['side'] = -(@waypoint_hsh['side'])
		@waypoint_hsh['straight'] = -(@waypoint_hsh['straight'])
	# E == N
	elsif (@positive_directions.include?(@current_side) && @positive_directions.include?(next_side))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = @waypoint_hsh['straight'], @waypoint_hsh['side']
	# W == N;  S == W
	elsif (@negative_directions.include?(@current_side) && @positive_directions.include?(next_side)) && (@negative_directions.include?(@current_straight) && @positive_directions.include?(next_straight))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = -(@waypoint_hsh['straight']), @waypoint_hsh['side']
	# E == S ; S == E
	elsif (@positive_directions.include?(@current_side) && @negative_directions.include?(next_side)) && (@negative_directions.include?(@current_straight) && @negative_directions.include?(next_straight))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = -(@waypoint_hsh['straight']), @waypoint_hsh['side']
	# N == E; E == S
	elsif (@positive_directions.include?(@current_side) && @negative_directions.include?(next_side)) && (@positive_directions.include?(@current_straight) && @positive_directions.include?(next_straight))
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = @waypoint_hsh['straight'], -(@waypoint_hsh['side'])
	else
		@waypoint_hsh['side'], @waypoint_hsh['straight'] = -(@waypoint_hsh['straight']), -(@waypoint_hsh['side'])
	end
	if next_side == 'N' ||  next_side == 'S'
		tmp = next_side
		next_side = next_straight
		next_straight = tmp
	end
	@current_side = next_side
	@current_straight = next_straight	
	puts "changes current_side #{@current_side} current_straight #{@current_straight}"
end
def navigate_waypoint(navigation_value, navigation_operation)
	if navigation_operation == 'E' || navigation_operation == 'N'
		@waypoint_hsh[@navigation_direction[navigation_operation]] += navigation_value
	else
		@waypoint_hsh[@navigation_direction[navigation_operation]] -= navigation_value
	end
end
def navigate_the_ship(input)
	navigation_operation = input[0]
	navigation_value = input[1..].to_i
	case navigation_operation
	when 'F'
		side_value = @waypoint_hsh['side'] * navigation_value
		straight_value = @waypoint_hsh['straight'] * navigation_value
		# if side_value < 0
		# 	@hsh['side'] -= side_value
		# else
		# 	@hsh['side'] += side_value
		# end
		# if straight_value < 0
		# 	@hsh['straight'] -= straight_value
		# else
		# 	@hsh['straight'] += straight_value
		# end
		@ship_hsh['side'] += side_value
		@ship_hsh['straight'] += straight_value
	when 'L' 
		move_left_direction(navigation_operation, navigation_value)
	when 'R'
		move_right_direction(navigation_operation, navigation_value)
	else
		navigate_waypoint(navigation_value, navigation_operation)
	end
end


