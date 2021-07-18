def part1
	list = [[3,1]]
	execute(list)
end

def part2
	list = [[1,1],[3,1],[5,1],[7,1],[1,2]]
	execute(list)
end

def validate(passport)
	mandatory_fields = %w(ecl: pid: eyr: hcl: byr: iyr: hgt:) 
	valid = true
	mandatory_fields.each do |field|
		valid = false && break unless passport.include?(field)
	end
	valid
end


def execute
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day4.txt')
	inputs = data.split("\n\n")
	valid_passports = 0
	inputs.each do |current_passport|
		valid_passports += 1 if validate(current_passport)
	end
	valid_passports
end


def validate(passport)
	mandatory_fields = %w(ecl pid eyr hcl byr iyr hgt) 
	passport_fields = passport.split(" ")
	puts "passport_fields #{passport_fields}"
	valid = true
	mandatory_fields.each do |field|
		field_data = passport_fields.find {|f| f.include?(field + ':')}
		return false if field_data.nil?
		field_data = field_data.split(field + ':').last
		puts "value: #{field_data}" 
		return false unless send(field.to_sym, field_data)
	end
	valid
end

def byr(field_data)
	field_data = field_data.to_i
	field_data >= 1920 && field_data <= 2002
end
def iyr(field_data)
	field_data = field_data.to_i
	field_data >= 2010 && field_data <= 2020
end
def eyr(field_data)
	field_data = field_data.to_i
	field_data >= 2020 && field_data <= 2030
end
def hgt(field_data)
	return false if field_data.nil?
	if field_data.include?('cm') 
		num = field_data.split('cm')[0].to_i
		return num >= 150 && num <= 193
	elsif field_data.include?('in') 
		num = field_data.split('in')[0].to_i
		
		return num >= 59 && num <= 76
	end
	false
end
def hcl(field_data)
	return false if field_data.nil? || field_data[0] != '#'

	chars = field_data.delete('#').gsub(/[^0-9a-f]/,'')
	chars.size == 6
end
def ecl(field_data)
	puts "here value #{field_data}"
	return false if field_data.nil?
	allowed = %w(amb blu brn gry grn hzl oth)
	allowed.find {|a| a == field_data} != nil
end
def pid(field_data)
	return false if field_data.nil?

	field_data.gsub(/[^0-9]/, '').size == 9 
end
