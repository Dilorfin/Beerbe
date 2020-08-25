local obj = {
    id = 15,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/door.png"), 48, 48, 0.1, 3),
    isPassable = true,
    position = {},
    width = 1,
    height = 1,
}

obj.animation:stop()

function obj:onCollide(moving)
    moving.info.isShown = true
    moving.info.text = "Talk to The Door?"
    moving.info.onConfirm = self.onConfirm
end

function obj.onConfirm(moving)
    local replicas = { "The door is closed." }
    moving:startDialogue(replicas)
end

function obj:update(dt)
end

function obj:draw(tileSide)
    self.animation:draw(tileSide * self.position.x, tileSide * self.position.y)
end

return obj