local obj = {
    id = 9,
    image = love.graphics.newImage("asserts/world/objects/tree_big.png"),
    isPassable = false,
    position = {},
    width = 2,
    height = 3
}

function obj:onCollide(moving)
end

function obj:update(dt)
end

function obj:draw(tileSide)
    love.graphics.draw(self.image, tileSide * self.position.x, tileSide * self.position.y)
end

return obj