local target = {
    index = 1,
    rotate = 0,
    spell = ""
}

target.image = love.graphics.newImage("asserts/fight/select.png")

target.positions = {}

local slots = require "scenes/fight/slots"
for i = 1, #slots - 1 do
    target.positions[i] = {}
    target.positions[i].x = slots[i].x - 0.0125*love.graphics.getWidth()
    target.positions[i].y = slots[i].y + 0.016667*love.graphics.getHeight()
end

target.character = {}
target.character.id = #slots
target.character.position = {}
target.character.position.x = slots[#slots].x
target.character.position.y = slots[#slots].y

function target:left(enemies)
    self.index = self.index - 1
    if self.index <= 0 then
        self.index = #enemies
    end
end
function target:right(enemies)
    self.index = self.index + 1
    if self.index > #enemies then
        self.index = 1
    end
end

function target:draw(enemies)
    love.graphics.draw(self.image, self.positions[enemies[self.index].slot].x, self.positions[enemies[self.index].slot].y, 0, love.graphics.getHeight()/1200)
end

return target