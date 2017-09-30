local SpriteSheet = {}

setmetatable(
	SpriteSheet, 
	{
		__call = function (self, ...)
			return self.new(...)
		end
	}
)

function SpriteSheet.new(path, x, y, t)
	local self = {}
	local img = love.graphics.newImage(path)
	
	local index = 1

	for i = 1,y do
		for u = 1,x do
			self[index] = love.graphics.newQuad((u - 1) * img:getWidth() / x, (i - 1) * img:getHeight() / y, img:getWidth() / x, img:getHeight() / y, img:getWidth(), img:getHeight())
			index = index + 1
		end
	end
	
	self.img = img
	self.quad = self[1]
	self.timer = timer(t, true)
	self.index = 1
	
	self.timer:start()
	
	function self:update()
		if self.timer:isUp() then
			self.index = self.index + 1
			
			if self.index > #self then
				self.index = 1
			end
			
			self.quad = self[self.index]
		end
	end

	function self:stop()
		self.timer:stop()
		self.index = 1
		self.quad = self[1]
	end

	function self:start()
		self.timer:start()
	end
	
	function self:isRunning()
		return self.timer:isRunning()
	end

	function self:setTime(t)
		self.timer:setTime(t)
	end
	
	function self:getWidth()
		local x, y, w, h = self.quad:getViewport()
		return w
	end
	
	function self:getHeight()
		local x, y, w, h = self.quad:getViewport()
		return h
	end

	function self:draw(x, y, r, sx, sy, ox, oy)
		love.graphics.draw(self.img, self.quad, x, y, r, sx, sy, ox, oy)
	end
	
	return self
end

return SpriteSheet