local obj = {
    id = -12,
    image = love.graphics.newImage("assets/world/objects/styled/down-to-earth.png"),
    position = {},
    width = 1,
    height = 1
}

function obj:init(initData)
    self.frame = love.graphics.newQuad((initData.styleId)*48, 0, 48, 48, self.image:getWidth(), self.image:getHeight())
end

function obj:onStartCollide(moving)
end

function obj:update(dt)
end

function obj:draw(camera)
    love.graphics.draw(self.image, self.frame, self.position.x, self.position.y)
end

return obj