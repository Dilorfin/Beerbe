local obj = {
    id = 7,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/dev_room/chest_dev.png"), 48, 96, 0.1, 3),
    isPassable = false,
    position = {},
    width = 1,
    height = 1,
    isOpened = false
}

local character = require "character"
local items = require "items"

obj.animation:stop()
obj.animation:setMode("once")

function obj:onCollide(moving)
    if not self.isOpened then
        moving.info.isShown = true
        moving.info.text = "Open dev chest?"
        moving.info.onConfirm = self.onConfirm
    end
end

local function getReplicas(itemsToGive)
    local replicas = {}
    for i = 1, #itemsToGive do
        replicas[#replicas+1] = "You got \""..items[itemsToGive[i]].title.."\""
    end
    return replicas
end

function obj.onConfirm(moving)
    local itemsToGive = { 5, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}

    for i = 1, #itemsToGive do
        character.bag[#character.bag + 1] = itemsToGive[i]
    end
    
    obj.animation:play()
    obj.isOpened = true
    local replicas = {
        "You got \"Go with beer sword\"",
        "You got \"Beer 1l\" x10"
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