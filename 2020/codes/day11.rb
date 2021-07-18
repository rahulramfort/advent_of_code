def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day11.txt')
	inputs = data.split("\n")
	tmp_inputs = inputs.map(&:clone)
	count = 1
	while(modify_seats(inputs, tmp_inputs)) do 
		tmp_inputs = inputs.map(&:clone)
		count += 1
	end
	get_occupied_count(inputs)
end
def modify_seats(inputs, dup_inputs)
	changed = false
	number_of_rows = inputs.size
	inputs.each_with_index do |the_row, index|
		# puts "the_row #{the_row} - index #{index}"
		seat_index = 0
		length_of_row = the_row.size
		the_row.each_char do |seat|
			# puts "seat #{seat} index #{seat_index}"
			case seat
			when 'L'
				# puts "dup_inputs #{dup_inputs}"
				# puts "the_inputs #{inputs}"
				# puts "line break "
				adjacent_seat_arr = get_adjacent_seat(dup_inputs, index, seat_index, length_of_row, number_of_rows)
				# puts "adjacent_seat_arr for index #{seat_index} row #{index} #{adjacent_seat_arr}"
				if should_change_free_seat?(adjacent_seat_arr)
					inputs[index][seat_index] = '#' 
					changed = true
				end
			when '#'
				# puts "dup_inputs #{dup_inputs}"
				# puts "the_inputs #{inputs}"
				# puts "line break "
				adjacent_seat_arr = get_adjacent_seat(dup_inputs, index, seat_index, length_of_row, number_of_rows)
				# puts "adjacent_seat_arr for index #{seat_index} row #{index} #{adjacent_seat_arr}"
				if should_change_occupied_seat?(adjacent_seat_arr, 4)
					inputs[index][seat_index] = 'L' 
					changed = true
				end
			end
			seat_index += 1
		end
	end
	changed
end
def should_change_free_seat?(adjacent_seat_arr)
	!adjacent_seat_arr.any?('#')
end
def should_change_occupied_seat?(adjacent_seat_arr, count)
	cur_count = 0
	adjacent_seat_arr.each do |seat|
		cur_count += 1 if seat == '#'
		return true if cur_count >= count
	end
	return false
end
def get_adjacent_seat(inputs, index, seat_index, length_of_row, number_of_rows)
	adjacent_seat_arr = []
	if index > 0 
		adjacent_seat_arr << inputs[index-1][seat_index] 
		if seat_index > 0 
			adjacent_seat_arr << inputs[index-1][seat_index-1] 
		end
		if seat_index < length_of_row-1
			adjacent_seat_arr << inputs[index-1][seat_index+1]
		end
	end
	if index < number_of_rows-1
		adjacent_seat_arr << inputs[index+1][seat_index] 
		if seat_index > 0 
			adjacent_seat_arr << inputs[index+1][seat_index-1] 
		end
		if seat_index < length_of_row-1
			adjacent_seat_arr << inputs[index+1][seat_index+1]
		end
	end
	if seat_index > 0
		adjacent_seat_arr << inputs[index][seat_index-1] 
	end
	if seat_index < length_of_row-1
		adjacent_seat_arr << inputs[index][seat_index+1]
	end	
	adjacent_seat_arr
end
def get_occupied_count(inputs)
	count = 0
	inputs.each_with_index do |the_row, index|
		the_row.each_char do |seat|
			count +=1 if seat == '#'
		end
	end
	count
end


# Part 2

