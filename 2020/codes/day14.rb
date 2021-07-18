def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day14.txt')
	inputs = data.split("\n")
	operations = inputs
	memory_hsh = {}
	mask = nil
	mask_length = 0
	operations.each do |operation|
		if operation.include?('mask')
			mask = operation.split('mask = ').last
			mask_length = mask.length
		else
			value_to_set = operation.split('= ').last 
			key = operation.split(']').first.gsub(/[^0-9]/,'')
			# next unless memory_hsh[key].nil?
			memory_hsh[key] = get_masked_value(value_to_set.to_i, mask, mask_length)
		end
	end
	memory_hsh.values.sum
end

def get_masked_value(value, mask, mask_length)
	# puts "value #{value}"
	binary_value = value.to_s(2)
	# puts "value #{binary_value}"
	value_length = binary_value.length
	puts value_length
	masked_value = ""
	mask_length.times do |index|
		case mask[mask_length - index - 1]
		when 'X'
			value = (value_length- index -1) < 0 ? '0' : binary_value[value_length - index - 1]
			masked_value = value + masked_value
		else
			masked_value = mask[mask_length - index - 1] + masked_value
		end
	end
	puts masked_value
	puts masked_value.to_i(2)
	masked_value.to_i(2)
end