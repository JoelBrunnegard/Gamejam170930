math.randomseed(os.time())

require 'functions'
require 'iterators'

textures = require 'textures'
timer = require 'timer'

world = require 'world'
player = require 'player'


function dofile(filename)
	local file = assert(loadfile(filename))
	return file()
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return  x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	love.graphics.translate(translateX(), translateY())
	world.draw(player.x, player.y)
	player:draw()
end

function love.quit()
	
end