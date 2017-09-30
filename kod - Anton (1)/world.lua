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
world.width, world.height = 160, 160

for x = 1, world.width do
	world.groundTiles[x] = {}
	for y = 1, world.height do
		world.groundTiles[x][y] = {groundTexture = textures.grass, flower = nil}
	end
end

world.snowTiles = {}

local snowWorldWidth, snowWorldHeight = world.width * 8, world.height * 8
world.snowWidth = 8
world.snowHeight = 8


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
	
	starty = math.floor(player.y / world.tileHeight) - math.floor((love.graphics.getWidth() / world.tileHeight))
	endy = math.floor(player.y / world.tileHeight) + math.floor((love.graphics.getWidth() / world.tileHeight)) + 2
	
	if starty < 1 then
		starty = 1
	end
	
	if endy > #world.groundTiles[1] then
		endy = #world.groundTiles[1]
	end
	
	for x = startx, endx do
		for y = starty, endy do
			--love.graphics.draw(tile.groundTexture, x * tile.groundTexture:getWidth(), y * tile.groundTexture:getHeight())
			love.graphics.draw(world.groundTiles[x][y].groundTexture, (x - 1) * world.tileWidth, (y - 1) * world.tileHeight)
			--love.graphics.rectangle("line", (x - 1) * world.tileWidth, (y - 1) * world.tileHeight, world.tileWidth, world.tileHeight)
		end
	end
	
	--love.graphics.setColor(200, 200, 200)
	
	startx = math.floor(player.x / (math.floor(world.tileWidth / 8) + 1)) - math.floor((love.graphics.getWidth() / (math.floor(world.tileWidth / 8) + 1)))
	endx = math.floor(player.x / (math.floor(world.tileWidth / 8) + 1)) + math.floor((love.graphics.getWidth() / (math.floor(world.tileWidth / 8) + 1))) + 2
	
	if startx < 1 then
		startx = 1
	end
	
	if endx > #world.groundTiles * 8 then
		endx = #world.groundTiles * 8
	end
	
	starty = math.floor(player.y / (math.floor(world.tileHeight / 8))) - math.floor((love.graphics.getWidth() / (math.floor(world.tileHeight / 8) + 1)))
	endy = math.floor(player.y / (math.floor(world.tileHeight / 8) + 1)) + math.floor((love.graphics.getWidth() / (math.floor(world.tileHeight / 8) + 1))) + 2
	
	if starty < 1 then
		starty = 1
	end
	
	if endy > #world.groundTiles[1] * 8 then
		endy = #world.groundTiles[1] * 8
	end
	
	for x = startx, endx do
		for y = starty, endy do
			if world.snowTiles[x][y].hasSnow then
				--love.graphics.draw(textures.snow, x * textures.snow:getWidth(), y * textures.snow:getHeight())
				--love.graphics.draw(textures.snow,(x - 1) * textures.snow:getWidth(), (y - 1) * textures.snow:getHeight())
				--love.graphics.rectangle("fill", (x - 1) * 8, (y - 1) * 8, 8, 8)
				love.graphics.draw(textures.snow.img,textures.snow.quads[x%textures.snow.partWidth+1][y%textures.snow.partHeight+1],(x - 1) * textures.snow.partWidth,(y - 1) * textures.snow.partHeight)
			end
			
			if love.mouse.getX() >= (x - 1) * 8 and love.mouse.getX() <= (x - 1) * 8 + 8 and love.mouse.getY() >= (y - 1) * 8 and love.mouse.getY() <= (y - 1) * 8 + 8 then
				world.snowTiles[x][y].hasSnow = true
			end
		end
	end
	
	for x, y, tile in multiDimArray(world.groundTiles) do
		if tile.flower then
			love.graphics.draw(tile.flower, (x - 1) * tile.flower:getWidth(), (y - 1) * tile.flower:getHeight())
		end
	end
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