local displaying = {
	image = love.graphics.newImage("assets/world/tiles.png")
}

displaying.tilesetBatch = love.graphics.newSpriteBatch(displaying.image)
displaying.tileSide = 48

function displaying:load(styleId)
	self.tiles = {
		love.graphics.newQuad(styleId*96 + 24, 72, 48, 48, self.image:getDimensions()), -- center
		love.graphics.newQuad(styleId*96, 72, 48, 48, self.image:getDimensions()), -- left
		love.graphics.newQuad(styleId*96 + 48, 72, 48, 48, self.image:getDimensions()), -- right
		love.graphics.newQuad(styleId*96 + 24, 48, 48, 48, self.image:getDimensions()), -- top
		love.graphics.newQuad(styleId*96 + 24, 96, 48, 48, self.image:getDimensions()), -- bottom
		love.graphics.newQuad(styleId*96, 48, 48, 48, self.image:getDimensions()), -- left-top
		love.graphics.newQuad(styleId*96 + 48, 48, 48, 48, self.image:getDimensions()), -- right-top
		love.graphics.newQuad(styleId*96, 96, 48, 48, self.image:getDimensions()), -- left-bottom
		love.graphics.newQuad(styleId*96 + 48, 96, 48, 48, self.image:getDimensions()), -- right-bottom
		love.graphics.newQuad(styleId*96 + 48, 0, 48, 48, self.image:getDimensions()), -- single
	}
	self.frame = nil
end

function displaying:getFrame(camera)
	local view = camera:getViewport()
	return {
		math.floor(view.left/self.tileSide),
		math.floor(view.right/self.tileSide),
		math.floor(view.top/self.tileSide),
		math.floor(view.bottom/self.tileSide)
	}
end

function displaying:shouldUpdate(camera)
	if not self.frame then return true end
	
	local tempFrame = self:getFrame(camera)

	return self.frame[1] ~= tempFrame[1]
		or self.frame[2] ~= tempFrame[2]
		or self.frame[3] ~= tempFrame[3]
		or self.frame[4] ~= tempFrame[4]
end

function displaying:updateFrame(camera, map)
	self.frame = self:getFrame(camera)

	self.tilesetBatch:clear()
	for x = self.frame[1], self.frame[2] do
		for y = self.frame[3], self.frame[4] do
			local cell = map:getTile(x, y)
			if cell then
				self.tilesetBatch:add(self.tiles[cell], x * self.tileSide, y * self.tileSide)
			end
		end
	end
	self.tilesetBatch:flush()
end

function displaying:draw(camera, map)
	if self:shouldUpdate(camera) then
		self:updateFrame(camera, map)
	end
	love.graphics.draw(self.tilesetBatch)
end

return displaying