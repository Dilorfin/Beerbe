local camera = {
    x = -40,
    y = 0,
    scale = love.graphics.getHeight()/600
}

function camera:update(character)
    local globalX, globalY = love.graphics.inverseTransformPoint(love.graphics.getWidth(), love.graphics.getHeight())

    if character.position.x > globalX - 150 then
        self.x = self.x - (globalX - 150 - character.position.x)
    elseif character.position.x < self.x + 100 then
        self.x = character.position.x - 100
    end

    if character.position.y > globalY - 150 then
        self.y = self.y - (globalY - 150 - character.position.y)
    elseif character.position.y < self.y + 100 then
        self.y = character.position.y - 100
    end
end

function camera:influence()
    love.graphics.scale(self.scale)
    love.graphics.translate(-self.x, -self.y)
end

return camera