def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/sample/day7.txt')
	inputs = data.split("\n")
	rules = []
	inputs.each do |input|
		rules_data = input.split('contain')
		tmp = {}
		tmp[:bag] = rules_data[0].split.join(" ").gsub('bags','bag')

		contains_bag = rules_data[1].split(',')
		tmp[:contains] = []
		contains_bag.each do |bag|
			tmp[:contains] << bag.gsub(/[^a-zA-Z0-9 ]/,'').split.join(" ").gsub('bags','bag') #to remove extra spaces
		end
		rules << tmp
	end
	# find_number_of_combinations(rules, ['shiny gold bag'], 0)
	rules
end
def find_number_of_combinations(rules, arr, n)
	comibinations = []
	while !arr.empty?
		bag_to_find = arr.pop
		puts "bag_to_find #{bag_to_find}"
		rules.each do |rule|
			puts "rule #{rule}"
			if rule[:contains].any?{|bag| bag.include?(bag_to_find)} && !comibinations.any?{|bag| bag.include?(rule[:bag])}
				arr << rule[:bag]
				comibinations << rule[:bag]
				n +=1
				puts "inside"
			end
		end
		puts "arr #{arr}"
	end
	n
end