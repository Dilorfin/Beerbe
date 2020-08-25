local obj = {
    id = 13,
    image = love.graphics.newImage("asserts/world/objects/styled/growths_small.png"),
    isPassable = false,
    position = {},
    width = 1,
    height = 1,
}

function obj:init(styleId)
    self.frame = love.graphics.newQuad((styleId)*48, 0, 48, 48, self.image:getWidth(), self.image:getHeight())
end

function obj:onCollide(moving)
end

function obj:update(dt)
end

function obj:draw(tileSide)
    love.graphics.draw(self.image, self.frame, tileSide * self.position.x, tileSide * self.position.y)
end

return obj