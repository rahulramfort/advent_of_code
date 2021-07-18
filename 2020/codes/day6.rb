def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day6.txt')
	inputs = data.split("\n\n")
	total_sum = 0
	inputs.each do |group|
		total_sum += get_value(group)
		# puts "group - #{group} - #{total_sum}"
	end
	total_sum
end

def part2
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day6.txt')
	inputs = data.split("\n\n")
	total_sum = 0
	inputs.each do |group|
		total_sum += get_common_value(group)
		# puts "group - #{group} - #{total_sum}"
	end
	total_sum
end

def get_common_value(group)
	hsh = {}
	groups = group.split("\n")
	group_size = 0
	groups.each do |group|
		group_size += 1
		group.each_char do |char|
			if hsh[char] == nil
				hsh[char] = 1
			else
				hsh[char] += 1 
			end
		end
	end
	# puts "hsh - #{hsh}"
	sum = 0
	hsh.each do |k,v| 
		sum += 1 if v == group_size
	end
	sum
end


def get_value(group)
	hsh = {}
	groups = group.split("\n")
	groups.each do |group|
		group.each_char do |char|
			hsh[char] = 1 
		end
	end
	# puts "hsh - #{hsh}"
	hsh.values.sum
end