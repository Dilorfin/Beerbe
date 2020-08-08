local obj = {
    id = 1,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/lamp.png"), 48, 96, 0.1, 3),
    isPassable = false,
    position = {},
    width = 1,
    height = 2,
}

function obj:onCollide()
end

function obj:update(dt)
    self.animation:update(dt)
end

function obj:draw(tileSide)
    self.animation:draw(tileSide * self.position.x, tileSide * self.position.y)
end

return obj