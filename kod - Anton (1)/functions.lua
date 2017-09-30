local getX, getY = love.mouse.getX, love.mouse.getY

function love.mouse.getX()
	return getX() - translateX()
end

function love.mouse.getY()
	return getY() - translateY()
end

function translateX()
	if player.x < love.graphics.getWidth() / 2 then
		return 0
	elseif player.x > world.width * world.tileWidth - love.graphics.getWidth() / 2 then
		return -(world.width * world.tileWidth - love.graphics.getWidth())
	else
		return -(player.x - love.graphics.getWidth() / 2)
	end
end

function translateY()
	if player.y < love.graphics.getHeight() / 2 then
		return 0
	elseif player.y > world.height * world.tileHeight - love.graphics.getHeight() / 2 then
		return -(world.height * world.tileHeight - love.graphics.getHeight())
	else
		return -(player.y - love.graphics.getHeight() / 2)
	end
end

function minmax(min, value, max)
	return math.max(math.min(value, max), min)
end

function getAngle(x1, y1, x2, y2)
	if x1 >= x2 then
		return math.atan2(y2 - y1, x2 - x1) + math.pi / 2
	else
		return math.atan2(y2 - y1, x2 - x1) + math.pi / 2
	end
end
