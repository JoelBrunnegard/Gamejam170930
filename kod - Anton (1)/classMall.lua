local className = {}

setmetatable(
	className, 
	{
		__call = function (self, ...)
			return self.new(...)
		end
	}
)

-- Static
local privateStaticVar = value
className.publicStaticVar = value

local function privateStaticFunction(...)
end

function className.publicStaticFunction(...)
end

-- Constructor
function className.new(...) --Params are privateVar
	self = {}
	self.publicVar = value
	local privateVar = value
	
	function self:publicMethod(...)
	end
	
	local function privateMethod(...)
	end
	
	return self
end

return className