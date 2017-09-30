local textures = {}

function textures.add(textureName,filename)
	textures[textureName] = love.graphics.newImage("textures/"..filename)
end

local function getImgWithSize(filename,size)
	local picture = love.graphics.newImage("textures/"..filename)
	local scale = size/picture:getHeight()
	local canvas = love.graphics.newCanvas(picture:getHeight()*scale,picture:getWidth()*scale)
	canvas:renderTo(function()
		love.graphics.draw(picture,0,0,0,scale)
	end)
	local data = canvas:newImageData()
	return love.graphics.newImage(data)
end

function textures.scaleAdd(textureName,filename,scale)
	local scale = scale or 1
	local picture = love.graphics.newImage("textures/"..filename)
	local canvas = love.graphics.newCanvas(picture:getHeight()*scale,picture:getWidth()*scale)
	canvas:renderTo(function()
		love.graphics.draw(picture,0,0,0,scale)
	end)
	local data = canvas:newImageData()
	
	textures[textureName] = love.graphics.newImage(data)
end

function textures.addFixedSize(textureName,filename,size)
	local picture = love.graphics.newImage("textures/"..filename)
	textures.scaleAdd(textureName,filename,size/picture:getHeight())
	
end

function textures.addQuadImg(name,imgFileName,size,partsX,partsY)
	local picture =  getImgWithSize(imgFileName,size)
	textures[name] = {img=picture,quads=textures.makeQuads(partsX,partsY,picture:getHeight(),picture:getWidth()),numOfPartsX=partsX,numOfPartsY=partsY,partWidth=picture:getWidth()/partsX,partHeight=picture:getHeight()/partsY}
end

function textures.makeQuads(partsX,partsY,imgW,imgH)
	local quads = {}
	local w, h = imgW / partsX, imgH / partsY
	
	for x = 1,partsX do
		quads[x] = {}
		
		for y = 1,partsY do
			quads[x][y] = love.graphics.newQuad((x - 1) * w, (y - 1) * h, w, h, imgW, imgH)
		end
	end
	
	return quads
end

function addAllTextures()
	textures.addFixedSize("grass","grass-tile_1.png",64)
	textures.addQuadImg("snow","snow-tile_1.png",64,8,8)
end

addAllTextures()
return textures