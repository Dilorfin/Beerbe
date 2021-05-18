local target = {
    index = 1,
    spell = ""
}

target.image = love.graphics.newImage("asserts/fight/select.png")

local actors = love.filesystem.load("scenes/fight/actors.lua")()

function target:control_button(command)
    if command == Command.Left then
        self:left()
    elseif command == Command.Right then
        self:right()
    end
end

function target:left()
    self.index = self.index - 1
    if self.index <= 0 then
        self.index = actors:getEnemiesNumber()
    end
end

function target:right()
    self.index = self.index + 1
    if self.index > actors:getEnemiesNumber() then
        self.index = 1
    end
end

function target:draw(enemies)
    local pos = actors:getPositionById(self.index)
    love.graphics.draw(self.image, pos.x- 0.0125*love.graphics.getWidth(), pos.y+ 0.016667*love.graphics.getHeight(), 0, love.graphics.getHeight()/1200)
end

return target