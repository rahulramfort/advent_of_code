def 1st
	num = 2020
	len = arr.length
	arr.each_with_index do |val, index|
	j = index + 1
	while (j < len)
	if arr[index] + arr[j] == num
	puts arr[index] * arr[j]
	end
	j+=1
	end
	end
end


def 1st
	num = 2020
	len = arr.length
	arr.each_with_index do |val, index|
	j = index + 1
		while (j < len-1)
			current_sum = arr[index] + arr[j]
			k = j+1
				while(k < len)
					if current_sum + arr[k] == num
						puts arr[index] * arr[j] * arr[k]
					end
					k+=1
				end
			j+=1
		end
	end
end
