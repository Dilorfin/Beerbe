require "utils/animation"

local effects = {}

local files = {
    hit = "assets/fight/effects/hit.png",
    sword = "assets/fight/effects/sword.png",
    thunder = "assets/fight/effects/thunder.png"
}

effects.animations = {
    hit = newAnimation(love.graphics.newImage(files["hit"]), 192, 192, 0.05, 6),
    sword = newAnimation(love.graphics.newImage(files["sword"]), 192, 192, 0.05, 6),
    thunder = newAnimation(love.graphics.newImage(files["thunder"]), 192, 192, 0.1, 5)
}

for k, v in pairs(effects.animations) do
    v:setMode("once")
end

function effects:start(effect, position)
    self.position = {}
    self.position.x = position.x
    self.position.y = position.y

    -- wtf? is used only for character attacked
    if effect == "hit" then
        self.position.x = self.position.x - 0.035 * love.graphics.getWidth()
        self.position.y = self.position.y - 0.075 * love.graphics.getHeight()
    end

    if effect == "thunder" then
        self.position.x = self.position.x - 0.01875 * love.graphics.getWidth()
        self.position.y = self.position.y - 0.042 * love.graphics.getHeight()
    end

    self.animation = self.animations[effect]
    self.animation:play()
    if self.animation:getCurrentFrame() ~= 0 then
        self.animation:reset()
    end
end

function effects:isPlaying()
    if self.animation then
        return self.animation.playing
    end
    return false
end

function effects:update(dt)
    if self.animation then
        self.animation:update(dt)
        if not self.animation.playing then
            self.animation = nil
            events:push("end_effect")
        end
    end
end
function effects:draw()
    if self.animation then
        self.animation:draw(self.position.x, self.position.y+0.025*love.graphics.getWidth(), 0, 0.00117*love.graphics.getHeight())
    end
end

return effects