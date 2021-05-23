local obj = {
    id = 14,
    image = love.graphics.newImage("assets/world/objects/styled/growths_big.png"),
    position = {},
    width = 1,
    height = 2,

    physics = {
        size = {
            x = 48,
            y = 96
        },
        offset = {
            x = 24,
            y = 48
        }
    }
}

function obj:init(initData)
    local tileSide = 48

    self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
    self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)

    self.frame = love.graphics.newQuad((initData.styleId)*tileSide, 0, tileSide, 2*tileSide, self.image:getWidth(), self.image:getHeight())
end

function obj:onStartCollide(moving)
end

function obj:update(dt)
end

function obj:draw(camera)
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.draw(self.image, self.frame, self.position.x, self.position.y)
end

return obj