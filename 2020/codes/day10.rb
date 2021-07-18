def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day10.txt')
	inputs = data.split("\n")
	inputs.map! &:to_i
	inputs.sort!
	size = inputs.size
	hsh = { 1=> 1, 2 => 0, 3 => 1}
	inputs.each_with_index do |val, i|
		break if i == size - 1
		puts "inputs[i] - val - #{inputs[i+1] - val}"
		hsh[inputs[i+1] - val] += 1
	end
	hsh[1] * hsh[3]
end