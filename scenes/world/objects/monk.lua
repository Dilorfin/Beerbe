local obj = {
    id = 3,
    image = love.graphics.newImage("asserts/world/objects/monk.png"),
    isPassable = false,
    position = {},
    width = 1,
    height = 1,
}

function obj:onCollide(moving)
    moving.info.isShown = true
    moving.info.text = "Talk to The Monk?"
    moving.info.onConfirm = self.onConfirm
end

function obj.onConfirm(moving)
    local replicas = {
        "Никогда не поступайтесь собственной реальностью."
    }
    moving:startDialogue(replicas)
end

function obj:update(dt)
end

function obj:draw(tileSide)
    love.graphics.draw(self.image, tileSide * self.position.x, tileSide * self.position.y)
end

return obj