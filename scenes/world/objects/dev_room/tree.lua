local obj = {
    id = 10,
    image = love.graphics.newImage("asserts/world/objects/dev_room/tree.png"),
    isPassable = false,
    position = {},
    width = 1,
    height = 2
}

function obj:onCollide(moving)
end

function obj:update(dt)
end

function obj:draw(tileSide)
    love.graphics.draw(self.image, tileSide * self.position.x, tileSide * self.position.y)
end

return obj