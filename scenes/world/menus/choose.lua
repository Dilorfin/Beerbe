local chooseMenu = {
    index = 1
}

function chooseMenu:load(font)
    self.font = font
    self.options = {
        love.graphics.newText(self.font, "Items"),
        love.graphics.newText(self.font, "Stats"),
        love.graphics.newText(self.font, "Equipment"),
        love.graphics.newText(self.font, "Donate"),
        love.graphics.newText(self.font, "Settings"),
        love.graphics.newText(self.font, "Escape")
    }
end

function chooseMenu:unload()
    self.options = nil
end

function chooseMenu:control_button(command, menuState)
    if command == Command.Up then
        if self.index > 1 then
            self.index = self.index - 1
        end
    elseif command == Command.Down then
        if self.index < #self.options then
            self.index = self.index + 1
        end
    elseif command == Command.Confirm then
        if self.index == #self.options then
            love.event.quit()
        else
            menuState.current = self.index
        end
    end
end

function chooseMenu:draw()
    local offsetX = love.graphics.getWidth()/80
    local offsetY = love.graphics.getHeight()/2-(#self.options*self.font:getHeight()*1.5)/2
    for i = 1, #self.options do
        love.graphics.draw(self.options[i], offsetX,  offsetY + (i-1)*self.font:getHeight()*1.5)
    end
    
    love.graphics.rectangle("fill", offsetX, offsetY + (self.index-1)*self.font:getHeight()*1.5 + self.options[self.index]:getHeight(), self.options[self.index]:getWidth(), 3)
end

return chooseMenu