def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day9.txt')
	inputs = data.split("\n")
	inputs.map! &:to_i
	length = 25 #preamble length
	size = inputs.size
	start = 0; ennd = length-1 
	length.upto(size -1) do |i|
		if inputs[i] == 123841
			# puts "start #{start} end #{ennd}" 
			# puts "values #{inputs[start..ennd]}"
		end

		return inputs[i] if find_invalid_number(inputs[start..ennd], inputs[i], length)	
		start +=1; ennd += 1;
	end
end

def part2
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day9.txt')
	inputs = data.split("\n")
	inputs.map! &:to_i
	length = 25 #preamble length
	size = inputs.size
	start = 0; ennd = length-1 
	length.upto(size -1) do |i|
		if find_invalid_number(inputs[start..ennd], inputs[i], length)	
			window = inputs[0..ennd]
			puts "caught #{inputs[i]} "
			# puts "window - #{window}"
			start, ennd = find_contiguous_range(window, inputs[i], window.length)
			# puts "result - #{val}"
			contiguous_range = inputs[start..ennd]
			# puts "contiguous_range #{contiguous_range}"
			sorted_range = contiguous_range.sort
			return sorted_range.first + sorted_range.last
			break
		end
		start +=1; ennd += 1;
	end
end
def find_contiguous_range(current_window, value_to_check, length)
	current_window.each_with_index do |val, index|
		# puts "i values - #{index} val - #{val}"
		j = index + 1
		current_sum = val
		while (current_sum < value_to_check)
			current_sum += current_window[j]
			puts current_sum
			if current_sum == value_to_check
				# puts "values #{current_window[j]} , #{current_window[index]}"
				return index, j 
			end
			j += 1
		end
	end
end




def find_invalid_number(current_window, value_to_check, len)
	puts "window #{current_window}" if value_to_check == 123841
	current_window.each_with_index do |val, index|

	j = index + 1
		while (j < len)
			puts "hi - #{current_window[index]} - #{current_window[j]} - #{current_window[index] + current_window[j]}" if value_to_check == 123841 
			if current_window[index] + current_window[j] == value_to_check
			return false
			end
			j+=1
		end
	end
	puts "fraud"
	return true
end