local obj = {
    id = 2,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/door.png"), 48, 48, 0.1, 3),
    isPassable = true,
    position = {},
    width = 1,
    height = 1,
}

obj.animation:stop()
obj.timer = 0
obj.timeEnd = 0.3

function obj:onCollide()
    self.animation:play()
end

function obj:update(dt)
    if self.animation.playing then
        self.animation:update(dt)
        self.timer = self.timer + dt
        
        if self.timer >= self.timeEnd then
            Scene.Load("world")
        end
    end
end

function obj:draw(tileSide)
    self.animation:draw(tileSide * self.position.x, tileSide * self.position.y)
end

return obj