local obj = {
    id = 6,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/jukebox.png"), 48, 96, 0.3, 3),
    isPassable = false,
    position = {},
    width = 1,
    height = 2,
}

function obj:onCollide(moving)
    moving.info.isShown = true
    moving.info.text = "Do you wanna listen some song?"
    moving.info.onConfirm = self.onConfirm
end

function obj.onConfirm(moving)
    local replicas = {
        "Somebody mixed my medicine",
        "Somebody mixed my medicine",

        "Well, you hurt where you sleep and you sleep where you lie",
        "And now you're in deep and now you're gonna cry",
        "Got a woman to your left and a boy to your right",
        "You start to sweat so hold me tight ('cause)",

        "Somebody mixed my medicine",
        "I don't know what I'm on",
        "Somebody mixed my medicine",
        "Now baby, it's all gone",
        "Somebody mixed my medicine",
        "And somebody's in my head again",
        "And somebody mixed my medicine again, again",

        "Well, I'll drink what you leak and I'll smoke what you sigh",
        "See across the room with a look in your eye",
        "Got a man to his left and a girl to his right",
        "I start to sweat so hold me tight",

        "Somebody mixed my medicine",
        "I don't know what I'm on",
        "Somebody mixed my medicine",
        "Now baby, it's all gone",
        "Somebody mixed my medicine",
        "And somebody's in my head again",
        "And somebody mixed my medicine again, again"
    }
    moving:startDialogue(replicas)
end

function obj:update(dt)
    self.animation:update(dt)
end

function obj:draw(tileSide)
    self.animation:draw(tileSide * self.position.x, tileSide * self.position.y)
end

return obj