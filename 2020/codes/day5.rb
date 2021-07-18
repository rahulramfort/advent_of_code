def execute
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day5.txt')
	inputs = data.split("\n")
	valid_passports = 0
	max_count = 0
	inputs.each do |boarding_pass|
		seat_row_and_col = get_seat_and_row(boarding_pass)
		seat_id = calculate_seat_id(seat_row_and_col)
		max_count = seat_id if seat_id > max_count
	end
	max_count
end


def part2
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day5.txt')
	inputs = data.split("\n")
	valid_passports = 0
	seats_array = []
	inputs.each do |boarding_pass|
		seat_row_and_col = get_seat_and_row(boarding_pass)
		seat_id = calculate_seat_id(seat_row_and_col)
		seats_array << seat_id
	end
	puts seats_array.sort
	find_my_seat_id(seats_array.sort)
end

def find_my_seat_id(seats_array)
	total_seats = seats_array.size
	total_seats.times do |i|
		next if i == 0 || i == total_seats - 1

		return seats_array[i-1] + 1 if seats_array[i] != seats_array[i-1] + 1
	end
end

def get_seat_and_row(boarding_pass)
	row_a = 0; row_b = 127; col_a = 0; col_b = 7;
	seat_row = row_a; seat_col = col_a
	boarding_pass.size.times do |i|
		middle_entry_row = (row_a + row_b)/2
		middle_entry_col = (col_a + col_b)/2
		case boarding_pass[i]
		when 'F'
			row_b = middle_entry_row
			seat_row = row_b
		when 'B'
			row_a = middle_entry_row + 1
			seat_row = row_a
		when 'L'
			col_b = middle_entry_col
			seat_col = col_b
		when 'R'
			col_a = middle_entry_col + 1
			seat_col = col_b
		end
	end
	[seat_row, seat_col]
end


def calculate_seat_id(seat_row_and_col)
	seat_row_and_col[0] * 8 + seat_row_and_col[1]
end

