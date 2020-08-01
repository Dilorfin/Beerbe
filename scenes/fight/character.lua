require "animation"

local characterAnimation = {
    states = {
        stand = 1,
        attack = 2,
        protect = 3,
        cast = 4,
        die = 5,
    }
}

function characterAnimation:load()
    local heroFilenames = {
        "asserts/fight/animations/stand.png",
        "asserts/fight/animations/attack.png",
        "asserts/fight/animations/protect.png",
        "asserts/fight/animations/cast.png",
        "asserts/fight/animations/death.png"
    }
    local heroSourceImage = love.graphics.newArrayImage(heroFilenames)
    self.animation = newAnimation(heroSourceImage, 64, 64, 0.11, 3)
    
    local slots = require "scenes/fight/slots"
    self.animation.screenCoordinates = {}
    self.animation.screenCoordinates.x = slots[#slots].x
    self.animation.screenCoordinates.y = slots[#slots].y
    
    self:setState("stand")
end

function characterAnimation:unload()
    self.animation.screenCoordinates = nil
    self.animation = nil
end

function characterAnimation:setState(st)
    self.state = self.states[st]
    if st == "stand" then
        self.animation:setMode("bounce")
    elseif st == "cast" then
        self.animation:setMode("loop")
    else
        self.animation:setMode("once")
    end
    self.animation.direction = 1
    self.animation.position = 1
    self.animation:play()
end

function characterAnimation:update(dt)
    self.animation:update(dt)
end

function characterAnimation:draw()
    -- add scaling...
    local x = self.animation.screenCoordinates.x
    local y = self.animation.screenCoordinates.y
    self.animation:drawLayer(self.state, x, y, 0, love.graphics.getHeight()/600)
end

return characterAnimation