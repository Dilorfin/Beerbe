local grid = {
	list = {
		{
			id = 0,
			title = "",
			comment = ""
		}
	},
	current = 1,
	width = 3,
	fontHeight = love.graphics.getFont():getHeight()
}

function grid:init(title, list, additionObj)
	self.title = title
	self.list = list
	self.additionObj = additionObj
end

function grid:control_button(command)
	if command == Command.Confirm and self.onConfirm then
		self:onConfirm()
	elseif command == Command.Deny and self.onDeny then
		self:onDeny()
	elseif command == Command.Up then
		if self.current > self.width then 
			self.current = self.current - self.width
		end
	elseif command == Command.Down then
		if self.current < #self.list - self.width + 1 then  -- TODO: check +1
			self.current = self.current + self.width
		end
	elseif command == Command.Left then
		if self.current > 1 then 
			self.current = self.current - 1
		end
	elseif command == Command.Right then
		if self.current < #self.list then 
			self.current = self.current + 1
		end
	end
end

function grid:draw()
	love.graphics.printf(self.title, 0, 20, love.graphics.getWidth(), "center")

	local cellWidth = love.graphics.getWidth()/self.width
	local cellHeight = 100
	
	if #self.list <= 0 then
		love.graphics.printf("Nothing's here xD", 0, love.graphics.getHeight()/2-self.fontHeight, love.graphics.getWidth(), "center")
	else
		for i, item in pairs(self.list) do
			local posX = cellWidth*((i-1)%self.width)
			local posY = cellHeight*math.ceil(i/self.width)

			love.graphics.printf(item.title, posX, posY, cellWidth, "center")
			love.graphics.printf(item.comment, posX, posY + self.fontHeight, cellWidth, "center")
		end

		love.graphics.setLineWidth(4)
		love.graphics.rectangle("line", 10 + cellWidth * ((self.current-1) % self.width ), cellHeight*(math.ceil(self.current/self.width))-20, cellWidth - 20, 90, 10, 10)
		love.graphics.setLineWidth(1)
	end
end

return grid