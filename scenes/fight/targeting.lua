local target = {
	index = 1,
	spell = ""
}

function target:init(actors)
	self.image = love.graphics.newImage("asserts/fight/select.png")
	self.actors = actors
end

function target:control_button(command)
	if command == Command.Left then
		self.index = self.index - 1
		if self.index <= 0 then
			self.index = self.actors:getActorsNumber()
		end
	elseif command == Command.Right then
		self.index = self.index + 1
		if self.index > self.actors:getActorsNumber() then
			self.index = 1
		end
	end
end

function target:draw()
	local pos = self.actors:getPositionById(self.index)
	love.graphics.draw(self.image, pos.x- 0.0125*love.graphics.getWidth(), pos.y+ 0.016667*love.graphics.getHeight(), 0, love.graphics.getHeight()/1200)
end

return target