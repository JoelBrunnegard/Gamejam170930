local world = {}

setmetatable(
	world, 
	{
		__call = function (self, ...)
			return self.new(...)
		end
	}
)

world.groundTiles = {}
world.tileWidth = 64
world.tileHeight = 64
world.width, world.height = 160,160

for x = 1, world.width do
	world.groundTiles[x] = {}
	for y = 1, world.height do
		world.groundTiles[x][y] = {groundTexture = textures.grass, flower = nil}
	end
end

world.snowTiles = {}
world.snowWidth = textures.snow.partWidth 
world.snowHeight = textures.snow.partHeight

snowWorldWidth, snowWorldHeight = world.width * textures.snow.numOfPartsX, world.height * textures.snow.numOfPartsY

for x = 1, snowWorldWidth do
	world.snowTiles[x] = {}
	for y = 1, snowWorldHeight do
		world.snowTiles[x][y] = {texture = nil, hasSnow = false}
	end
end

local function growFlowers(...)
	
end

local function isOnScreen(x, y, width, height)
	return checkCollision(x, y, width, height, player.x - love.graphics.getWidth() / 2, player.y - love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight())
end

function world.draw(playerX, playerY)
	--love.translate(playerX, playerY)
	
	--love.graphics.setColor(0, 200, 0)
	startx = math.floor(player.x / world.tileWidth) - math.floor((love.graphics.getWidth() / world.tileWidth))
	endx = math.floor(player.x / world.tileWidth) + math.floor((love.graphics.getWidth() / world.tileWidth)) + 2
	
	if startx < 1 then
		startx = 1
	end
	
	if endx > #world.groundTiles then
		endx = #world.groundTiles
	end
	
	starty = math.floor(player.y / world.tileHeight) - math.floor((love.graphics.getHeight() / world.tileHeight))
	endy = math.floor(player.y / world.tileHeight) + math.floor((love.graphics.getHeight() / world.tileHeight)) + 2
	
	if starty < 1 then
		starty = 1
	end
	
	if endy > #world.groundTiles[1] then
		endy = #world.groundTiles[1]
	end
	
	for x = startx, endx do
		for y = starty, endy do
			love.graphics.draw(world.groundTiles[x][y].groundTexture, (x - 1) * world.tileWidth, (y - 1) * world.tileHeight)
		end
	end
	
	--love.graphics.setColor(200, 200, 200)
	
	startx = math.floor(player.x / (world.snowWidth) + 1) - math.floor((love.graphics.getWidth() / world.snowWidth + 1))
	endx = math.floor(player.x / world.snowWidth + 1) + math.floor((love.graphics.getWidth() / world.snowWidth + 1)) + 2
	
	if startx < 1 then
		startx = 1
	end
	
	if endx > #world.snowTiles then
		endx = #world.snowTiles
	end
	
	starty = math.floor(player.y / (world.snowHeight) + 1) - math.floor((love.graphics.getHeight() / (world.snowHeight) + 1))
	endy = math.floor(player.y / (world.snowHeight) + 1) + math.floor((love.graphics.getHeight() / (world.snowHeight) + 1)) + 2
	
	if starty < 1 then
		starty = 1
	end
	
	if endy > #world.snowTiles[1] then
		endy = #world.snowTiles[1]
	end
	
	for x = startx, endx do
		for y = starty, endy do
			if world.snowTiles[x][y].hasSnow then
				love.graphics.draw(textures.snow.img,textures.snow.quads[x%textures.snow.numOfPartsX+1][y%textures.snow.numOfPartsY+1],(x - 1) * textures.snow.partWidth,(y - 1) * textures.snow.partHeight)
			end
		end
	end
--[[	
	for x, y, tile in multiDimArray(world.groundTiles) do
		if tile.flower then
			love.graphics.draw(tile.flower, (x - 1) * tile.flower:getWidth(), (y - 1) * tile.flower:getHeight())
		end
	end
]]
end

-- Constructor
function world.new(...) --Params are privateVar
	self = {}
	self.publicVar = value
	local privateVar = value
	
	function self:publicMethod(...)
	end
	
	local function privateMethod(...)
	end
	
	return self
end

return world