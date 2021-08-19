local dialogue = {
	index = 1,
	replicas = nil,
	started = false
}

function dialogue:start(replicas)
	if #replicas <= 0 then return end
	
	self.replicas = replicas
	self.started = true
end

function dialogue:finish()
	self.index = 1
	self.started = false
end

function dialogue:nextReplica()
	self.index = self.index + 1
	if self.index > #self.replicas then
		self:finish()
	end
end

function dialogue:control_button(command)
	if command == Command.Confirm then
		self:nextReplica()
	elseif command == Command.Deny then
		self:finish()
	end
end

function dialogue:draw(camera)
	local width = (1/camera.scale)*love.graphics.getWidth()
	local height = love.graphics.getHeight()/7
	local x, y = love.graphics.inverseTransformPoint(0, 0)

	love.graphics.setColor(1, 1, 1, 0.7)
	love.graphics.rectangle("fill", x, y, love.graphics.getWidth(), height)
	love.graphics.setColor(0, 0, 0)

	local font = love.graphics.getFont()
	local _, wrappedtext = font:getWrap(self.replicas[self.index],  width)

	y = y + height/2 - #wrappedtext * font:getHeight()/2

	love.graphics.printf(self.replicas[self.index], x, y, width, "center")
	love.graphics.setColor(1, 1, 1)
end

return dialogue