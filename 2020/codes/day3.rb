def part1
	list = [[3,1]]
	execute(list)
end

def part2
	list = [[1,1],[3,1],[5,1],[7,1],[1,2]]
	execute(list)
end

def calculate_number_of_trees(i,j, inputs)
	total_rows = inputs.size
	total_cols = inputs.first.size
	count = 0
	current_i = 0; current_j = 0
	while (current_j < total_rows - 1)
		current_i += i; current_j +=j
		if current_i >= total_cols
			replaced_i = current_i % total_cols
		else
			replaced_i = current_i
		end
		count += 1  if inputs[current_j][replaced_i] == '#'
	end
	count
end

def execute(list)
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day3.txt')
	inputs = data.split("\n")
	total_trees = 1
	list.each do |current_traversal|
		number_of_trees = calculate_number_of_trees(current_traversal[0], current_traversal[1], inputs)
		total_trees *= number_of_trees 
	end
	total_trees
end

