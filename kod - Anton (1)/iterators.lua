function multiDimArray(t, n)
	local dims = {#t}
	local dimIndex = {0}
	local dim = t[1]
	
	while type(dim) == 'table' and dim[1] ~= nil do
		dims[#dims + 1] = #dim
		dimIndex[#dimIndex + 1] = 1
		dim = dim[1]
		
		if n and #dims == n then
			break
		end
	end
	
	return function ()
		for i = 1,#dims do
			dimIndex[i] = dimIndex[i] + 1
			
			if dimIndex[i] > dims[i] then
				dimIndex[i] = 1
				
				if i == #dims then
					return
				end
			else
				break
			end
		end
		
		local output = {}
		output[#dims + 1] = t
		
		for i = 1,#dimIndex do
			output[i] = dimIndex[i]
			output[#dims + 1] = output[#dims + 1][dimIndex[i]]
		end
		
		return unpack(output)
	end
end

function circle(r)
	local circlePos = {}
	
	for i = 1,r do
		for u = 1,r do
			local x, y = i - r / 2, u - r / 2
		
			if math.sqrt(x ^ 2 + y ^ 2) <= r / 2 then
				circlePos[#circlePos + 1] = {x, y}
			end
		end
	end
	
	local index = 0
	
	return function ()
		index = index + 1
		
		if circlePos[index] then
			return unpack(circlePos[index])
		end
	end
end