local obj = {
    id = 7,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/chest_dev.png"), 48, 96, 0.1, 3),
    isPassable = false,
    position = {},
    width = 1,
    height = 1,
    isOpened = false
}

obj.animation:stop()
obj.animation:setMode("once")

function obj:onCollide(moving)
    if not self.isOpened then
        moving.info.isShown = true
        moving.info.text = "Open chest?"
        moving.info.onConfirm = self.onConfirm
    end
end

function obj.onConfirm(moving)

    
    obj.animation:play()
    obj.isOpened = true
end

function obj:update(dt)
    self.animation:update(dt)
end

function obj:draw(tileSide)
    self.animation:draw(tileSide * self.position.x, tileSide * self.position.y)
end

return obj