local obj = {
    id = 4,
    image = love.graphics.newImage("assets/world/objects/dev_room/coffin.png"),
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
    self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
    self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)

    self.infoText = "Talk to The Coffin?"
end

function obj:onStartCollide(movable)
    if not movable.character or movable.character.name ~= "Hero" then
        return nil
    end

    return { 
        type = "show_info",
        text = self.infoText,
        onConfirm = function()
            local possibleReplicas = {
                { "Никогда не поступайтесь собственной реальностью." },
                { "Самурай должен, прежде всего, постоянно помнить, что он может умереть в любой момент, и если такой момент настанет, то умереть самурай должен с честью. Вот его главное дело." },
                { "К смерти следует идти с ясным осознанием того, что надлежит делать самураю и что унижает его достоинство." },
                { "В делах повседневных помнить о смерти и хранить это слово в сердце." }
            }
            events:push({
                type = "start_dialogue",
                replicas = possibleReplicas[love.math.random(1, #possibleReplicas)]
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

function obj:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.draw(self.image, self.position.x, self.position.y)
end

return obj