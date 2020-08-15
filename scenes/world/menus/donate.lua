local donate = {}

function donate:load(font)
    self.font = font
    self.replicas = {
        love.graphics.newText(self.font, "Seriously?"),
        love.graphics.newText(self.font, "Not today!"),
        love.graphics.newText(self.font, "Hard? O.O"),
        love.graphics.newText(self.font, "I did my best...")
    }
    self.index = love.math.random(1, #self.replicas)
end

function donate:unload()
    self.replicas = nil
end

function donate:update(delta_time)
end

function donate:control_button(command, menuState)
    if command == Command.Deny then
        menuState.current = menuState.chooseMenu
    end
    
    self.index = love.math.random(1, #self.replicas)
end

function donate:draw()
    local offsetX = love.graphics.getWidth()/2 - self.replicas[self.index]:getWidth()
    local offsetY = love.graphics.getHeight()/2 - self.replicas[self.index]:getHeight()/2
    
    love.graphics.draw(self.replicas[self.index], offsetX,  offsetY)
end

return donate