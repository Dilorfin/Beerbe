local camera = {
	x = -40,
	y = 0,
	scale = love.graphics.getHeight()/600
}

function camera:getViewport()
	local globalX, globalY = love.graphics.inverseTransformPoint(love.graphics.getWidth(), love.graphics.getHeight())
	return {
		left = self.x,
		top = self.y,
		right = globalX,
		bottom = globalY
	}
end

function camera:setPosition(position)
	self.x = position.x
	self.y = position.y
end

function camera:update(position)
	local globalX, globalY = love.graphics.inverseTransformPoint(love.graphics.getWidth(), love.graphics.getHeight())

	if position.x > globalX - 150 then
		self.x = self.x - (globalX - 150 - position.x)
	elseif position.x < self.x + 100 then
		self.x = position.x - 100
	end

	if position.y > globalY - 150 then
		self.y = self.y - (globalY - 150 - position.y)
	elseif position.y < self.y + 100 then
		self.y = position.y - 100
	end
end

function camera:influence()
	love.graphics.scale(self.scale)
	love.graphics.translate(-self.x, -self.y)
end

return camera