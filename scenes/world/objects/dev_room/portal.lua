local obj = {
    id = 5,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/dev_room/portal.png"), 48, 48, 0.15, 12),
    isPassable = true,
    position = {},
    width = 1,
    height = 1,

    physics = {
        size = {
            x = 48,
            y = 48
        },
        offset = {
            x = 24,
            y = 24
        }
    }
}

function obj:init(initData)
    self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
    self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.fixture:setSensor(true)
    
    self.infoText = "Go to random room?"
end

function obj:onStartCollide(movable)
    return { 
        type = "show_info",
        text = self.infoText,
        onConfirm = function()
            character.position.dev = false
            events:push("next_room")
        end
    }
end

function obj:onEndCollide(movable)
    return {
        type = "close_info",
        text = self.infoText
    }
end

function obj:update(dt)
    self.animation:update(dt)
end

function obj:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    self.animation:draw(self.position.x, self.position.y)
end

return obj