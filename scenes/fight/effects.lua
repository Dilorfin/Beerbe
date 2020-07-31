require "animation"

local effects = {}

local files = {
    hit = "asserts/fight/effects/hit.png",
    sword = "asserts/fight/effects/sword.png",
    thunder = "asserts/fight/effects/sword.png"
}

effects.animations = {
    hit = newAnimation(love.graphics.newImage(files["hit"]), 192, 192, 0.05, 6),
    sword = newAnimation(love.graphics.newImage(files["sword"]), 192, 192, 0.05, 6),
    thunder = newAnimation(love.graphics.newImage(files["thunder"]), 192, 192, 0.1, 5)
}

for k, v in pairs(effects.animations) do
    v:setMode("once")
end

function effects:start(effects, slot)
    local slots = require "scenes/fight/slots"
    self.position = {}
    self.position.x = slots[slot].x
    self.position.y = slots[slot].y

    if slot == #slots then
        self.position.x = self.position.x - 0.035 * love.graphics.getWidth()
        self.position.y = self.position.y - 0.075*love.graphics.getHeight()
    end

    self.animation = self.animations[effects]
    self.animation:play()
    if self.animation:getCurrentFrame() ~= 0 then
        self.animation:reset()
    end
end

function effects:isPlaying()
    return self.animation.playing
end

function effects:update(dt)
    if self.animation then
        self.animation:update(dt)
    end
end
function effects:draw()
    if self.animation then
        self.animation:draw(self.position.x, self.position.y+0.025*love.graphics.getWidth(), 0, 0.00117*love.graphics.getHeight())
    end
end

return effects