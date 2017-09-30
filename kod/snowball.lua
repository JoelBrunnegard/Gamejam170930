local snowball = {}

setmetatable(
	snowball, 
	{
		__call = function (self, ...)
			return self.new(...)
		end
	}
)

local function privateStaticFunction(...)
end

function snowball.publicStaticFunction(...)
end

-- Constructor
function snowball.new(img, x, y, targetX, targetY, speed, dmg)
	local self = {}
	self.img = img
	self.speed = speed
	self.dmg = dmg
	local v = getAngle(x, y, targetX, targetY)
	local targetDistance = math.sqrt(math.abs(x - targetX) ^ 2 + math.abs(y - targetY) ^ 2)
	local shadow = {x = x, y = y + 30, v = getAngle(x, y + 30, targetX, targetY), targetDistance = math.sqrt(math.abs(x - targetX) ^ 2 + math.abs(y + 30 - targetY) ^ 2)}
	shadow.speed = self.speed * (shadow.targetDistance / targetDistance)
	local destroyed = false
	
	function self:splat()
		for a,b in circle(math.abs(self.dmg)) do
			if world.snowTiles[math.floor(x / world.snowWidth) + a] and world.snowTiles[math.floor(x / world.snowWidth) + a][math.floor(y / world.snowHeight) + b] then
				world.snowTiles[math.floor(x / world.snowWidth) + a][math.floor(y / world.snowHeight) + b].hasSnow = self.dmg < 0
			end
		end
	
		self:destroy()
	end
	
	function self:destroy()
		destroyed = true
	end
	
	function self:isDestroyed()
		return destroyed
	end
	
	function self:update(dt)
		if not destroyed then
			x = x + math.sin(v) * self.speed * dt
			y = y - math.cos(v) * self.speed * dt
			shadow.x = x
			shadow.y = shadow.y - math.cos(shadow.v) * shadow.speed * dt
			targetDistance = targetDistance - speed * dt
			
			if targetDistance <= 0 then
				x = targetX
				y = targetY
				self:splat()
			end
		end
	end
	
	function self:draw()
		if not destroyed then
			love.graphics.setColor(0, 0, 0, 50)
			love.graphics.circle("fill", shadow.x, shadow.y, 10)
			love.graphics.setColor(255, 255, 255)
			love.graphics.circle("fill", x, y, 10)
			--love.graphics.draw(textures.shadow, x, shadow.y)
		end
	end
	
	return self
end

return snowball