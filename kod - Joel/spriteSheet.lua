SpriteSheet = {}
SpriteSheet.__index = SpriteSheet
SpriteSheet.__metatable = "spriteSheet"

function SpriteSheet.add(path, x, y, t)
	local array = {}
	local img = love.graphics.newImage(path)
	
	setmetatable(array,SpriteSheet)
	
	local index = 1

	for i = 1,img:getHeight() / y do
		for u = 1,img:getWidth() / x do
			array[index] = love.graphics.newQuad((u - 1) * x, (i - 1) * y, x, y, img:getWidth(), img:getHeight())
			index = index + 1
		end
	end
	
	array.img = img
	array.quad = array[1]
	array.updatetime = t
	array.time = 0
	array.index = 1
	
	return array
end

function SpriteSheet:update()
	if self.time <= os.clock() then
		self.time = os.clock() + self.updatetime
		
		self.index = self.index + 1
		
		if self.index > #self then
			self.index = 1
		end
		
		self.quad = self[self.index]
	end
end

function SpriteSheet:draw(x, y, r, sx, sy, ox, oy)
	love.graphics.draw(self.img, self.quad, x, y, r, sx, sy, ox, oy)
end