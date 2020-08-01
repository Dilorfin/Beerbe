require "animation"

local character = require "character"
character.animation = {
    states = {
        upward = 1,
        downward = 2,
        leftward = 3,
        rightward = 4
    }
}

function character.animation:load()
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

function character.animation:unload()
    self.animation = nil
end

function character.animation:play()
    self.animation:play()
end
function character.animation:stop()
    self.animation:stop()
end

function character.animation:setState(st)
    self.state = self.states[st]
end

function character.animation:update(dt)
    self.animation:update(dt)
end

function character.animation:draw()
    self.animation:drawLayer(self.state, character.position.x, character.position.y, 0, 1)
end

return character