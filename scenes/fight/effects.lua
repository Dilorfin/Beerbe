require "animation"

local effects = {}

local files = {
    hit = "asserts/fight/effects/hit.png",
    sword = "asserts/fight/effects/sword.png"
}

effects.animations = {
    hit = newAnimation(love.graphics.newImage(files["hit"]), 192, 192, 0.035, 6),
    sword = newAnimation(love.graphics.newImage(files["sword"]), 192, 192, 0.035, 6),
    --thunder = newAnimation(love.graphics.newImage(files["thunder"]), 192, 192, 0.035, 6)
}

for k, v in pairs(effects.animations) do
    --v:setMode("once")
end

function effects:start(effects, slot)
    local slots = require "scenes/fight/slots"
    self.position = {}
    self.position.x = slots[slot].x - 0.035 * love.graphics.getWidth()
    self.position.y = slots[slot].y - 0.075*love.graphics.getHeight()

    self.animation = self.animations[effects]
    self.animation:play()
end

function effects:isPlaying()
    return self.animation.playing
end

function effects:update(dt)
    self.animation:update(dt)
end
function effects:draw()
    self.animation:draw(self.position.x, self.position.y+0.025*love.graphics.getWidth(), 0, 0.00117*love.graphics.getHeight())
end

return effects