def part1
	data = File.read('/Users/rahul/repo/others/adventofcode/2020/inputs/day13.txt')
	inputs = data.split("\n")
	buses = []
	possible_buses = inputs[1].split(',')
	possible_buses.each do |bus|
		next if bus == 'x'
		buses << bus.to_i
	end
	timestamp = inputs[0].to_i
	latest_timestamp(buses, timestamp)
end

def latest_timestamp(buses, timestamp)
	hsh = {}
	timestamp_arr = []
	buses.each do |bus|
		divisor = timestamp/bus
		# time1 = timestamp - (divisor * bus)
		time2 = ((divisor + 1) * bus) - timestamp 
		hsh[bus] = time2
	end
	puts hsh
	best_bus = hsh.first[0]
	least_wait_time = hsh.first[1]
	hsh.each do |k,v|
		if v < least_wait_time
			best_bus = k
			least_wait_time = v
		end
	end
	best_bus * least_wait_time
end