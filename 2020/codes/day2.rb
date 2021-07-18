def execute &block
	data = File.read("/Users/rahul/repo/others/adventofcode/2020/inputs/day2.txt")
	inputs = data.split("\n")
	count = 0
	inputs.each do |input|
		valid = false
		current_policy = input.split(" ")
		min, max = current_policy[0].split('-').map{|num| num.to_i}
		char = current_policy[1]
		password  = current_policy[2]
		count += 1 if yield(password,char, min, max)
	end
	count
end

def part1
	condition = lambda { |password, char, min, max|  password.count(char) >= min && password.count(char) <= max}
	execute(&condition)
end


def part2
	condition = lambda { |password, char, min, max|  (password[min-1] == char && password[max-1] != char) || (password[max-1] == char && password[min-1] != char)}
	execute(&condition)
end