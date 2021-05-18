local obj = {
    id = 9,
    image = love.graphics.newImage("asserts/world/objects/dev_room/tree_big.png"),
    isPassable = false,
    position = {},
    width = 2,
    height = 3,

    physics = {
        size = {
            x = 96,
            y = 144
        },
        offset = {
            x = 48,
            y = 72
        }
    }
}

function obj:init(initData)
    self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
    self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
end

function obj:update(dt)
end

function obj:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.draw(self.image, self.position.x, self.position.y)
end

return obj