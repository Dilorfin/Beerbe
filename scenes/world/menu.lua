local menu = {
	index = 1,
	current = nil
}

local font = love.graphics.getFont()
menu.options = {
	{
		text = love.graphics.newText(font, "Items"),
		onChoose = function() 
			return love.filesystem.load("scenes/world/menus/items.lua")() 
		end
	},
	{
		text = love.graphics.newText(font, "Stats"),
		onChoose = function() 
			return love.filesystem.load("scenes/world/menus/stats.lua")()
		end
	},
	{
		text = love.graphics.newText(font, "Equipment"),
		onChoose = function() 
			return love.filesystem.load("scenes/world/menus/equipment.lua")()
		end
	},
	{
		text = love.graphics.newText(font, "Donate"),
		onChoose = function() 
			return love.filesystem.load("scenes/world/menus/donate.lua")()
		end
	},
	{
		text = love.graphics.newText(font, "Settings"),
		onChoose = function() 
			return love.filesystem.load("scenes/world/menus/settings.lua")()
		end
	},
	{
		text = love.graphics.newText(font, "Escape"),
		onChoose = function() 
			love.event.quit()
		end
	}
}

function menu:control_button(command, sceneState)
	if command == Command.Menu then
		sceneState.current = sceneState.moving
		return
	elseif self.current then
		self.current:control_button(command)
		if self.current.isClosed then
			self.current = nil
		end
	else
		if command == Command.Deny then
			sceneState.current = sceneState.moving
		elseif command == Command.Up then
			if self.index > 1 then
				self.index = self.index - 1
			end
		elseif command == Command.Down then
			if self.index < #self.options then
				self.index = self.index + 1
			end
		elseif command == Command.Confirm then
			self.current = self.options[self.index]:onChoose()
		end
	end
end

function menu:draw()
	if self.current then
		self.current:draw()
		return
	end

	local fontHeight = love.graphics.getFont():getHeight()
	local offsetX = love.graphics.getWidth()/80
	local offsetY = love.graphics.getHeight()/2-(#self.options*fontHeight*1.5)/2

	for i = 1, #self.options do
		love.graphics.draw(self.options[i].text, offsetX,  offsetY + (i-1)*fontHeight*1.5)
	end
	
	love.graphics.rectangle("fill", offsetX, offsetY + (self.index-1)*fontHeight*1.5 + self.options[self.index].text:getHeight(), self.options[self.index].text:getWidth(), 3)
end

return menu