def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day8.txt')
	inputs = data.split("\n")
	execute(inputs, 0, 0, [], inputs.size)
end

def part2
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day8.txt')
	inputs = data.split("\n")
	current_line_no = inputs.size
	fix_the_error(inputs, current_line_no, inputs.dup, current_line_no)
end

def fix_the_error(inputs, current_line_no, possible_corrected_input, size)
	result = execute(possible_corrected_input, 0, 0, [], size)
	return result[1] if result.is_a?(Array)

	return -1 if current_line_no == 0
	current_line_no = current_line_no - 1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day8.txt')
	possible_corrected_input = data.split("\n")
	current_line_no.downto(0) do |line_no|
		instruction =  inputs[line_no].split(' ')
		operation = instruction[0]
		next if operation != 'jmp' && operation != 'nop'

		current_line_no = line_no
		if operation == 'jmp'
			possible_corrected_input[line_no] = possible_corrected_input[line_no].gsub('jmp', 'nop')
		elsif operation == 'nop'
			possible_corrected_input[line_no] = possible_corrected_input[line_no].gsub('nop', 'jmp')
		else
			raise "Code error"
		end
		puts "current_line_no #{current_line_no}", "instruction changed #{possible_corrected_input[line_no]}"
		break
	end
	# puts "input #{inputs}"
	puts "possible_corrected_input #{possible_corrected_input}"
	fix_the_error(inputs, current_line_no, possible_corrected_input, size)
end

def execute(inputs, acc, current_line_no, visited_line_no_arr, size)
	return ["value", acc] if current_line_no == size

	instruction =  inputs[current_line_no].split(' ')
	operation = instruction[0]
	value = instruction[1].to_i
	if visited_line_no_arr.include?(current_line_no)
		return acc
	else
		visited_line_no_arr << current_line_no
	end
	# puts instruction, current_line_no
	case operation
	when 'nop'
		execute(inputs, acc, current_line_no + 1, visited_line_no_arr, size)
	when 'acc'
		execute(inputs, acc + value, current_line_no + 1, visited_line_no_arr, size)
	when 'jmp'
		execute(inputs, acc, current_line_no + value, visited_line_no_arr, size)
	else
		raise "error + acc #{acc} , instruction #{instruction}, current_line_no #{current_line_no} , size - #{size}" 
	end
end

