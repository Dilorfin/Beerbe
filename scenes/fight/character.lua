require "animation"

local character = require "character"
character.animation = {
    states = {
        stand = 1,
        attack = 2,
        protect = 3,
        cast = 4,
        die = 5,
    }
}

function character.animation:load()
    local heroFilenames = {
        "asserts/fight/animations/stand.png",
        "asserts/fight/animations/attack.png",
        "asserts/fight/animations/protect.png",
        "asserts/fight/animations/cast.png",
        "asserts/fight/animations/death.png"
    }
    local heroSourceImage = love.graphics.newArrayImage(heroFilenames)
    self.animation = newAnimation(heroSourceImage, 64, 64, 0.11, 3)
    
    self:setState("stand")
end

function character.animation:unload()
    character.animation = nil
end

function character.animation:setState(st)
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

function character.animation:update(dt)
    self.animation:update(dt)
end

function character.animation:draw()
    -- add scaling...
    self.animation:drawLayer(self.state, 0.75*love.graphics.getWidth(), 0.4166666666666667*love.graphics.getHeight(), 0, love.graphics.getHeight()/600)
end

return character