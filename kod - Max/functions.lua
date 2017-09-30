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
	if type(min) ~= 'number' then
		return error("bad argument #1 to 'minmax' (number expected, got " .. type(min) .. ")")
	elseif type(value) ~= 'number' then
		return error("bad argument #2 to 'minmax' (number expected, got " .. type(value) .. ")")
	elseif type(max) ~= 'number' then
		return error("bad argument #3 to 'minmax' (number expected, got " .. type(max) .. ")")
	end

	return math.max(math.min(value, max), min)
end

function getAngle(x1, y1, x2, y2)
	if type(x1) ~= 'number' then
		return error("bad argument #1 to 'getAngle' (number expected, got " .. type(x1) .. ")")
	elseif type(y1) ~= 'number' then
		return error("bad argument #2 to 'getAngle' (number expected, got " .. type(y1) .. ")")
	elseif type(x2) ~= 'number' then
		return error("bad argument #3 to 'getAngle' (number expected, got " .. type(x2) .. ")")
	elseif type(y2) ~= 'number' then
		return error("bad argument #4 to 'getAngle' (number expected, got " .. type(y2) .. ")")
	end

	if x1 >= x2 then
		return math.atan2(y2 - y1, x2 - x1) - math.pi / 2
	else
		return math.atan2(y2 - y1, x2 - x1) + math.pi / 2
	end
end
