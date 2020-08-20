local obj = {
    id = 5,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/dev_room/portal.png"), 48, 48, 0.15, 12),
    isPassable = true,
    position = {},
    width = 1,
    height = 1,
}

function obj:onCollide(moving)
    moving.info.isShown = true
    moving.info.text = "Go to random room?"
    moving.info.onConfirm = self.onConfirm
end

function obj.onConfirm()
    character.position.room = love.math.random(1, character.position.last_room)
    Scene.Load("world")
end

function obj:update(dt)
    self.animation:update(dt)
end

function obj:draw(tileSide)
    self.animation:draw(tileSide * self.position.x, tileSide * self.position.y)
end

return obj