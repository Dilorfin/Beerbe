local obj = {
    id = 8,
    animation = newAnimation(love.graphics.newImage("assets/world/objects/lamp_dev.png"), 48, 96, 0.1, 3),
    position = {},
    width = 1,
    height = 2,

    physics = {
        size = {
            x = 48,
            y = 96--72
        },
        offset = {
            x = 24,
            y = 48--60
        }
    }
}

function obj:init(initData)
    self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
    self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)

    self.infoText = "Random?"
end

function obj:onStartCollide(movable)
    if not movable.character or movable.character.name ~= "Hero" then
        return nil
    end

    return { 
        type = "show_info",
        text = self.infoText,
        onConfirm = function()
            character.position.dev = true
            events:push("next_level")
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