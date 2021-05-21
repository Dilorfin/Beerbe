local donate = {}

local font = love.graphics.getFont()
donate.replicas = {
    "Seriously?",
    "Not today!",
    "Hard? O.O",
    "I did my best..."
}
local index = love.math.random(1, #donate.replicas)
donate.text = love.graphics.newText(font, donate.replicas[index])

function donate:unload()
    self.replicas = nil
    self.text = nil
end

function donate:control_button(command)
    if command == Command.Deny then
        self.isClosed = true
    end
    
    local index = love.math.random(1, #self.replicas)
    self.text:set(self.replicas[index])
end

function donate:draw()
    local offsetX = love.graphics.getWidth()/2 - self.text:getWidth()
    local offsetY = love.graphics.getHeight()/2 - self.text:getHeight()/2
    
    love.graphics.draw(self.text, offsetX,  offsetY)
end

return donate