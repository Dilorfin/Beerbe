local obj = {
    id = 4,
    image = love.graphics.newImage("asserts/world/objects/dev_room/coffin.png"),
    isPassable = false,
    position = {},
    width = 1,
    height = 2,
}

function obj:onCollide(moving)
    moving.info.isShown = true
    moving.info.text = "Talk to The Coffin?"
    moving.info.onConfirm = self.onConfirm
end

function obj.onConfirm(moving)
    local possibleReplicas = {
        { "Самурай должен, прежде всего, постоянно помнить, что он может умереть в любой момент, и если такой момент настанет, то умереть самурай должен с честью. Вот его главное дело." },
        { "К смерти следует идти с ясным осознанием того, что надлежит делать самураю и что унижает его достоинство." },
        { "В делах повседневных помнить о смерти и хранить это слово в сердце." }
    }
    moving:startDialogue(possibleReplicas[love.math.random(1, #possibleReplicas)])
end

function obj:update(dt)
end

function obj:draw(tileSide)
    love.graphics.draw(self.image, tileSide * self.position.x, tileSide * self.position.y)
end

return obj