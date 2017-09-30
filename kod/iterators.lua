function multiDimArray(t, n)
	if type(t) ~= 'table' then
		return error("bad argument #1 to 'multiDimArray' (table expected, got " .. type(t) .. ")")
	elseif n ~= nil and type(n) ~= 'number' then
		return error("bad argument #2 to 'multiDimArray' (number expected, got " .. type(n) .. ")")
	end

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

function circle(d)
	if type(d) ~= 'number' then
		return error("bad argument #1 to 'circle' (number expected, got " .. type(d) .. ")")
	end

	local circlePos = {}
	
	local r = d / 2 + 0.5
	
	for i = 1,d do
		for u = 1,d do
			local x, y = i - r, u - r
		
			if math.sqrt(x ^ 2 + y ^ 2) <= r then
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