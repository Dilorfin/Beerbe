require "animation"

local characterAnimation  = {
    states = {
        upward = 1,
        downward = 2,
        leftward = 3,
        rightward = 4
    }
}
local character = require "character"

function characterAnimation:load()
    local heroFilenames = {
        "asserts/world/animations/upward.png",
        "asserts/world/animations/downward.png",
        "asserts/world/animations/leftward.png",
        "asserts/world/animations/rightward.png"
    }
    local heroSourceImage = love.graphics.newArrayImage(heroFilenames)
    self.animation = newAnimation(heroSourceImage, 48, 48, 0.11, 3)
    self.animation:setMode("bounce")

    self:setState("downward")
    self:stop()
end

function characterAnimation:unload()
    self.animation = nil
end

function characterAnimation:play()
    self.animation:play()
end
function characterAnimation:stop()
    self.animation:stop()
end

function characterAnimation:setState(st)
    self.state = self.states[st]
end

function characterAnimation:update(dt)
    self.animation:update(dt)
end

function characterAnimation:draw()
    self.animation:drawLayer(self.state, character.position.x, character.position.y, 0, 1)
end

return characterAnimation