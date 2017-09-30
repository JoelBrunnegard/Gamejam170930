math.randomseed(os.time())

require 'functions'
require 'iterators'

textures = require 'textures'
world = require 'world'
player = require 'player'
snowball = require 'snowball'

snowballs = {}

function love.mousepressed(mousex, mousey, button, istouch)
    if button == 1 then
		snowballs[#snowballs + 1] = snowball("this is an image lol", player.x, player.y - 35, love.mouse.getX(), love.mouse.getY(), 1000, -10)
	end
end

function dofile(filename)
	local file = assert(loadfile(filename))
	return file()
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return  x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function love.update(dt)
	player:update(dt)
	
	for i = 1, #snowballs do
		snowballs[i]:update(dt)
	end
end

function love.draw()
	love.graphics.translate(translateX(), translateY())
	world.draw(player.x, player.y)
	player:draw()
	
	for i = 1, #snowballs do
		snowballs[i]:draw()
	end
end

function love.quit()
	
end