def modify_seat_2(inputs, dup_inputs)
	changed = false
	number_of_rows = inputs.size
	inputs.each_with_index do |the_row, index|
		seat_index = 0
		length_of_row = the_row.size
		the_row.each_char do |seat|
			case seat
			when 'L'
				adjacent_seat_arr = get_adjacent_visible_seat(dup_inputs, index, seat_index, length_of_row, number_of_rows)
				# puts "adjacent_seat_arr for index #{seat_index} row #{index} #{adjacent_seat_arr}"
				if should_change_free_seat?(adjacent_seat_arr)
					inputs[index][seat_index] = '#' 
					changed = true
				end
			when '#'
				adjacent_seat_arr = get_adjacent_visible_seat(dup_inputs, index, seat_index, length_of_row, number_of_rows)
				# puts "adjacent_seat_arr for index #{seat_index} row #{index} #{adjacent_seat_arr}"
				if should_change_occupied_seat?(adjacent_seat_arr, 5)
					inputs[index][seat_index] = 'L' 
					changed = true
				end
			end
			seat_index += 1
		end
	end
	changed
end

def get_adjacent_visible_seat(inputs, index, seat_index, length_of_row, number_of_rows)
	puts "index #{index} seat_index #{seat_index}"
	adjacent_seat_arr = []
	if index > 0 
		adjacent_seat_arr << get_visible_seat(inputs, index-1, seat_index, 'U', length_of_row, number_of_rows)
		if seat_index > 0 
			adjacent_seat_arr << get_visible_seat(inputs, index-1, seat_index-1, 'LU', length_of_row, number_of_rows)
		end
		if seat_index < length_of_row-1
			adjacent_seat_arr << get_visible_seat(inputs, index-1, seat_index+1, 'RU', length_of_row, number_of_rows)
		end
	end
	if index < number_of_rows-1
		adjacent_seat_arr << get_visible_seat(inputs, index+1, seat_index, 'D', length_of_row, number_of_rows)
		if seat_index > 0 
			adjacent_seat_arr << get_visible_seat(inputs, index+1, seat_index-1, 'LD', length_of_row, number_of_rows)
		end
		if seat_index < length_of_row-1
			adjacent_seat_arr << get_visible_seat(inputs, index+1, seat_index+1, 'RD', length_of_row, number_of_rows)
		end
	end
	if seat_index > 0
		adjacent_seat_arr << get_visible_seat(inputs, index, seat_index-1, 'L', length_of_row, number_of_rows)
	end
	if seat_index < length_of_row-1
		adjacent_seat_arr << get_visible_seat(inputs, index, seat_index+1, 'R', length_of_row, number_of_rows)
	end	
	puts "adjacent_seat_arr - #{adjacent_seat_arr}"
	adjacent_seat_arr
end

def get_visible_seat(inputs, index, seat_index, direction, length_of_row, number_of_rows)
	visible_seat = inputs[index][seat_index] 
	return visible_seat if visible_seat != '.'

	case direction
	when 'U'
		return '.' if index <= 0
		index -= 1
	when 'D'
		return '.' if index >= number_of_rows -1
		index += 1
	when 'L'
		return '.' if seat_index <= 0
		seat_index -=1 
	when 'R'
		return '.' if seat_index >= length_of_row -1
		seat_index +=1
	when 'LU'
		return '.' if seat_index <= 0 || index <= 0
		index -= 1; seat_index -= 1;
	when 'LD'
		return '.' if seat_index <= 0 || index >= number_of_rows -1
		index += 1; seat_index -= 1;
	when 'RU'
		return '.' if seat_index >= length_of_row -1 || index <= 0
		index -=1; seat_index +=1;
	when 'RD'
		return '.' if seat_index >= length_of_row -1 || index >= number_of_rows -1
		index +=1; seat_index += 1;
	else
		raise "Unimplemented Error"
	end
	get_visible_seat(inputs, index, seat_index, direction, length_of_row, number_of_rows)
end

def part2
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day11.txt')
	inputs = data.split("\n")
	tmp_inputs = inputs.map(&:clone)
	count = 1
	while(modify_seat_2(inputs, tmp_inputs)) do 
		puts "current tmp #{inputs}"
		tmp_inputs = inputs.map(&:clone)
		count += 1
	end
	get_occupied_count(inputs)
end