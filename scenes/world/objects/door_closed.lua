local obj = {
    id = 15,
    animation = newAnimation(love.graphics.newImage("assets/world/objects/door.png"), 48, 48, 0.1, 3),
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
    
    self.animation:stop()

    self.infoText = "Talk to The Door?"
end

function obj:onStartCollide(movable)
    if not movable.character or movable.character.name ~= "Hero" then
        return nil
    end

    return { 
        type = "show_info",
        text = self.infoText,
        onConfirm = function()
            
            events:push({
                type = "start_dialogue",
                replicas = { "The door is closed." }
            })
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
end

function obj:draw(camera)
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    self.animation:draw(self.position.x, self.position.y)
end

return obj