local obj = {
    id = 3,
    image = love.graphics.newImage("asserts/world/objects/dev_room/monk.png"),
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
        "Создавая проект в сжатые сроки - готовьте сраки...",
        "Может когда то все же будет патч...",
        "В общем - пиши нам, разрабам, если чё, не стесняйся ;)"
    }
    moving:startDialogue(replicas)
end

function obj:update(dt)
end

function obj:draw(tileSide)
    love.graphics.draw(self.image, tileSide * self.position.x, tileSide * self.position.y)
end

return obj