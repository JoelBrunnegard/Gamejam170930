local timer = {}

setmetatable(
	timer, 
	{
		__call = function (self, ...)
			return self.new(...)
		end
	}
)

function timer.new(t, loop)
	if type(t) ~= 'number' then
		return error("bad argument #1 to 'timer' (number expected, got " .. type(t) .. ')')
	end

	self = {}
	
	local endTime = 0
	local running = false
	
	function self:start()
		endTime = os.clock() + t
		running = true
	end
	
	function self:stop()
		running = false
	end
	
	function self:isRunning()
		return running
	end
	
	function self:setTime(ti)
		if type(ti) ~= 'number' then
			return error("bad argument #1 to 'setTime' (number expected, got " .. type(ti) .. ')')
		end
	
		t = ti
	end
	
	function self:isUp()
		if os.clock() >= endTime then
			if loop then
				endTime = os.clock() + t
			else
				running = false
			end
			
			return true
		end
		
		return false
	end
	
	return self
end

return timer