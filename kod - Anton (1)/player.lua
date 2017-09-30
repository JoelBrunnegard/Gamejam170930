local player = {}

setmetatable(
	player, 
	{
		__call = function (self, ...)
			return self.new(...)
		end
	}
)

player.x, player.y = world.width * world.tileWidth / 2, world.height * world.tileHeight / 2

local playerVel = 300
local playerImg, playerCanon = love.graphics.newImage('textures/snowmonster.png'), love.graphics.newImage('textures/snowmonster_canon.png')
local playerScale = 0.05
local playerDirection = 1

local offsetPlayerY = playerImg:getHeight() / 6
local offsetCanonX, offsetCanonY = playerCanon:getWidth() / 6, 35

function player:update(dt)
	local up, down, right, left
	local vel = playerVel * dt
		
	if love.keyboard.isDown('w') then
		up = true
	end
	
	if love.keyboard.isDown('s') then
		down = true
	end
	
	if love.keyboard.isDown('a') then
		right = true
	end
	
	if love.keyboard.isDown('d') then
		left = true
	end

	if (right ~= left) == (up ~= down) then
		vel = vel / math.sqrt(2)
	end
	
	if up then
		player.y = player.y - vel
	end
	
	if down then
		player.y = player.y + vel
	end
	
	if right then
		player.x = player.x - vel
	end
	
	if left then
		player.x = player.x + vel
	end
	
	if love.mouse.getX() < player.x then
		playerDirection = -1
	else
		playerDirection = 1
	end
	
	for x, y in circle(16) do
		world.snowTiles[math.floor((player.x + x * 8) / 8)][math.floor((player.y + y * 8) / 8)].hasSnow = true
	end
end

local function getCanonAngle()
	if love.mouse.getX() >= player.x then
		return math.atan2(player.y - offsetCanonY - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
	else
		return math.atan2(player.y - offsetCanonY - love.mouse.getY(),player.x - love.mouse.getX())
	end
end

function player:draw()
	love.graphics.draw(playerCanon, player.x + playerDirection * 10, player.y - offsetCanonY - 10, getCanonAngle(), playerScale * playerDirection, playerScale, offsetCanonX, playerCanon:getHeight() / 2)
	love.graphics.draw(playerImg, player.x, player.y, 0, playerScale * playerDirection, playerScale, playerImg:getWidth() / 2, playerImg:getHeight() - offsetPlayerY)
	love.graphics.draw(playerCanon, player.x, player.y - offsetCanonY, getCanonAngle(), playerScale * playerDirection, playerScale, offsetCanonX, playerCanon:getHeight() / 2)
end

return player